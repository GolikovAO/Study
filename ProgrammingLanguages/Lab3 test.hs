import Lab3

-- Первоначальный набор тестов для лабораторной работы №3 
-- по мере реализации решений заданий снимайте комментарий 
-- с тестов соответствующей функции и пополняйте их своими тестами
-- кроме того, снимайте комментарий соответствующих строк вывода 
-- результатов тестов в функции main в конце файла и пополняйте эту 
-- функцию своими строками

-- Для проведения тестов запустите этот файл и выполните запуск main

------  Задание 1 nat 
--test_nat_1 = take 5 (drop 24 nat) == [25, 26, 27, 28, 29]
--test_nat_2 = take 5 (drop 124 nat) == [125, 126, 127, 128, 129]

------  Задание 2 fibonacci 
--test_fibonacci_1 = take 8 fibonacci == [0,1,1,2,3,5,8,13]

------ Задание 3 factorial 
--test_factorial_1 = take 5 factorial == [1,1,2,6,24] 

------ Задание 4 powerSeq 
------ для вещественнозначного аргумента тесты не требуются
------ но при наличии тестов для вещественных чисел следует проверять ответ 
------ с некоторой точностью
------ точность epsilon для проверки вполне подходит
--test_powerSeq_1 = take 5 (powerSeq 1) == [1,1,1,1,1] 
--test_powerSeq_2 = abs (hd - 1.4641) <= epsilon
--      where hd = head (drop 4 (powerSeq 1.1))   

------  Задание 5 findCloseEnough 
------ тесты не требуются 

------ Задание 6 streamSum 
------ тесты не требуются 

------ Задание 7 expSummands 
------ тесты не требуются

------ Задание 8 expStream 
------ тесты не требуются

------  Задание 9 expAppr 
--test_expAppr_1 = abs (expAppr epsilon'' 1 - exp 1) < epsilon
--test_expAppr_2 = abs (expAppr epsilon'' 5 - exp 5) < epsilon

------ Задание 10 derivativeAppr 
--test_derivativeAppr_1 = abs (derivativeAppr sin epsilon'' x - cos x) < epsilon
--  where x = pi

------ Задание 11 derivativeStream 
------ тесты не требуются

------ Задание 12 derivative 
--test_derivative_1 = abs (derivative sin x - cos x) < epsilon
--  where x = pi

------ Задание 13 invF и funAkStream
------ для funAkStream тесты не требуются
--test_invF_1 = abs (invF (\x -> x * x) 4.3 16 - 4) < epsilon
--test_invF_2 = abs (invF (\x -> x * x * x) 4.7 125 - 5) < epsilon

------ Задание 14 average 
--test_average_1 = (average 4 8) == 6

------ Задание 15 averageDump 
--test_averageDump_1 = (averageDump (\x -> x + x) 8) == 12

------ Задание 16 newtonTransform 
--test_newtonTransform_1 = abs (newtonTransform (\x -> x * x / 2) 4 - 2) < epsilon

------ Задание 17 eitken 
------ тесты не требуются

------ Задание 18 fixedPoint
------ тесты не требуются

------ Задание 19 fixedPointOfTransform 
------ тесты не требуются

------ Задание 20 sqrt1 
--test_sqrt1_1 = abs (sqrt1 25 - 5) < epsilon

------ Задание 21 cubert1 
--test_cubert1_1 = abs (cubert1 125 - 5) < epsilon

------ Задание 22 sqrt2 
--test_sqrt2_1 = abs (sqrt2 25 - 5) < epsilon

------ Задание 23 cubert2 
--test_cubert2_1 = abs (cubert2 125 - 5) < epsilon

------ Задание 24 extremum 
--test_extremum_1 = abs (x - 0) < epsilon && str == "minimum"
--  where (x, str) = extremum (\x -> x * x)

------ Задание 25 myPi 
--test_myPi_1 = abs (myPi - pi) < epsilon 

main = do 
  --putStrLn ("1 test_nat_1 " ++ (show test_nat_1))
  --putStrLn ("1 test_nat_2 " ++ (show test_nat_2))
  --putStrLn ("2 test_fibonacci_1 " ++ (show test_fibonacci_1))
  --putStrLn ("3 test_factorial_1 " ++ (show test_factorial_1))
  --putStrLn ("4 test_powerSeq_1 " ++ (show test_powerSeq_1))
  --putStrLn ("4 test_powerSeq_2 " ++ (show test_powerSeq_2))
  --putStrLn ("9 test_expAppr_1 " ++ (show test_expAppr_1))
  --putStrLn ("9 test_expAppr_2 " ++ (show test_expAppr_2))
  --putStrLn ("10 test_derivativeAppr_1 " ++ (show test_derivativeAppr_1))
  --putStrLn ("12 test_derivative_1 " ++ (show test_derivative_1))
  --putStrLn ("13 test_invF_1 " ++ (show test_invF_1))
  --putStrLn ("13 test_invF_2 " ++ (show test_invF_2))
  --putStrLn ("14 test_average_1 " ++ (show test_average_1))
  --putStrLn ("15 test_averageDump_1 " ++ (show test_averageDump_1))
  --putStrLn ("16 test_newtonTransform_1 " ++ (show test_newtonTransform_1))
  --putStrLn ("20 test_sqrt1_1 " ++ (show test_sqrt1_1))
  --putStrLn ("21 test_cubert1_1 " ++ (show test_cubert1_1))
  --putStrLn ("22 test_sqrt2_1 " ++ (show test_sqrt2_1))
  --putStrLn ("23 test_cubert2_1 " ++ (show test_cubert2_1))
  --putStrLn ("24 test_extremum_1 " ++ (show test_extremum_1))
  --putStrLn ("25 test_myPi_1 " ++ (show test_myPi_1))
  putStrLn "all tests done"







