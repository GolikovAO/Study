from tkinter import *
import random

# функция выбирает случайное число из диапозона
def randomize():
    a = int(a_entry.get())
    b = int(b_entry.get())
    result_label["text"] = str(random.randint(a, b))

window = Tk()
window.title("Рандомайзер")
a_label = Label(window, text = "a=")
b_label = Label(window, text = "b=")
a_entry = Entry(window, width = 5)
b_entry = Entry(window, width = 5)

rand_button = Button(text="Генерировать", command=randomize)
result_label = Label(window)
a_label.grid(row = 0, column = 0, padx = 10)
a_entry.grid(row = 0, column = 1, padx = 1)
b_label.grid(row = 0, column = 3, padx = 1)
b_entry.grid(row = 0, column = 4, padx = 10)
rand_button.grid(row = 2, column = 2, sticky = "nsew")
result_label.grid(row = 1, column = 2)

window.mainloop()