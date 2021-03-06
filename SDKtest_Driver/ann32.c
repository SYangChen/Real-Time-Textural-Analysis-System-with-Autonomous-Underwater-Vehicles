/*  ann32.c - The simplest kernel module.

* Copyright (C) 2013 - 2016 Xilinx, Inc
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation; either version 2 of the License, or
*   (at your option) any later version.

*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License along
*   with this program. If not, see <http://www.gnu.org/licenses/>.

*/
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/interrupt.h>

#include <linux/cdev.h>
#include <linux/workqueue.h>	//Complete
#include <linux/dma-mapping.h>	//DMA

#include <linux/of_address.h>
#include <linux/of_device.h>
#include <linux/of_platform.h>

#define WRITE_RESET 0	// Unuse 0
#define WRITE_INSIGN 1	// WRITE_R 1
#define WRITE_INDATA 2	// WRITE_Z 2
// #define WRITE_C 3
// #define WRITE_I 4
// #define WRITE_W 5
#define READ_CATEGORY 3	// READ_O 6
// #define READ_ALL 7
#define ERROR 4

//Sizeof(int)
#define OFFSET 			0x04

/* Standard module information, edit as appropriate */
MODULE_LICENSE("GPL");
MODULE_AUTHOR
    ("Xilinx Inc.");
MODULE_DESCRIPTION
    ("ann32 - loadable module template generated by petalinux-create -t modules");

#define DRIVER_NAME "ann32"

/* Simple example of how to receive command line parameters to your module.
   Delete if you don't need them */
unsigned myint = 0xdeadbeef;
char *mystr = "default";

module_param(myint, int, S_IRUGO);
module_param(mystr, charp, S_IRUGO);

struct ann32_local {
	unsigned long mem_start;
	unsigned long mem_end;
	void __iomem *base_addr;
	struct device *plat_dev_p; //Pointer of Platform Device

	//Char Device
	struct device *char_dev_p; //Pointer of Char Device
	dev_t dev_node;
	struct cdev cdev;
	struct class *class_p;

	//Interrupt
	struct completion cmp;

	//DRAM Pointer
	dma_addr_t   phys_addr;
	void         *virt_addr;
};

static long ioctl(struct file *file_p, unsigned int cmd, unsigned long arg)
{
    struct ann32_local *lp = (struct ann32_local *)file_p->private_data;
	unsigned long timeout;
	short *tmp16;

    switch(cmd){
		case WRITE_RESET:
			iowrite32(arg, (void __iomem *) (lp->base_addr+(WRITE_RESET-1)*OFFSET));
			break;
        case WRITE_INSIGN:
			iowrite32(arg, (void __iomem *) (lp->base_addr+(WRITE_INSIGN-1)*OFFSET));
			break;
        case WRITE_INDATA:
			iowrite32(arg, (void __iomem *) (lp->base_addr+(WRITE_INDATA-1)*OFFSET));
			break;
        // case WRITE_I:
		// 	iowrite32(arg, (void __iomem *) (lp->base_addr+(WRITE_I-1)*OFFSET));
		// 	break;
        // case WRITE_W:
		// 	iowrite32(arg, (void __iomem *) (lp->base_addr+(WRITE_W-1)*OFFSET));
		// 	break;
		case READ_CATEGORY:
			return (long)ioread32((void __iomem *) (lp->base_addr+(READ_CATEGORY-1)*OFFSET));
		// case READ_ALL:
		// 	return (long)ioread32((void __iomem *) (lp->base_addr+(arg-1)*OFFSET));
        default:
			printk("  [error] ann32 Driver: No Such Command\n");
			return -2;
	}
	return 0;
}

static int open(struct inode *ino, struct file *file_p)
{
	file_p->private_data = container_of(ino->i_cdev, struct ann32_local, cdev);
	return 0;
}

static int mmap(struct file *file_p, struct vm_area_struct *vma)
{
	struct ann32_local *lp = (struct ann32_local *)file_p->private_data;
	//return dma_mmap_coherent(lp->plat_dev_p, vma,
	//	lp->virt_addr, lp->phys_addr, vma->vm_end - vma->vm_start);
	return remap_pfn_range(vma, vma->vm_start, lp->phys_addr>>PAGE_SHIFT, vma->vm_end - vma->vm_start, vma->vm_page_prot);
}

static struct file_operations dm_fops = {
	.owner    = THIS_MODULE,
	.open     = open,
	.mmap	  = mmap,
	.unlocked_ioctl = ioctl,
};

