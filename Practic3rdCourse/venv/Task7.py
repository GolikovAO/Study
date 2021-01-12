from random import *
from tkinter import *

# Создаем окно и виджет Canvas
size = 400
window = Tk()
window.title('Узор')
canvas = Canvas(window, width = size, height = size)
canvas.pack()
count = 0

# Цикл заполняет окно случайными кругами
while count < 750:
    # Выбираем цвет из списка случайном образом
    colors = choice(['aqua', 'blue', 'fuchsia', 'green', 'maroon', 'orange',
                  'pink', 'purple', 'red', 'yellow', 'violet', 'indigo', 'chartreuse', 'lime', 'aquamarine'])
    # Задаем позицию и размер фигуры случайными значениями
    x = randint(0, size)
    y = randint(0, size)
    d = randint(0, size/5)
    # Создаем круг по заданным параметрам
    canvas.create_oval(x - d/2, y - d/2, x + d/2, y + d/2, fill = colors)
    # Обновляем окно
    window.update()
    count += 1
window.mainloop()