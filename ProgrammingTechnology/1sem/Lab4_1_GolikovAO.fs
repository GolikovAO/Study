//Лабортаторная работа №4. Вариант 5.

(* ЧАСТЬ 1 *)

open System


//Задание №1. Преобразования единиц измерения (в обе стороны). Миля - Километр

[<Measure>]
type ml
[<Measure>]
type km

let ml_to_km (a : float<ml>) = a * 1.609344<km/ml>
let km_to_ml (a : float<km>) = a / 1.609344<km/ml>

let a = ml_to_km 50.0<ml>
let b = km_to_ml 74.0<km>

//Задание №2. 

let summa (a:int, b:int, d:int) = a + b + d
let raznost (a:int, b:int, d:int) = a - b - d

let Result (a:int, b:int, c:int, d:int) = (a, b, c, summa (a,b,d), raznost (a,b,d))
Result (7,5,2,1)

//Задание №3. Создайте три записи о сотрудниках (Фамилия, Имя, Стаж). Увеличьте всем стаж на 1 год.

type Person = {FirstName : string; LastName : string; mutable WorkXP : int};;

let Person1 : Person = {FirstName = "Ivanov"; LastName = "Petr"; WorkXP = 5}
let Person2 : Person = {FirstName = "Egorov"; LastName = "Andrei"; WorkXP = 7}
let Person3 : Person = {FirstName = "Sidorov"; LastName = "Sergei"; WorkXP = 2}

let Persons = [Person1;Person2; Person3]

for i in Persons do
 i.WorkXP <- i.WorkXP + 1
 


