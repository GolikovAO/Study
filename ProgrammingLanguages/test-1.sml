(* Первоначальный набор тестов для лабораторной работы №1 *)

(* Задание 1 *)
val testIsLeapYear1 = isLeapYear 2000 = true 
val testIsLeapYear2 = isLeapYear 2015 = false
val testIsLeapYear3 = isLeapYear 2016 = true

(* Задание 2 *)
val testIsCorrectDate1 = isCorrectDate (1,9,2016) = true
val testIsCorrectDate2 = isCorrectDate (21,13,1900) = false
val testIsCorrectDate3 = isCorrectDate (~12,3,1857) = false
val testIsCorrectDate4 = isCorrectDate (0,0,0) = false

(* Задание 3 *)
val testNewStyleCorrection1 = newStyleCorrection (1,3,2016) = 13
val testNewStyleCorrection2 = newStyleCorrection (28,2,1700) = 10

(* Задание 4 *)
val testGetNthInt1 = 
  let val tmp = getNthInt ([25, ~615, 834, ~38, 0], 3) 
  in tmp = ~38
  end

(* Задание 5 *)
val testGetNthStr1 = 
  getNthStr (["hi", "there", "how", "are", "you"], 2) = "how"
val testGetNthStr2 =
  getNthStr (["hi", "there", "how", "are", "you"], 0) = "hi"

(* Задание 6 *)
val testLastSmaller1 = lastSmaller (3654, [0, 25, 834, 3800]) = 834 
val testLastSmaller2 = lastSmaller (5, [9, 10, 76]) = 0

(* Задание 7 *)
val testFirstNewMoonInt2 = firstNewMoonInt (1,9,2016) = SOME 170823

(* Задание 8 *)
val testFirstNewMoon2  = firstNewMoon (1,9,2016) = SOME (1,9,2016)

(* Задание 9 *)
val testDateToString1  = dateToString (5,5,1980) = "May 5, 1980"
val testDateToString2  = dateToString (1,9,2016) = "September 1, 2016"

(* Задание 10 *)
val testIsOlder1 = isOlder ((1,2,3), (2,3,4)) = true
val testIsOlder2 = isOlder ((2,3,4), (1,2,3)) = false
val testIsOlder3 = isOlder ((1,2,3), (2,2,3)) = true
(* Задание 11 *)
val testWinterSolstice1 = winterSolstice 0 = 22
val testWinterSolstice2 = winterSolstice 3 = 23
val testWinterSolstice3 = winterSolstice 2014 = 22

(* Задание 12 *)
val testChineseNewYear1 = chineseNewYear 2016 = (8,2,2016)
val testChineseNewYear2 = chineseNewYear 2017 = (28,1,2017)

(* Задание 13 *)
val testChineseYear1 = 
  chineseYear 1980 = ("Geng-Shen","White","Monkey","Metal")
val testChineseYear2 = 
  chineseYear 2015 = ("Yi-Wei","Green","Sheep","Cut timber")

(* Задание 14 *)
val testDateToChineseYear1 = 
  dateToChineseYear (1,9,1980) = ("Geng-Shen","White","Monkey","Metal")
val testDateToChineseYear2 = 
  dateToChineseYear (1,9,2016) = ("Bing-Shen","Red","Monkey","Natural fire")

(* Задание 15 *)
val testDateToAnimal1 = 
  dateToAnimal (1,9,1980) = "Monkey"
val testDateToAnimal2 = 
  dateToAnimal (1,9,2016) = "Monkey"

(* Задание 16 *)
val testAnimal1 = 
  animal ("Ivan", (1,9,1980)) = "Monkey"
val testAnimal2 = 
  animal ("Svetlana", (1,9,2016)) = "Monkey"

(* Вспомогательная функция для тестирования заданий 17 и 18
 * выдает true, когда элемент a присутствует в списке l 
 * иначе выдает false *)
fun member ( a : string * (int * int * int)
           , l : (string * (int * int * int)) list
           ) : bool =
  if null l then false
  else a = hd l orelse member (a, tl l)

(* Задание 17 *)
val testExtractAnimal1 = 
  extractAnimal ( [ ("Ivan", (1,9,1980))
                   , ("Svetlana", (1,9,2015)) ]
                 , "Monkey" ) 
  = [("Ivan", (1, 9, 1980))]
val testExtractAnimal2 = 
  let val tmp = extractAnimal ( [ ("Ivan", (1,9,1980))
                                 , ("Svetlana", (1,9,2015))
                                 , ("Alex", (1,9,1955)) 
                                 ]
                               , "Sheep" )
  in
    member (("Svetlana", (1,9,2015)), tmp)
    andalso member (("Alex", (1,9,1955)), tmp)
    andalso length tmp = 2
  end 

(* Задание 18 *)
val testExtractAnimals1 = 
  extractAnimals ( [ ("Ivan", (1,9,1980))
                    , ("Svetlana", (1,9,2015)) ]
                  , ["Monkey"] ) 
  = [("Ivan", (1,9,1980))]
val testExtractAnimals2 = 
  let val tmp = extractAnimals ( [ ("Ivan", (1,9,1980))
                                  , ("Svetlana", (1,9,2015)) 
                                  , ("Alex", (1,9,1955)) 
                                  ]
                                , ["Monkey", "Sheep"] )
  in
    member (("Svetlana", (1,9,2015)), tmp)
    andalso member (("Alex", (1,9,1955)), tmp)
    andalso member (("Ivan", (1,9,1980)), tmp)
    andalso length tmp = 3
  end

(* Задание 19 *)
val testOldest1 = 
  oldest [ ("Ivan", (1,9,1980))
         , ("Svetlana", (1,9,2015))
         , ("Alex", (1,9,1955)) ] 
  = SOME "Alex"

(* Задание 20 *)
val testOldestFromAnimals1 = 
  oldestFromAnimals ( [ ("Ivan", (1,9,1980))
                        , ("Svetlana", (1,9,2015)) 
                        , ("Alex", (1,9,1955)) 
                        ]
                      , ["Monkey", "Sheep"] ) 
  = SOME "Alex"
val testOldestFromAnimals2 = 
  oldestFromAnimals ( [ ("Ivan", (1,9,1980))
                        , ("Svetlana", (1,9,2015)) 
                        , ("Alex", (1,9,1955)) 
                        ]
                      , ["Rabbit", "Dog"] ) 
  = NONE
  val testOldestFromAnimals3 = 
  oldestFromAnimals ( [ ("Ivan", (1,9,1980))
                        , ("Svetlana", (1,9,2015)) 
                        , ("Alex", (2,9,2015)) 
                        ]
                      , ["Sheep", "Dog"] ) 
  = SOME "Svetlana"