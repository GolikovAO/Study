// Лабораторная работа №6. Вариант 5.

(*ЧАСТЬ 1*)

//Задание №1. На основе вещественного массива полученного от пользователя создать из него массивы 
//целых положительных чисел и целых отрицательных чисел (отбросив дробную часть). 
//Вывести результат и длины полученных массивов.

open System

Console.Title <- "Голиков А.О. - Массивы"
Console.ForegroundColor <- ConsoleColor.Cyan
Console.BackgroundColor <- ConsoleColor.Black


printfn "Введите массив вещественных чисел"
// Читаем массив с клавиатуры
let mutable inputmas = System.Console.ReadLine().Split[|' '|]

// Создаем массив вещественных чисел из массива типа string
let floatmas = 
    let mutable tmpmas = Array.create (Array.length inputmas) 0.0
    for i = 0 to Array.length inputmas - 1 do
        tmpmas.[i] <- float(inputmas.[i])
    tmpmas

// Переводим массив типа float в массив типа int (отбрасываем дробную часть)
let intmas = 
    let mutable tmpmas = Array.create (Array.length inputmas) 0
    for i = 0 to Array.length floatmas - 1 do
        tmpmas.[i] <- int(floatmas.[i])
    tmpmas

// Функции создания массивов положительных и отрицательных чисел
let plusmas =
    Array.choose (fun x -> if x >= 0 then Some(x) else None) intmas
let minusmas =
    Array.choose (fun x -> if x < 0 then Some(x) else None) intmas

printfn "Массив положительных чисел: \n %A \n Длина массива: %A" plusmas (Array.length plusmas)
printfn "Массив отрицательных чисел: \n %A \n Длина массива: %A" minusmas (Array.length minusmas)


// Задание №2. В массиве чисел от 1 до 25 6 элементов, начиная с четвертого, обратить пятерками, 
// 10 элементов, начиная с 11, обратить восьмерками, и двадцать третий элемент обратить в тройку.

let mas2 =
    let mutable tmpmas = [|1..25|]
    printfn "Изначальный массив: \n %A" tmpmas
    Array.fill tmpmas 3 6 5
    printfn "Первая итерация: \n %A" tmpmas
    Array.fill tmpmas 10 10 8
    printfn "Вторая итерация: \n %A" tmpmas
    Array.set tmpmas 22 3
    printfn "Третья итерация: \n %A" tmpmas
    tmpmas



// Задание №3. В списке хранится информация о студентах (Фамилия Имя Отчество ГодРождения Рост). 
// 1. Найдите всех студентов родившихся в 1998 году. 
// 2. Найдите самых молодых студентов. 

// Создадим тип Student с нужными параметрами
type Student = {lastname : string; firstname : string; middlename : string; birthyear : int; height : int}

// Создаем массив списков
let Students : Student [] = [|  {lastname = "Иванов"; firstname = "Дмитрий"; middlename = "Сергеевич"; birthyear = 1994; height = 178};
                                {lastname = "Сидоров"; firstname = "Константин"; middlename = "Ильич"; birthyear = 1998; height = 180};
                                {lastname = "Одинцова"; firstname = "Юлия"; middlename = "Валерьевна"; birthyear = 1999; height = 165};
                                {lastname = "Воробьева"; firstname = "Анна"; middlename = "Александровна"; birthyear = 1998; height = 170};
                                {lastname = "Петров"; firstname = "Тарас"; middlename = "Борисович"; birthyear = 1996; height = 175}|]    

// Функция находящих студентов 1998 года рождения
let Students1998 = Array.choose (fun s -> if s.birthyear = 1998 then Some(s) else None) Students
printfn "Студенты 1998 года рождения: \n %A \n" Students1998

// Функция находящего самого молодого студента
let youngest = Array.maxBy (fun s -> s.birthyear) Students
printfn "Самый молодой студент: \n %A" youngest
Console.ReadKey()
Console.Clear()
