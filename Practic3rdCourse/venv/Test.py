from tkinter import *
window = Tk()
window.geometry('400x200')
image = PhotoImage(file = 'sgu.gif')
button = Button(window, image = image)
button.pack()
window.mainloop()
