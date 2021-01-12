from tkinter import *
window = Tk()
window.geometry('200x200')  # Создаем окно размером 200х200
window.title('Tkinter')  # Задаем название заголовка

def show_label(event):
    label = Label(window, text='Hello World') # Инициализация Label
    label.place(anchor = CENTER, relx = 0.5, rely = 0.5) # Размещение Label
    button.place_forget() # Убираем кнопку из окна

button = Button(window, text = 'Hi!', width = '10', height = '2')  # Инициализация кнопки
button.bind('<Button-1>', show_label)   # Событие, при нажатии л.кн. мыши вызывает функцую
button.place(anchor = CENTER, relx = 0.5, rely = 0.5) # Размещение кнопки
window.mainloop()