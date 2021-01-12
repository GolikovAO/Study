(* Шаблон для выполнения заданий лабораторной работы №1 *)

(* Задание 1 isLeapYear *)
fun isLeapYear (y : int) : bool =
  y mod 400 = 0
  orelse y mod 100 <> 0
  andalso y mod 4 = 0

(* Задание 2 isCorrectDate *)
fun isCorrectDate (d : int, m : int, y : int) : bool = 
  case (m) 
    of (1) => d > 0 andalso d <= 31 
    | (2) => d > 0 andalso d <= 28 orelse isLeapYear y = true andalso d = 29 
    | (3) => d > 0 andalso d <= 31 
    | (4) => d > 0 andalso d <= 30 
    | (5) => d > 0 andalso d <= 31 
    | (6) => d > 0 andalso d <= 30 
    | (7) => d > 0 andalso d <= 31 
    | (8) => d > 0 andalso d <= 31 
    | (9) => d > 0 andalso d <= 30 
    | (10) => d > 0 andalso d <= 31 
    | (11) => d > 0 andalso d <= 30 
    | (12) => d > 0 andalso d <= 31 
    | _ => false;
(* Задание 3 newStyleCorrection *)
fun newStyleCorrection(date : int * int * int) : int =
  let
    val countGregorian : int = #3 date div 4 - #3 date div 100 + #3 date div 400
    val countUlian : int = #3 date div 4
    val difference : int = if (#3 date mod 4 = 0) andalso not (isLeapYear (#3 date))
                   then if (#2 date <=2)
                    then 1
                    else 0
                   else 0
  in
    countUlian - (countGregorian + difference) - 2
  end
(* Задание 4 getNthInt *)
fun getNthInt (spisok : int list, n : int) : int =
  if n > 0 
  then getNthInt (tl spisok, n - 1) 
  else hd spisok
(* Задание 5 getNthStr *)
fun getNthStr (spisok : string list, n: int) : string =
  if n > 0
  then getNthStr (tl spisok, n - 1)
  else hd spisok
(* Задание 6 lastSmaller *)
fun lastSmaller (amount : int, spisok : int list) : int =
  let
   fun func (lst : int list, potential : int) : int =
    if not (null lst) andalso (hd lst < amount)
    then func (tl lst, hd lst)
    else potential
  in
    if (hd spisok >= amount)
    then 0
    else func(tl spisok, hd spisok)
end
(* Списки для выполнения задания 8 (списки поправок) *)
(* поправка на тысячи года *)
val thousandCorrection = [ 0, 1390000, 2770000, 1210000, 2590000
                          , 1030000, 2420000 ]
(* поправка на сотни года *)
val hundredCorrection  = [ 0, 430000, 870000, 1300000, 1740000
                          , 2170000, 2600000, 80000, 520000, 950000 ]
(* поправка на десятки года *)
val decadeCorrection   = [ 0, 930000, 1860000, 2790000, 760000
                          , 1690000, 2620000, 600000, 1530000, 2460000 ]
(* поправка на единицы года *)
val yearCorrection     = [ 0, 1860000, 780000, 2640000, 1550000
                          , 460000, 2330000, 1240000, 150000, 2020000 ]
(* поправка на месяц *)
val monthCorrection    = [ 1340000, 1190000, 2420000, 2260000, 2200000
                          , 2060000, 2000000, 1840000, 1700000, 1660000
                          , 1510000, 1480000 ]
(* календарная поправка *)
val calendarCorrection = [0, 20000, 50000, 80000]
(* поправка для нормализации дня месяца *)
val reductions = [2953059, 5906118, 8859177, 11812236, 14765295, 17718354] 

(* Задание 7 firstNewMoonInt *)
fun firstNewMoonInt (date: int * int * int) : int option =
let
  val difference : int = newStyleCorrection(date) * 100000
  val newY : int = if (#2 date <= 2) then #3 date -1 else #3 date
  val thousand : int = getNthInt (thousandCorrection, newY div 1000)
  val hunderd : int = getNthInt (hundredCorrection, (newY mod 1000) div 100)
  val decade : int = getNthInt (decadeCorrection, (newY mod 100) div 10)
  val year : int = getNthInt (yearCorrection, newY mod 10)
  val month : int = getNthInt (monthCorrection, #2 date - 1)
  val calendar : int = getNthInt (calendarCorrection, newY mod 4)
  val summa : int = difference + thousand + hunderd + decade + year + month + calendar
  val max : int = lastSmaller (summa - 100000, reductions)
  val result : int = summa - max
in
  if #2 date = 2
  then if (result div 100000 <= 28) orelse isLeapYear(#3 date) andalso (result div 100000 = 29)
    then SOME result else NONE
  else if (result div 100000 <= 30) then SOME result else NONE
end
(* Задание 8 firstNewMoon *)
fun firstNewMoon (date : int * int * int) : (int * int * int) option =
  let
    val tmp : int =  valOf (firstNewMoonInt(date))
  in
    if firstNewMoonInt(date) = NONE then NONE
    else SOME (tmp div 100000, #2 date, #3 date)
  end
(* Задание 9 dateToString *)
(*fun dateToString (date : int * int * int) : string =
  let
    val dateString : string = Int.toString(#1 date) ^ ", " ^ Int.toString(#3 date)
  in
     case (#2 date) 
    of (1) => "January " ^ dateString 
    | (2) => "February " ^ dateString 
    | (3) => "March " ^ dateString 
    | (4) => "April " ^ dateString 
    | (5) => "May " ^ dateString 
    | (6) => "June " ^ dateString 
    | (7) => "July " ^ dateString 
    | (8) => "August " ^ dateString 
    | (9) => "September " ^ dateString 
    | (10) => "October " ^ dateString  
    | (11) => "November " ^ dateString 
    | (12) => "December " ^ dateString 
  end
  *)
  fun dateToString (date : int * int * int) : string =
    let
      val dateString : string = " " ^ Int.toString(#1 date) ^ ", " ^ Int.toString(#3 date)
      val months : string list = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    in
      getNthStr (months, #2 date-1) ^ dateString
    end
(* Задание 10 isOlder *)
fun isOlder (date1 : int * int * int, date2 : int * int * int) : bool =
  if #3 date1 < #3 date2 then true
  else if #2 date1 < #2 date2 then true
  else if #1 date1 < #1 date2 then true
  else false
(* Задание 11 winterSolstice *)
fun winterSolstice (y : int) : int =
  let
    val countLeap : int = y div 4 - y div 100 + y div 400
    val sigma1 : int = countLeap * 75780
    val sigma2 : int = (y - countLeap) * 24220
  in
    (2250000 + sigma2 - sigma1) div 100000
  end
(* Задание 12 chineseNewYear *)
fun chineseNewYear (y: int) : int * int * int =
  let
   val tmp : int = if valOf (firstNewMoonInt(1,12,y-1)) div 100000 > winterSolstice(y-1) 
                  then (valOf (firstNewMoonInt(1,12,y-1)) + 2953059) div 100000 - valOf (firstNewMoonInt(1,12,y-1)) div 100000 
                  else (valOf (firstNewMoonInt(1,12,y-1)) + 5906118) div 100000 - valOf (firstNewMoonInt(1,12,y-1)) div 100000
   val day : int = tmp - 31 - 31 + valOf (firstNewMoonInt(1,12,y-1)) div 100000
  in
    if day > 0 then (day,2,y)
    else if day < 0 then (32 + day,1,y)
    else (1,1,y)
  end
(* Списки для выполнения задания 13 *)
(* список небесных стихий (по-китайски) *)
val celestialChi   = [ "Jia", "Yi", "Bing", "Ding", "Wu"
                      , "Ji", "Geng", "Xin", "Ren", "Gui" ] 
(* список небесных стихий (по-английски) *)
val celestialEng   = [ "Growing wood", "Cut timber", "Natural fire"
                      , "Artificial fire", "Earth", "Earthenware"
                      , "Metal", "Wrought metal", "Running water"
                      , "Standing water" ]
(* цвета, соответствующие небесным стихиям *)
val celestialColor = ["Green", "Red", "Brown", "White", "Black"] 
(* список земных стихий (по-китайски) *)
val terrestrialChi = [ "Zi", "Chou", "Yin", "Mao"
                      , "Chen", "Si", "Wu", "Wei"
                      , "Shen", "You", "Xu", "Hai" ]
(* список земных стихий (по-английски) *)
val terrestrialEng = [ "Rat", "Cow", "Tiger", "Rabbit"
                      , "Dragon", "Snake", "Horse", "Sheep"
                      , "Monkey", "Chicken", "Dog", "Pig" ]

(* Задание 13 chineseYear *)
fun chineseYear (y : int) : string * string * string * string =
  let
    val celestialNum : int = (y + 2396) mod 60 mod 10
    val colorNum : int = celestialNum div 2
    val animalNum : int = (y + 2396) mod 12
  in
    (getNthStr (celestialChi, celestialNum) ^ "-" ^ getNthStr (terrestrialChi, animalNum), getNthStr (celestialColor, colorNum), getNthStr (terrestrialEng, animalNum), getNthStr (celestialEng, celestialNum))
  end
(* Задание 14 dateToChineseYear *)
fun dateToChineseYear (date : int * int * int) : string * string * string * string =
  chineseYear(#3 date)
(* Задание 15 dateToAnimal *)
fun dateToAnimal (date : int * int * int) : string =
  #3 (dateToChineseYear (date))
(* Задание 16 animal *)
fun animal (pair : string * (int * int * int)) : string =
  dateToAnimal(#2 pair)
(* Задание 17 extractAnimal *)
fun extractAnimal (spisok : (string * (int * int * int)) list, animalName : string) : (string * (int * int * int)) list = 
  if null spisok then spisok
  else if (animal (hd spisok) = animalName) then hd spisok::extractAnimal(tl spisok, animalName)
  else extractAnimal(tl spisok, animalName)
(* Задание 18 extractAnimals *)
fun extractAnimals (students : (string * (int * int * int)) list, animalName : string list) : (string * (int * int * int)) list =
  if null animalName then []
  else extractAnimal(students,hd animalName) @ extractAnimals(students, tl animalName)
(* Задание 19 oldest *)
fun oldest (students : (string * (int* int * int)) list) : string option =
  let
    fun maxAge (spisok : (string * (int* int * int)) list, potential : string * (int * int * int)) : string * (int * int * int) =
if not (null spisok) then 
  if isOlder ((#2 (hd spisok)),(#2 potential)) then maxAge(tl spisok,hd spisok)
  else maxAge(tl spisok, potential)
  else potential
  in
    if null students then NONE
    else SOME (#1 (maxAge(students,hd students)))
  end
(* Задание 20 oldestFromAnimals *)
fun oldestFromAnimals (students : (string * (int* int * int)) list, animals : string list) : string option =
 if (null (extractAnimals(students, animals))) then NONE
 else SOME (valOf (oldest( extractAnimals( students, animals))))