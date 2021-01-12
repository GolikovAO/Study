from tkinter import *

window = Tk()
window.geometry('300x300')
window.title('Tkinter')

def show_label(event):
    # Инициализация Label с выбранными параметрами
    label = Label(window, text='Hello World', bg = bgcolor.get(), fg = textcolor.get())
    label.place(anchor = CENTER, relx = 0.5, rely = 0.5)
    # Cкрытие ненужных элементов
    button.place_forget()
    frame1.pack_forget()
    frame2.pack_forget()

button = Button(window, text = 'Hi!', width = '10', height = '2')

# Инициализация фреймов
frame1 = Frame(window)
frame2 = Frame(window)
label_colorbg = Label(frame1, text = 'Цвет фона:')
label_colortext = Label(frame2, text ='Цвет текста:')
# Переменные, которые хранят выбранные RadioButon
bgcolor = StringVar()
textcolor = StringVar()
 # Задаем варианты по умолчанию
bgcolor.set('black')
textcolor.set('white')

# Инициализация RadioButton
radiobutton1 = Radiobutton(frame1, text = 'Желтый', variable = bgcolor, value = 'yellow')
radiobutton2 = Radiobutton(frame1, text = 'Зеленый', variable = bgcolor, value = 'green')
radiobutton3 = Radiobutton(frame1, text = 'Черный', variable = bgcolor, value = 'black')
radiobutton4 = Radiobutton(frame2, text = 'Красный', variable = textcolor, value = 'red')
radiobutton5 = Radiobutton(frame2, text = 'Голубой', variable = textcolor, value = 'aquamarine')
radiobutton6 = Radiobutton(frame2, text = 'Белый', variable = textcolor, value = 'white')
button.bind('<Button-1>', show_label)

# Размещение виджетов
frame1.pack()
label_colorbg.pack()
radiobutton1.pack()
radiobutton2.pack()
radiobutton3.pack()
frame2.pack()
label_colortext.pack()
radiobutton4.pack()
radiobutton5.pack()
radiobutton6.pack()
button.place(anchor = S, relx = 0.5, rely = 1)
window.mainloop()