from tkinter import *
# Импортируем библиотеку для работы со временем
import time
window = Tk()
window.geometry('250x100')
window.title('Время')
# Создаем Label в указанном формате
clock = Label(window, font = ('times', 20, 'bold'), bg= 'black', fg = 'green')
clock.pack(fill = BOTH, expand = 1)

def tick():
# Забираем текущее время с компьютера
    time_now = time.strftime('%H:%M:%S')
# При изменении времени будем менять Label
    clock.config(text = time_now)
# Каждые 200 мс вызываем функцию - обновление времени
    clock.after(200, tick)

tick()
window.mainloop()