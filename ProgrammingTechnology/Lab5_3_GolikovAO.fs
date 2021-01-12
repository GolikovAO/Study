//Лабораторная работа №5. Вариант 5.

(*ЧАСТЬ 3*)

//Задание: Разработать программу, состоящую из главной формы, рисунка и одной кнопки. По нажатию на кнопку меняется рисунок.

open System
open System.Drawing
open System.Windows.Forms
open System.IO

let Form1 = new Form(Text="Пример формы в F#", Width=400, Height=300, Menu = new MainMenu())
let Button1 = new Button(Text="Change Picture", Width = 80, Height = 50, Top = 190, Left = 150)
let image1 = new PictureBox(SizeMode = PictureBoxSizeMode.AutoSize, Top = 30, Left = 120)
let image2 = new PictureBox(SizeMode = PictureBoxSizeMode.AutoSize, Top = 30, Left = 120)

// Меню бар 
let mFile = Form1.Menu.MenuItems.Add("&Файл")
let mForms = Form1.Menu.MenuItems.Add("&Формы")
let mHelp = Form1.Menu.MenuItems.Add("&Помощь")

// Под меню
let miMessage = new MenuItem("&Пример сообщения")
let miSeparator  = new MenuItem("-")
let miExit = new MenuItem("&Выход")
let miAbout = new MenuItem("&О программе...")
let miForm1 = new MenuItem("&Форма_1")
let miForm2 = new MenuItem("&Форма_2")
let miForm3 = new MenuItem("&Форма_3")

// Добавление подменю в пункты меню
mFile.MenuItems.Add(miMessage)
mFile.MenuItems.Add(miSeparator)
mFile.MenuItems.Add(miExit)
mHelp.MenuItems.Add(miAbout)
mForms.MenuItems.Add(miForm1)
mForms.MenuItems.Add(miForm2)
mForms.MenuItems.Add(miForm3)

// Добавление картинок
image1.ImageLocation <- "C:/Users/Makesar/source/repos/Lab5_3_GolikovAO/sgu.png"
image2.ImageLocation <- "C:/Users/Makesar/source/repos/Lab5_3_GolikovAO/kniit.png"

// Добавляем элементы на форму
Form1.Controls.Add(Button1)
Form1.Controls.Add(image1)
Form1.Controls.Add(image2)
image2.Visible <- false

// Добавляем события при клике
Button1.Click.Add(fun i -> if (image1.Visible = false) then image1.Visible <- true else image1.Visible <- false) 
Button1.Click.Add(fun i -> if (image2.Visible = false) then image2.Visible <- true else image2.Visible <- false)

do Application.Run(Form1)
