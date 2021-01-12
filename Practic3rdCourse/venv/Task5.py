from tkinter import *

# функция перевода км в мили
def km_to_miles():
    km = float(km_entry.get())
    miles = km * 0.62
    result_miles["text"] = str(miles) + " мили"

# Функция перевода миль в км
def miles_to_km():
    miles = float(miles_entry.get())
    km = miles * 1.61
    result_km["text"] = str(km) + " км"

# Создание окна
window = Tk()
window.title("Конвертер")
window.resizable(width=False, height=False)

# Инициализация фреймов и их элементов
frame1 = Frame(window)
km_entry = Entry(frame1, width = 10)
miles_label = Label(frame1, text = "км")
frame2 = Frame(window)
miles_entry = Entry(frame2, width = 10)
km_label = Label(frame2, text = "мили")

# Разметка виджетов
km_entry.grid(row = 0, column = 0, sticky = "e")
miles_label.grid(row = 0, column = 1, sticky = "w")
miles_entry.grid(row = 1, column = 0, sticky = "e")
km_label.grid(row = 1, column = 1, sticky = "w")

convert_button1 = Button(window, text = "\N{RIGHTWARDS BLACK ARROW}", command = km_to_miles)
convert_button2 = Button(window, text = "\N{RIGHTWARDS BLACK ARROW}", command = miles_to_km)
result_miles = Label(window, text = "мили")
result_km = Label(window, text = "км")

# Разметка виджетов
frame1.grid(row = 0, column = 0, padx = 10)
convert_button1.grid(row = 0, column = 1, pady = 10)
result_miles.grid(row = 0, column = 2, padx = 10)
frame2.grid(row = 1, column = 0, padx = 10)
convert_button2.grid(row = 1, column = 1, pady = 10)
result_km.grid(row = 1, column = 2, padx = 10)

window.mainloop()