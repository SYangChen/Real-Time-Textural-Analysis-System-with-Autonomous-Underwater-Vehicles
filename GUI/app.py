import tkinter as tk
from PIL import Image, ImageTk
import numpy as np
import os
import time

class MyAPP():
    def __init__(self):
        self.window = tk.Tk()
        self.window.title('Classification Results')
        self.window.geometry('1000x800')
        self.window.attributes('-topmost',1)
        #self.window.attributes('-fullscreen', True)
        self.window.configure(background='white')
        self.classify = 0
        np.save('data',np.array(0))
        button = tk.Button(self.window, text='Close', command=self.CloseWindow)
        button.place(x=0,y=0)

        image = Image.open(os.getcwd()+'/init/init.jpg')
        image.save('result.png')

        left = Image.open(os.getcwd()+'/init/empty.jpg')
        left.save('left.jpg')

        right = Image.open(os.getcwd()+'/init/#init.jpg')
        right.save('right.jpg')

        self.background()
        self.update_image()
        self.window.mainloop()

    def background(self):
        screenwidth = self.window.winfo_screenwidth()
        screenheight = self.window.winfo_screenheight()
        self.canvas = tk.Canvas(self.window, width=screenwidth, height=screenheight-90,bg='white')
        self.canvas.pack(side='bottom')

        bgp = Image.open(os.getcwd()+'/img/sea.PNG').resize((screenwidth,screenheight-90))
        self.pic = ImageTk.PhotoImage(bgp, master=self.window)
        self.canvas.create_image(0,0,anchor='nw',image=self.pic)

    def update_image(self):
        try:
            image = Image.open('result.png').resize((800, 600))
            self.photo1 = ImageTk.PhotoImage(image, master=self.window)
            self.canvas.create_image(530,123,anchor='nw',image=self.photo1)

            Class = Image.open('left.jpg').resize((250, 600))
            self.photo2 = ImageTk.PhotoImage(Class, master=self.window)
            self.canvas.create_image(280,123,anchor='nw',image=self.photo2)

            info = Image.open('right.jpg').resize((250, 600))
            self.photo3 = ImageTk.PhotoImage(info, master=self.window)
            self.canvas.create_image(1320,123,anchor='nw',image=self.photo3)

            self.classify = np.load('data.npy')
            self.window.after(300, self.update_image)
        except:
            time.sleep(0.4)
            self.update_image()

    def CloseWindow(self):
        self.window.destroy()

app=MyAPP()