//-----------------------------------------------------------------------
// Char Device Enable
//-----------------------------------------------------------------------
static int cdevice_init(struct ann32_local *lp)
{
	int rc;
	static struct class *local_class_p = NULL;
	/* Allocate a character device from the kernel for this driver.
	 */
	rc = alloc_chrdev_region(&lp->dev_node, 0, 1, DRIVER_NAME);
	if (rc) {
		dev_err(lp->plat_dev_p, "unable to get a char device number\n");
		return rc;
	}
	/* Initialize the device data structure before registering the character 
	 * device with the kernel.
	 */
	cdev_init(&lp->cdev, &dm_fops);
	lp->cdev.owner = THIS_MODULE;

	rc = cdev_add(&lp->cdev, lp->dev_node, 1);
	if (rc) {
		dev_err(lp->plat_dev_p, "unable to add char device\n");
		goto init_error1;
	}
	/* Only one class in sysfs is to be created for multiple chann32els,
	 * create the device in sysfs which will allow the device node
	 * in /dev to be created
	 */
	if (!local_class_p) {
		local_class_p = class_create(THIS_MODULE, DRIVER_NAME);
		if (IS_ERR(lp->plat_dev_p->class)) {
			dev_err(lp->plat_dev_p, "unable to create class\n");
			rc = ERROR;
			goto init_error2;
		}
	}
	lp->class_p = local_class_p;
	/* Create the device node in /dev so the device is accessible
	 * as a character device
	 */
	lp->char_dev_p = device_create(lp->class_p, NULL,
					  	 lp->dev_node, NULL, DRIVER_NAME);
	if (IS_ERR(lp->plat_dev_p)) {
		dev_err(lp->plat_dev_p, "unable to create the char device\n");
		goto init_error3;
	}
	return 0;

init_error3:
	class_destroy(lp->class_p);

init_error2:
	cdev_del(&lp->cdev);

init_error1:
	unregister_chrdev_region(lp->dev_node, 1);
	return rc;
}

//-----------------------------------------------------------------------
// Char Device Disable
//-----------------------------------------------------------------------
static void cdevice_exit(struct ann32_local *lp)
{
	if (lp->char_dev_p) {
		device_destroy(lp->class_p, lp->dev_node);
		class_destroy(lp->class_p);
		cdev_del(&lp->cdev);
		unregister_chrdev_region(lp->dev_node, 1);
	}
}

static int ann32_probe(struct platform_device *pdev)
{
	struct resource *r_mem; /* IO mem resources */
	struct device *dev = &pdev->dev;
	struct ann32_local *lp = NULL;

	int rc = 0;
	dev_info(dev, "Device Tree Probing\n");
	/* Get iospace for the device */
	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!r_mem) {
		dev_err(dev, "invalid address\n");
		return -ENODEV;
	}
	lp = (struct ann32_local *) kmalloc(sizeof(struct ann32_local), GFP_KERNEL);
	if (!lp) {
		dev_err(dev, "Cound not allocate ann32 device\n");
		return -ENOMEM;
	}
	dev_set_drvdata(dev, lp);
	lp->mem_start = r_mem->start;
	lp->mem_end = r_mem->end;

	if (!request_mem_region(lp->mem_start,
				lp->mem_end - lp->mem_start + 1,
				DRIVER_NAME)) {
		dev_err(dev, "Couldn't lock memory region at %p\n",
			(void *)lp->mem_start);
		rc = -EBUSY;
		goto error1;
	}

	lp->base_addr = ioremap(lp->mem_start, lp->mem_end - lp->mem_start + 1);
	if (!lp->base_addr) {
		dev_err(dev, "ann32: Could not allocate iomem\n");
		rc = -EIO;
		goto error2;
	}

	dev_info(dev,"ann32 at 0x%08x mapped to 0x%08x\n",
		(unsigned int __force)lp->mem_start,
		(unsigned int __force)lp->base_addr);
		
	lp->plat_dev_p = &pdev->dev;
	rc = cdevice_init(lp);
	if(rc) {
		dev_err(dev, "Char device initial failed!\n");
		goto error3;
	}
	return 0;
	
error3:
	cdevice_exit(lp);
error2:
	release_mem_region(lp->mem_start, lp->mem_end - lp->mem_start + 1);
error1:
	kfree(lp);
	dev_set_drvdata(dev, NULL);
	return rc;
}

static int ann32_remove(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct ann32_local *lp = dev_get_drvdata(dev);
	cdevice_exit(lp);
	iounmap(lp->base_addr);
	release_mem_region(lp->mem_start, lp->mem_end - lp->mem_start + 1);
	kfree(lp);
	dev_set_drvdata(dev, NULL);
	return 0;
}

#ifdef CONFIG_OF
static struct of_device_id ann32_of_match[] = {
	{ .compatible = "xlnx,myip-ann32-1.0", },
	{ /* end of list */ },
};
MODULE_DEVICE_TABLE(of, ann32_of_match);
#else
# define ann32_of_match
#endif


static struct platform_driver ann32_driver = {
	.driver = {
		.name = DRIVER_NAME,
		.owner = THIS_MODULE,
		.of_match_table	= ann32_of_match,
	},
	.probe		= ann32_probe,
	.remove		= ann32_remove,
};

static int __init ann32_init(void)
{
	printk("<1>Hello module world.\n");
	printk("<1>Module parameters were (0x%08x) and \"%s\"\n", myint,
	       mystr);

	return platform_driver_register(&ann32_driver);
}


static void __exit ann32_exit(void)
{
	platform_driver_unregister(&ann32_driver);
	printk(KERN_ALERT "Goodbye module world.\n");
}

module_init(ann32_init);
module_exit(ann32_exit);
