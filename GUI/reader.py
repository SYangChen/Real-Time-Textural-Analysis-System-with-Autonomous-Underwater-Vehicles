from matplotlib import pyplot as plt
from PIL import Image, ImageTk
import numpy as np
import time
import os

t = np.arange(1, 31, 1)
value = [None]*30
counter = 0
setting = 1

plt.ion()
plt.rcParams['figure.figsize'] = (12, 8)
while 1:
    #time.sleep(1)
    x = input()
    x = int(x)
    try:
        #x = int(np.random.random()*10)%2+1
        #np.save('data',np.array(x))
        #x = np.load('data.npy')
        #x = int(x)
        left = Image.open(os.getcwd()+'/img/'+str(x)+'.jpg')
        left.save('left.jpg')
        right = Image.open(os.getcwd()+'/img/#'+str(x+2)+'.jpg')
        right.save('right.jpg')
        
        if counter>=30:
            t += 1
            value = value[1:]
            value.append(x)
            plt.xlim([t[0]-0.5,t[0]+29.5])
            setting = t[0]
        else:
            value[counter] = x
        counter += 1
        index = t[0]
        class_1 = []
        bDot = []
        class_2 = []
        rDot = []
        for i in value:
            if i == 1:
                class_1.append(index)
                bDot.append(i)
            elif i == 2:
                class_2.append(index)
                rDot.append(i)
            index += 1;
        plt.plot(np.array(class_1),np.array(bDot),'b.',marker='o',ms=10)
        plt.plot(np.array(class_2),np.array(rDot),'r.',marker='o',ms=10)
        plt.xlim([setting-0.5,setting+29.5])
        plt.xticks(t)
        plt.yticks(np.arange(1, 3, 1))
        plt.suptitle('Result',fontsize=30)
        plt.xlabel("Times",fontsize=13,fontweight='bold')
        plt.ylabel("Class",fontsize=13,fontweight='bold')
        plt.savefig('result.png')
        #plt.show()
    except:
        print('exit')
        break
