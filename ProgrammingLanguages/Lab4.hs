
-- Шаблон для выполнения заданий Лабораторной работы №4 
-- ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
-- предыдущее замечание относится к тем комментариям, которые
-- не предполагают раскомментирование
-- НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
-- решения заданий должны быть вписаны в отведенные для этого позиции 

-- ниеже перечисляются имена, доступные после загрузки данного модуля
-- (например в файле с тестами)
-- по мере реализации решений заданий снимайте комментарий 
-- с соответствующей функции
module Lab4(
  Expr ( Var, IntNum, Add, IfGreater, Fun, Call, Let
       , Pair, Head, Tail, Unit, IsAUnit, Closure )
  , valOfIntNum
  , funName
  , funArg
  , funBody
  , pairHead
  , pairTail
  , closureFun
  , closureEnv
  , convertListToMUPL
  , convertListFromMUPL
  , envLookUp
  , evalExp
  , evalUnderEnv
  , ifAUnit
  , mLet
  , ifEq
  , mMap
  , mMapAddN
  , fact
  )
  where
--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
data Expr = Var String
          | IntNum Integer
          | Add Expr Expr
          | IfGreater Expr Expr Expr Expr
          | Fun String String Expr
          | Call Expr Expr
          | Let (String, Expr) Expr
          | Pair Expr Expr
          | Head Expr
          | Tail Expr
          | Unit 
          | IsAUnit Expr
          | Closure [(String, Expr)] Expr
  deriving (Show, Eq) 

valOfIntNum (IntNum n) = n
valOfIntNum e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a number"
--------------------------------------------------------------------------------
-- Задание 1 funName 
funName (Fun name _ _) = name
funName e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a function"

-- Задание 2 funArg 
funArg (Fun _ s _) = s
funArg e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a function"

-- Задание 3 funBody 
funBody (Fun _ _ body) = body
funBody e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a function"

-- Задание 4 pairHead 
pairHead (Pair head _) = head
pairHead e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a pair"

-- Задание 5 pairTail 
pairTail (Pair _ tail) = tail
pairTail e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a pair"

-- Задание 6 closureFun 
closureFun (Closure _ f) = f
closureFun e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a closure"

-- Задание 7 closureEnv 
closureEnv (Closure e _) = e
closureEnv e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a closure"

-- Задание 8 convertListToMUPL 
convertListToMUPL [] = Unit
convertListToMUPL (l : ls) = Pair l (convertListToMUPL ls)

-- Задание 9 convertListFromMUPL 
convertListFromMUPL Unit = []
convertListFromMUPL (Pair e1 e2) = e1 : (convertListFromMUPL e2)

--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
envLookUp [] str = error $ "Unbound variable " ++ str
envLookUp ((var, expr) : xs) str 
  | var == str = expr
  | otherwise  = envLookUp xs str

evalExp e = evalUnderEnv e []
--------------------------------------------------------------------------------
-- Задание 10 evalUnderEnv 
-- Заданную строку определения изменять нельзя
-- необходимо дополнить определение функции
evalUnderEnv (Var name) env = envLookUp env name
evalUnderEnv (IntNum n) env = IntNum n
evalUnderEnv (Add e1 e2) env =
  IntNum ( valOfIntNum (evalUnderEnv e1 env)
           + valOfIntNum (evalUnderEnv e2 env) )
evalUnderEnv (IfGreater e1 e2 e3 e4) env =
  if valOfIntNum (evalUnderEnv e1 env) > valOfIntNum (evalUnderEnv e2 env)
  then evalUnderEnv e3 env
  else evalUnderEnv e4 env
evalUnderEnv (Pair e1 e2) env =
  Pair (evalUnderEnv e1 env) (evalUnderEnv e2 env)
evalUnderEnv (Head e) env = pairHead (evalUnderEnv e env)
evalUnderEnv (Tail e) env = pairTail (evalUnderEnv e env)
evalUnderEnv Unit env = Unit
evalUnderEnv (IsAUnit e) env =
  if evalUnderEnv e env == Unit then IntNum 1 else IntNum 0
evalUnderEnv (Let (str, e1) e2) env =
  evalUnderEnv e2 ((str, evalUnderEnv e1 env) : env)
evalUnderEnv (Closure env1 f) env = Closure env1 f
evalUnderEnv (Fun name arg e) env = Closure env (Fun name arg e)
evalUnderEnv (Call e1 e2) env =
  let
    v1 = evalUnderEnv e1 env
    clsre = closureFun v1
    env2 = (funArg clsre, evalUnderEnv e2 env) : (closureEnv v1)
  in
    evalUnderEnv (funBody clsre) ( if not (null (funName clsre))
                                   then (funName clsre, v1) : env2
                                   else env2 )
--------------------------------------------------------------------------------
-- Последующие решения связывают переменные Haskellа с выражениями на MUPL
-- (определяют макросы языка MUPL)
-- Задание 11 ifAUnit 
ifAUnit e1 e2 e3 = IfGreater (IsAUnit e1) (IntNum 0) e2 e3

-- Задание 12 mLet 
mLet [] e = e
mLet (l : ls) e = Let l (mLet ls e)

-- Задание 13 ifEq 
ifEq e1 e2 e3 e4 =
  Let ("_x", e1)
    (Let ("_y", e2)
      ( IfGreater (Var "_x") (Var "_y") e4
          (IfGreater (Var "_y") (Var "_x") e4 e3 )))

-- Задание 14 mMap 
mMap =
  Fun "" "f"
    (Fun "g" "ls"
      (ifAUnit (Tail (Var "ls")) (Pair (Call (Var "f") (Head (Var "ls"))) Unit)
       (Pair (Call (Var "f") (Head (Var "ls"))) (Call (Var "g")
                                                      (Tail (Var "ls"))))))

-- Задание 15 mMapAddN 
mMapAddN (IntNum n) = Call mMap (Fun "" "x" (Add (Var "x") (IntNum n)))

-- Задание 16 fact 
fact =
  Fun "" "x"
    (Let ("res", Fun "2" "z"
          (ifEq (Var "z") (Var "x") (Var "x")
            (Call
              (Call
               (Call helper (Var "z")) (Call (Var "2") (Add (Var "z") (IntNum 1)))) (IntNum 0) )) )
        (Call (Var "res") (IntNum 1)))
 
 
 
helper = Fun "helper" "t"
        (Fun "2" "u"
          (Fun "3" "v"
            (ifEq (Var "v") (Var "t") (IntNum 0)
              (Add (Var "u") (Call (Var "3") (Add (IntNum 1) (Var "v")) )))))