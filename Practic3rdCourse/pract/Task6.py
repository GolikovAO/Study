import pyodbc
from tkinter import *

# Создаем подключение к БД
cnxn = pyodbc.connect("Driver={ODBC Driver 17 for SQL Server};"
                      "Server=DESKTOP-RDIDH6R;"
                      "Database=Discount;"
                      "Trusted_Connection=yes;")
cursor = cnxn.cursor()

# Функция, которая выводит в отдельном окне содержимое таблицы БД -
# информацию о клиентах
def ViewClients():
    # Создаем новое окно
    window_clients = Tk()
    window_clients.title("Клиенты")
    window_clients.geometry("600x400")
    # Создаем полосу прокрутки
    scrollbar = Scrollbar(window_clients)
    scrollbar.pack(side = RIGHT, fill = Y)
    # Отправляем запрос в БД на получение данных
    cursor.execute("SELECT * FROM Clients")
    result = cursor.fetchall()
    clients_list = []
    # Создаем ListBox, в который заносим данные из БД
    clients = Listbox(window_clients, yscrollcommand = scrollbar.set)
    for row in result:
        temp = []
        for item in row:
            temp.append(str(item))
        clients_list.append(temp)
    for row in clients_list:
        clients.insert('end',row)
    clients.pack(fill = BOTH, expand = 1)

# Функция добавляет в БД новые данные, которые пользователь ввел
# в поля Entry
def AddClient():
    cursor.execute('''
                          INSERT INTO Clients (fname, mname, lname, birthday, phone)
                          VALUES
                          (?, ?, ?, ?, ?)
                          ''', (ent_first_name.get(), ent_middle_name.get(),
                                ent_last_name.get(), ent_birthday.get(),
                                ent_phone.get()))
    cnxn.commit()

# Функция очищает поля для ввода
def ClearEntry():
    ent_first_name.delete(0, END)
    ent_middle_name.delete(0, END)
    ent_last_name.delete(0, END)
    ent_birthday.delete(0, END)
    ent_phone.delete(0, END)

#Создание и разметка виджетов основного окна
window = Tk()
window.title("Добавить клиента")

frm_form = Frame(relief = SUNKEN, borderwidth = 3)
frm_form.pack()

lbl_first_name = Label(master = frm_form, text = "Имя:")
ent_first_name = Entry(master = frm_form, width = 50)
lbl_first_name.grid(row = 0, column = 0, sticky = "e")
ent_first_name.grid(row = 0, column = 1)

lbl_middle_name = Label(master = frm_form, text = "Отчество:")
ent_middle_name = Entry(master = frm_form, width = 50)
lbl_middle_name.grid(row = 1, column = 0, sticky = "e")
ent_middle_name.grid(row = 1, column = 1)

lbl_last_name = Label(master = frm_form, text = "Фамилия:")
ent_last_name = Entry(master = frm_form, width = 50)
lbl_last_name.grid(row = 2, column = 0, sticky = "e")
ent_last_name.grid(row = 2, column = 1)

lbl_birthday = Label(master = frm_form, text = "Дата рождения:")
ent_birthday = Entry(master = frm_form, width = 50)
lbl_birthday.grid(row = 3, column = 0, sticky = "e")
ent_birthday.grid(row = 3, column = 1)

lbl_phone = Label(master = frm_form, text = "Телефон:")
ent_phone = Entry(master = frm_form, width = 50)
lbl_phone.grid(row = 4, column = 0, sticky = E)
ent_phone.grid(row = 4, column = 1)

frm_buttons = Frame()
frm_buttons.pack(fill = X, ipadx = 5, ipady = 5)
btn_clients = Button(master = frm_buttons, text = "Клиенты", command = ViewClients)
btn_clients.pack(side = RIGHT, padx = 10, ipadx = 10)
btn_submit = Button(master = frm_buttons, text = "Отправить", command = AddClient)
btn_submit.pack(side = RIGHT, padx = 10, ipadx = 10)
btn_clear = Button(master = frm_buttons, text = "Очистить", command = ClearEntry)
btn_clear.pack(side = RIGHT, ipadx = 10)

window.mainloop()