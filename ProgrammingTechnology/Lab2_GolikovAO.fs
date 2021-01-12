//Лабораторная работа №2 (5 Вариант)
open System

//Задание №1 (5) - Функция возводит в третью степень значение функции находящей корень от числа.
let function1 (x:float) = sqrt(x)
let function2  f=f**3.0
let result = function2 (function1 100.0)

//Задание №2(5) - Найти силу тока в полной цепи, если ЭДС источника равна 10 В, внутреннее сопротивление равно 2 Ом, а внешнее – 3 Ом.
let Amperage E R r = E / (R+r)
let Conv I = I - 2
let Answer = Amperage 10 3 2 |> Conv




//Задание №3(5) - Дано натуральное число n>1. Выведите все простые множители этого числа.

//Функция определения простого делителя
let rec prost (n:int) (k:int) =
  if n = 2 || n%k <> 0 && float(k) >= sqrt(float(n)) then n
   elif double(k) < sqrt(float(n)) then prost n (k+1)
   else prost (n+1) k

//Факторизация
let rec fact n1 n =
 let mutable t = prost n 2
 if n1 % t = 0 || n1 = 1 then 
     printfn "%A" t
     let mutable tmp = n1/t
     if tmp = 1 then 0
     else
     fact tmp 2
 else fact n1 (t+1)

fact 18 2

type CashiersCheck =
  val id : int
  val client : string
  val staff : string
  val discount : float
  val cost : float
  val summ : float

  new() = {
    id = 0
    client = "Client"
    staff = "Oficiant"
    discount = 1.0
    cost = 0.0
    summ = 0.0
  }
  new (Id, Client, Staff, Discount, Cost) = {
    id = Id
    client = Client
    staff = Staff
    discount = Discount
    cost = Cost
    summ = Cost * Discount
  }
  member this.IdToStr = sprintf "%i" (this.id)
  member this.DiscountToStr = sprintf "%.2f" ((1.0 - this.discount) * 100.0)
  member this.CostToStr = sprintf "%.2f" (this.cost)
  member this.SummToStr = sprintf "%.2f" (this.summ)
  member this.Info = this.IdToStr + " Client:" + this.client + " Cost:"+ this.CostToStr + " Discount:" + this.DiscountToStr + "% Summ:" + this.SummToStr

let order = CashiersCheck(1, "Ivanov Petr", "Golovina Ekaterina", 0.85, 1500.0)

printfn "%A" order.Info

type CashiersCheck1(Id:int, Client:string, Staff:string, Cost:float, Discount:float) =
  member this.id = Id
  member this.client = Client
  member this.staff = Staff
  member this.cost = Cost
  member this.discount = Discount
  member this.summ = Cost * Discount
  new () = new CashiersCheck1(0, "", "", 0.0, 0.0)
  new (str:string) =
    let r = str.Split(';')
    let Id = (r.[0]) |> int
    let Client = r.[1]
    let Staff = r.[2]
    let Cost = (r.[3])|> float
    let Discount = (r.[4])|> float
    new CashiersCheck1(Id, Client, Staff, Cost, Discount)
   
let order2 = new CashiersCheck1(2,"Ivan Zaykov","Ilya Degterev",1300.0, 0.9)
let order3 = new CashiersCheck1("3;Elena Kruglova;Ekaterina Golovina;850.0;0.95");
printfn "Order: %A, %A, %A, %A, %A"
            order2.id order2.client order2.cost ((1.0 - order2.discount) * 100.0) order2.summ
printfn "Order: %A, %A, %A, %A, %A"
            order3.id order3.client order3.cost ((1.0 - order3.discount) * 100.0) order3.summ
