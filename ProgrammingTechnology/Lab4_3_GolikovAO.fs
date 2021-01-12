//Лабортаторная работа №4. Вариант 5.

(* ЧАСТЬ 3 *)


open System
// Алгебраический тип
type Figures =
   | Circle of double
   | Square of double
   | Triangle of double 
   | Rectangle of double * double

type Figure (F:Figures) =
    let mutable _F = F

    member this.F
        with get () = _F
    
    // Функция вычисления периметров
    member this.Perimeter
        with get() =
            match  _F with
                | Circle(r) -> (Math.PI * 2.0 * r)
                | Square(a) -> (4.0 * a)
                | Triangle(a) -> (3.0 * a)
                | Rectangle(a,b) -> (2.0 * (a + b))

    // Функция вычисления площадей   
    member this.Area
        with get() =
            match _F with
                | Circle(r) -> (Math.PI * r * r)
                | Square(a) -> (a * a)
                | Triangle(a) -> (sqrt(3.0)/4.0 * a * a)
                | Rectangle(a,b) -> (a * b)
    
    // Функции вывода на экран информации о фигуре
    member this.Print
        with get() = 
            match _F with
            | Circle(r) -> printfn "Круг с радиусом %A. Периметр - %A. Площадь - %A" r this.Perimeter this.Area
            | Square(a) -> printfn "Квадрат со стороной %A. Периметр - %A. Площадь - %A" a this.Perimeter this.Area
            | Triangle(a) -> printfn "Правильный треугольник со стороной %A. Периметр - %A. Площадь - %A" a this.Perimeter this.Area
            | Rectangle(a,b) -> printfn "Прямоугольник со сторонами %A и %A. Периметр - %A. Площадь - %A" a b this.Perimeter this.Area
        

[<EntryPoint>]
let main argv =
    // Создаем четыре фигуры (круг, квадрат, треугольник, прямоугольник)
    let f1 = new Figure(Circle(4.0))
    let f2 = new Figure(Square(5.0))
    let f3 = new Figure(Triangle(3.0))
    let f4 = new Figure(Rectangle(4.0, 3.5))
    let figures = [|f1; f2; f3; f4|]
   
   // Выводим на экран информацию по каждой фигуре
    for item in figures do
        item.Print
   
    Console.ReadLine() |> ignore
    0

