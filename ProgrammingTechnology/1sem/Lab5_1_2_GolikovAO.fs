(*Лабораторная работа №5. Вариант 5*)

(*ЧАСТЬ 1*)

// Задание №1. Создать функцию, сортирующую элементы списка по остатку от деления на 3.

let sort (lst)  =
    List.sortBy(fun item -> item % 3) lst

let list1 = [ 1; 2; 3; 4; 5; 6; 7; 8; 9]

sort(list1)


// Задание №2. В списке от 1 до 20 найти четные числа и вывести на экран их в квадраты и кубы.
// Для решения задач используйте списки. Входные данные получите из файла. Результат запишите в файл.
open System
open System.IO

let stream = new StreamReader @"C:\Users\Makesar\source\repos\Lab5_GolikovAO\Lab5_GolikovAO\input.txt"
let mutable valid = true
while (valid) do
            let line = stream.ReadLine()
            if (line = null) then
                valid <- false
            else
                // Создаем массив чисел из файлов
                let mas = line.Split[|' '|]
                // Функция выбора четных чисел
                let list = 
                    let tmp = List.ofArray mas
                    List.filter (fun x -> int(x)%2 = 0) tmp
                // Функция перевода элементов листа в строку
                let list1 =
                    let mutable str = ""
                    for item in list do
                        str <- str + string(item) + " " 
                    str <- str + "\n"
                    str
                // Функция возведения чисел в квадрат
                let list2 = 
                   let tmp = List.map(fun x -> int(x) * int(x)) list 
                   let tmp = List.map(fun x -> string(x)) tmp
                   let mutable str = ""
                   for item in tmp do
                     str <- str + string(item) + " " 
                   str <- str + "\n"
                   str
                // Функция возведения числе в куб
                let list3 = 
                    let tmp = List.map(fun x -> int(x) * int(x) * int(x)) list
                    let tmp = List.map(fun x -> string(x)) tmp
                    let mutable str = ""
                    for item in tmp do
                      str <- str + string(item) + " " 
                    str
                File.WriteAllText(@"C:\Users\Makesar\source\repos\Lab5_GolikovAO\Lab5_GolikovAO\output.txt", list1 + list2 + list3)

 // Задание №3. Создайте список записей, проведите фильтрацию и сортировку.          
 // Студенты (рост, вес, фамилия). Удалите студентов с ростом менее 100. Оставшихся отсортируйте по весу (по убыванию). 
 // Студенты с одинаковым весом сортируются по фамилии. 
 // Определите количество оставшихся студентов. Вычислите средний вес оставшихся студентов.

// Создадим тип Student с нужными параметрами
type Student = {height : int; weight: int; lastname: string}

// Создаем лист списков
let Students : list<Student> = [{height = 178; weight = 70; lastname = "Иванов"};
                                {height = 98; weight = 74; lastname = "Сидоров"};
                                {height = 187; weight = 70; lastname = "Высокова"};
                                {height = 80; weight = 55; lastname = "Одинцова"};
                                {height = 176; weight = 80; lastname = "Петров"}]    
 
 // Удаляем студентов с ростом менее 100
let Students1 = List.filter(fun x -> x.height > 100) Students

// Функции сортировки, которые сортируют по убыванию по весу, а если вес равный - по фамилии.
let compareStudents student1 student2 =
   if student1.weight < student2.weight then 1 else
    if student1.weight > student2.weight then -1 else
        String.Compare(student1.lastname, student2.lastname)
let SortStudents =
    List.sortWith compareStudents Students1

 // Подсчитываем кол-во оставшихся студентов
let countStudents =
    SortStudents.Length
// Подсчитывавем средний вес оставшихся студентов
let avgStudents =
    List.averageBy(fun x -> float(x.weight)) SortStudents



  (*ЧАСТЬ 2*)
  // Задание. Пользователь вводит дату. Программа сообщает время года, сколько дней осталось до конца года.

Console.Title <- "Голиков А.О. - Вывод времени года, сколько дней осталось до НГ"
Console.ForegroundColor <- ConsoleColor.Cyan
Console.BackgroundColor <- ConsoleColor.Black
printfn "Введите дату в формате DD.MM.YYYY"
// Считываем дату с клавиатуры
let mutable inputdate = System.Console.ReadLine().Split[|'.'|]
// Создадим массив из кол-ва дней в месяцах
let mutable days = [|31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31|]

// Функция определяющая время года   
match int(inputdate.[1]) with
| 1 | 2 | 12 -> printfn "Время года: Зима"
| 3 | 4 | 5 -> printfn "Время года: Весна"
| 6 | 7 | 8 -> printfn "Время года: Лето"

// Функция проверяющая год на високосность
let IsLeapYear = 
    if (int(inputdate.[2]) % 4 = 0) && (int(inputdate.[2]) % 100 <> 0) || (int(inputdate.[2]) % 400 = 0) then true
    else false
// Функция высчитывающая кол-во дней до конца года
let DaysToNY = 
    let mutable tmp = 365
    let mutable dayscount = 0
    if IsLeapYear then 
        tmp <- 366
        days.[1] <- 29
    for i = 0 to (int(inputdate.[1]) - 2) do
        dayscount <- dayscount + days.[i]
    tmp - dayscount - int(inputdate.[0])

printfn "До нового года осталось: %A дн." DaysToNY
Console.ReadKey()
Console.Clear()
