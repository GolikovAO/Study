//Лабораторная работа №4. Вариант 5.

(* Часть 2 *)


namespace Lab4Library


open System 
open System.Collections.Generic

type Move =
  abstract CurrentLocation :  string with get, set
  abstract NeedLocation :  string with get
  abstract IsMove : bool with get
  abstract Print : string with get


type Package(code: int, name : string, sender: string, address: string, weight: float) =
    let mutable _code = code
    let mutable _name = name
    let mutable _sender = sender
    let mutable _address = address
    let mutable _weight = weight
    let mutable _curloc = "PostOffice"

    member this.Code
        with get() = _code
        and set(value) = _code <- value

    member this.Address
        with get() = _address
        and set(value) = _address <- value
    
    member this.Name
        with get() = _name
        and set(value) = _name <- value

    member this.Sender
        with get() = _sender
        and set(value) = _sender <- value

    member this.Weight
           with get() = _weight
           and set(value) = _weight <- value

    member this.CurrLoc
         with get() = _curloc
         and set(value) = _curloc <- value

    interface Move with  
        member this.Print
            with get() = 
            " Package Code: " + string(this.Code) + "\n Contains: " + this.Name + "\n Sender: " 
            + this.Sender + "\n Address: " + this.Address + "\n Weight: " + string(this.Weight) + "\n\n"

        member this.CurrentLocation
            with get() = this.CurrLoc
            and set(value) = this.CurrLoc <- value

        member this.NeedLocation
            with get() = this.Address

        member this.IsMove = 
            if (System.String.Equals(this.CurrLoc, this.Address, System.StringComparison.CurrentCultureIgnoreCase)) then false
            else true
                      

    interface IComparable<Package> with
    member this.CompareTo (b) =
        this.Code.CompareTo(b.Code)