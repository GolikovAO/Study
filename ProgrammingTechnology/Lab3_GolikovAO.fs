//Лабораторная работа №3. Вриант 5
open System

(*ЧАСТЬ 1*)

//Задание №1. Вывести все числа от 100 до 80, прибавив 5 и возведя в квадрат. 

let square x : float = x * x
let func = 
 for i=100 downto 80 do
  printf "%.2f" (square(double(i) + 5.0))
  printfn ""

//Задание №2. Вывести все заглавные буквы английского алфавита. Двумя способами.

let func1 = 
 for i = 1 to 26 do
 printf "%c" (char(64+i))
 printf " "

let func2 = 
 let list = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
 for i in list do
 printf "%A" i
 printf " "

let func2_1 =
 for i in 'A' .. 'Z' do
 printf "%c " i
 printf " "



 //Задание №3. Вычислить значение функции.

let func4 x y = (exp(sqrt(x * y) + sqrt(x + y)) + sin(y * x)) / (sqrt(cos(x)*cos(x) + sin(x * x))) * 2.0 / 5.0
func4 1.0 8.0


//Задание №4.

let F x = 
 let mutable a : int = x / 100
 let mutable b : int = (x % 100) / 10
 let mutable c : int = x % 10
 printfn "Ostatok ot a*b*c/a+b+c: %i" ((a*b*c)%(a+b+c))
 printfn "Y= %i" (a * 100 + c * 10 + b)

F 581

(*ЧАСТЬ 2*)
//Класс фигуры
type Figure = 
   class
     val a : float
     val b : float
     val c : float
     new (A: float, B: float, C: float) = {
       a = A
       b = B
       c = C
     }
     member this.Volume = this.a * this.b * this.c
     member this.Square = 2.0 * ((this.a * this.b) + (this.a * this.c) + (this.c * this.b))
     member this.Item (ix:int) =
       match ix with
       | 0 -> this.a
       | 1 -> this.b
       | 2 -> this.c
       | _ -> failwith "Index out of range"   
   end
let a = new Figure(2.0, 3.0, 4.0)
try
   printfn "Parameters of Figure: (%.2f, %.2f, %.2f)" a.[0] a.[1] a.[2]
   printfn "Volume of Figure: (%.2f)" a.Volume
   printfn "Square of Figure: (%.2f)" a.Square
with
    | _ as e -> printfn "Error: %s" e.Message
//Класс цилиндра
type Cylinder =
 inherit Figure
 val r : float
 val h : float
 new (A: float, B: float, C: float, R: float, H: float) = {
     inherit Figure(A,B,C)
     r = R
     h = H
   }
   member this.Volume = Math.PI * (this.r * this.r) * this.h
   member this.Square = 2.0 * Math.PI * this.r * (this.r + this.h) 
   member this.Item (ix:int) =
     match ix with
     | 0 -> this.r
     | _ -> failwith "Index out of range" 

let b = new Cylinder(2.0, 3.0, 4.0, 5.0, 8.0)
try
   printfn "Volume of Cylinder: (%.2f)" b.Volume
   printfn "Square of Cylinder: (%.2f)" b.Square
with
    | _ as e -> printfn "Error: %s" e.Message
//Класс полого цилиндра
type HollowCylinder = 
 inherit Cylinder
 val ir : float
 new (A: float, B: float, C:float, R: float, H: float, iR: float) = {
     inherit Cylinder(A, B, C, R, H)
     ir = iR
   }
   member this.Volume = Math.PI * this.h * (this.r * this.r - this.ir * this.ir)
   member this.Square = 2.0 * Math.PI * (this.r * this.r - this.ir * this.ir) + 2.0 * Math.PI * (this.r + this.ir) * this.h
   member this.Item (ix:int) =
     match ix with
     | 0 -> this.ir
     | _ -> failwith "Index out of range" 
let c = new HollowCylinder(2.0, 3.0, 4.0, 5.0, 8.0, 3.0)
try
 printfn "Volume of Hollow Cylinder: (%.2f)" c.Volume
 printfn "Square of Hollow Cylinder: (%.2f)" c.Square
with
  | _ as e -> printfn "Error: %s" e.Message
