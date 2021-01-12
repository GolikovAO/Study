;;; �������������� ����� ������ ��� ������������ ������ �5
;;; �� ���� ���������� ������� ������� ���������� �� ������ �������

;;; ��� ����������� ����������� � ������ ����� 
;;; � ���� �������������� ����� ������ ������ �������� �� ����� ������
;;; ������ ������������ ������� �����-���� ����� ������� �����
;;; �������������� ����� ������ ���������� ���������� ��� ��� �����
;;; ����� ��������������� �������
;;; ������ (line) � (starline), ��������� �������������� ����� ���
;;; ������ ������, ������ �������� �� ����� ������ 

;;; ��� ���������� ������ ��������� ���� ���� 
;;; ���� ����� ���� ������� ���� ��� ���������� ���������� ����������� �������

(load "lab-5.lsp")

;;; ��������������� �����������

;; ������ ��� ���������� �����, � ���������� �������� �� ������ ���� 
;; ��������� �� �������
;; fun - ��� ����������� �������
;; num - ����� �����
;; test-expr - �������� ��������� (����������� �������� ������ ���� T)
(defmacro result-test (fun num test-expr)
  `(progn
    (format T "function: ~A ~30,2Ttest: ~A ~Tresult: ~A~%" 
            ',fun ,num
            (handler-case 
               ,test-expr
             (T () NIL)))))

;; ������ ��� ���������� ����� ����������� �������� ������ ���� 
;; ��������� �� ������ error-type
;; fun - ��� ����������� �������
;; num - ����� �����
;; error-type - ��� ���������� (T - ���� �����)
;; test-expr - �������� ��������� (����������� �������� ������ ���� ��������� 
;;             � ��������������� ������)
(defmacro error-test (fun num error-type test-expr)
  `(progn
    (format T "function: ~A ~30,2Ttest: ~A ~Tresult: ~A~%" 
            ',fun ,num
            (handler-case 
               ,test-expr
             (,error-type () T)
             (T () NIL)))))

;; ������� ������ �������������� �����
(defun line ()
  (format T "~V@{~a~:*~}~%" 50 "-"))
(defun starline ()
  (format T "~V@{~a~:*~}~%" 50 "*"))


;;; �����
;; ������ ���� ������ ����������� ��� ����� �������
;;
;; (result-test f N expr)
;;
;; � ������� f - ��� ����������� �������
;;           N - ����� ����� ��� ������� f
;;        expr - �������� ���������, ������� ��������� ������������
;;               ������� f �� �����-�� �������� ������; ��������� ������ 
;;               �������� T � ������ �������� �������� 
;;
;; ���, ���� ����������� ��������� ������� ���������� �������,
;; ����� �������
;;
;; (error-test f N err expr)
;;
;; ��� f, N, expr - �� ��, ��� � � ���������� ������, �� 
;; �����������, ��� ���������� expr ��������� � ������� err
;; err ����� ���� ������ T, ���� ������ �����
(line)
(starline)

;; ������� 1. ��������� ��� ���������
;; 0? 
(result-test 0? 1 
  (eq (0? 0) T))

(result-test 0? 2
  (eq (0? 1) NIL))

(result-test 0? 3
  (eq (0? '()) NIL))

(line)
;; 1?
(result-test 1? 1 
  (eq (1? 1) T))

(result-test 1? 2 
  (eq (1? 0) NIL))

(result-test 1? 3 
  (eq (1? 5) NIL))

(line)
;; +?
(result-test +? 1 
  (eq (+? '(+ 1 2)) T))

(result-test +? 2 
  (eq (+? '(+ 1 5)) T))

(line)
;; -?
(result-test -? 1 
  (eq (-? '(- 1 2)) T))

(result-test -? 2 
  (eq (-? '(- 1 0)) T))

(line)
;; *?
(result-test *? 1 
  (eq (*? '(* 1 2)) T))

(result-test *? 2 
  (eq (*? '(* 1 3)) T))

(line)
;; /?
(result-test /? 1 
  (eq (/? '(/ 1 2)) T))

(result-test /? 2 
  (eq (/? (/ 1 3)) NIL))

(line)
;; expt?
(result-test expt? 1 
  (eq (expt? '(expt 1 2)) T))

(result-test expt? 2 
  (eq (expt? '(expt 2 2 2)) NIL))

(line)
;; sqrt?
(result-test sqrt? 1 
  (eq (sqrt? '(sqrt 1)) T))

(result-test sqrt? 2 
  (eq (sqrt? '(sqrt 2)) T))

(line)
;; sin?
(result-test sin? 1 
  (eq (sin? '(sin 1)) T))

(line)
;; cos?
(result-test cos? 1 
  (eq (cos? '(cos 1)) T))

(line)
;; tan?
(result-test tan? 1 
  (eq (tan? '(tan 1)) T))
(result-test tan? 2 
  (eq (tan? '(tan 3 24)) NIL))
(line)

;; asin?
(result-test asin? 1 
  (eq (asin? '(asin 1)) T))
(result-test asin? 2
  (eq (asin? '(asin)) NIL))
(result-test asin? 3
  (eq (asin? '(asin 60)) T))
(result-test asin? 4
  (eq (asin? '(asin 90 19)) NIL))

(line)
;; acos?
(result-test acos? 1
  (eq (acos? '()) NIL))
(result-test acos? 2
  (eq (acos? '(acos)) NIL))
(result-test acos? 3
  (eq (acos? '(acos 45)) T))
(result-test acos? 4
  (eq (acos? '(acos 45 19)) NIL))

(line)
;; atan?
(result-test atan? 1 
  (eq (atan? '(atan 1)) T))
(result-test atan? 2
  (eq (atan? '(atan)) NIL))
(result-test atan? 3
  (eq (atan? '(atan 80)) T))

(line)
;; exp?
(result-test exp? 1 
  (eq (exp? '(exp 1)) T))

(line)
;; log?
(result-test log? 1 
  (eq (log? '(log 2 3)) T))

(line)
(starline)
;; ������� 2. ������������ ��� ���������
;; make+
(result-test make+ 1
  (equal (make+ 2 3 4) '(+ 2 3 4)))

(result-test make+ 2
  (equal (make+ 2 3 4) '(+ 2 3 4)))

(line)
;; make-
(result-test make- 1
  (equal (make- 2 3 4) '(- 2 3 4)))

(error-test make- 2 T
  (equal (make-) '(- 2 3 4)))

(line)
;; make*
(result-test make* 1
  (equal (make* 2 3 4) '(* 2 3 4)))

(result-test make* 2
  (equal (make* 0) '(* 0)))

(line)
;; make/
(result-test make/ 1
  (equal (make/ 2 3 4) '(/ 2 3 4)))

(line)
;; makeexpt
(result-test makeexpt 1
  (equal (makeexpt 2 3) '(expt 2 3)))

(result-test makeexpt 2
  (equal (makeexpt 4 1) '(expt 4 1)))

(line)
;; makesqrt
(result-test makesqrt 1
  (equal (makesqrt 2) '(sqrt 2)))

(line)
;; makesin
(result-test makesin 1
  (equal (makesin 1) '(sin 1)))

(line)
;; makecos
(result-test makecos 1
  (equal (makecos 1) '(cos 1)))

(line)
;; maketan
(result-test maketan 1
  (equal (maketan 1) '(tan 1)))

(line)
;; makeasin
(result-test makeasin 1
  (equal (makeasin 1) '(asin 1)))

(line)
;; makeacos
(result-test makeacos 1
  (equal (makeacos 1) '(acos 1)))

(line)
;; makeatan
(result-test makeatan 1
  (equal (makeatan 1) '(atan 1)))

(line)
;; makeexp
(result-test makeexp 1
  (equal (makeexp 1) '(exp 1)))

(line)
;; makelog
(result-test makelog 1
  (equal (makelog 1 2) '(log 1 2)))

(line)
(starline)
;; ������� 3. ������������ ���������
;; +-normalize
(result-test +-normalize 1
  (equal (normalize '(+)) 0)) 

(result-test +-normalize 2
  (equal (normalize '(+ 1 2 3 4 5 6))
         '(+ 1 (+ 2 (+ 3 (+ 4 (+ 5 6))))))) 

(line)
;; *-normalize
(result-test *-normalize 1
  (equal (normalize '(*)) 1)) 

(line)
;; /-normalize
(error-test /-normalize 1 on-unknown-expression
  (equal (normalize '(/)) 1)) 

(line)
;; expt-normalize
(result-test expt-normalize 1 
  (equal (normalize '(expt 2 1)) '(expt 2 1))) 

(line)
;; sqrt-normalize
(result-test sqrt-normalize 1 
  (equal (normalize '(sqrt 4)) '(expt 4 1/2))) 

(line)
;; sin-normalize
(result-test sin-normalize 1 
  (equal (normalize '(sin x)) '(sin x))) 

(line)
;; cos-normalize
(result-test cos-normalize 1 
  (equal (normalize '(cos x)) '(cos x))) 

(line)
;; tan-normalize
(result-test tan-normalize 1 
  (equal (normalize '(tan x)) '(* (sin x) (/ (cos x))))) 

(line)
;; asin-normalize
(result-test asin-normalize 1 
  (equal (normalize '(asin x)) '(asin x))) 

(line)
;; acos-normalize
(result-test acos-normalize 1 
  (equal (normalize '(acos x)) '(acos x))) 

(line)
;; atan-normalize
(result-test atan-normalize 1 
  (equal (normalize '(atan x)) '(atan x))) 

(line)
;; exp-normalize
(result-test exp-normalize 1 
  (equal (normalize '(exp x)) '(exp x))) 

(line)
;; log-normalize
(result-test log-normalize 1 
  (equal (normalize '(log x y)) '(* (log x) (/ (log y))))) 

(line)
;; ����� ����� normalize
(result-test normalize 1 
  (equal (normalize '(+ x (- y 1 3))) '(+ x (+ y (* -1 (+ 1 3))))))

(line)
(starline)
;; ��������� ���������
;; ������� 4. ��������� ��������
;; simplify+
(result-test simplify+ 1 
  (= (simplify '(+ 3 8)) 11)) 

(line)
;; simplify+-aux1
(result-test simplify+-aux1 1 
  (= (simplify+-aux1 2 3) 5)) 

(line)
;; simplify+-aux2
(result-test simplify+-aux2 1 
  (equal (simplify+-aux2 '3 '(+ 5 y)) '(+ 8 y))) 

;; ������� 5. ��������� ���������
(line)
;; simplify*
(result-test simplify* 1 
  (= (simplify '(* 3 8)) 24)) 

(line)
;; simplify*-through+
(result-test simplify*-through+ 1 
  (equal (simplify*-through+ '(4 (+ 4 x) (* 5 y) (- x)) 3) 
         '((* 3 4) (* 3 (+ 4 x)) (* 3 (* 5 y)) (* 3 (- x))))) 

(line)
;; simplify*-aux1
(result-test simplify*-aux1 1 
  (= (simplify*-aux1 2 3) 6)) 

(line)
;; simplify*-aux2
(result-test simplify*-aux2 1 
  (equal (simplify*-aux2 3 '(* 5 y)) '(* 15 y))) 

;; ������� 6. ��������� ��������� �������� (�������� �������)
(line)
;; simplify/
(result-test simplify/ 1 
  (equal (simplify '(/ (/ (/ (/ x))))) 'x)) 

(line)
;; simplify/-through*
(result-test simplify/-through* 1 
  (equal (simplify/-through* '(4 (+ 4 x) (* 5 y) (/ x))) 
         '((/ 4) (/ (+ 4 x)) (/ (* 5 y)) (/ (/ x))))) 

;; ������� 7. ��������� ���������� � �������
(line)
;; simplifyexpt
(result-test simplifyexpt 1 
  (equal (simplify '(expt x 1)) 'x)) 

;; ������� 8. ��������� ��������� �������
(line)
;; simplify-fun-1
(result-test simplify-fun-1 1 
  (= (simplify '(cos (sin 0))) 1)) 

(line)
;; simplifyexp
(result-test simplifyexp 1 
  (= (simplify '(exp 0)) 1)) 

(line)
;; simplifylog
(result-test simplifylog 1 
  (eq (simplify '(log (exp x))) 'x)) 

(result-test simplifylog 2 
  (= (simplify '(log 1)) 0)) 

(line)
;; ����� simplify
(result-test simplify 1 
  (equal (simplify '(- (+ (- (log (exp x)) 2)) 1)) '(+ -3 X))) 

(error-test simplify 2 on-unknown-expression 
  (equal (simplify '(- (+ (- (sinh (exp x)) 2)) 1)) '(+ -3 X))) 


(line)
(starline)
;; ����������� ���������
;; ������� 9. ����������� ����� � ��������
;; +-deriv
(result-test +-deriv 1 
  (= (simplify 
       (deriv (normalize '(+ x y (+ x y 5) 25 x)) 
              'x)) 
     3)) 


(line)
;; --deriv
(result-test --deriv 1 
  (= (simplify 
       (deriv (normalize '(- (- (- (- x))))) 
              'x)) 
     1)) 

;; ������� 10. ����������� ������������
(line)
;; *-deriv
(result-test *-deriv 1 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(* x 5 x y)) 
                'x))) 
     60))

;; ������� 11. ����������� ��������� ��������
(line)
;; /-deriv
(result-test /-deriv 1 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(/ x 5 x y)) 
                'x))) 
     0))

;; ������� 12. ����������� ��������� �������
(line)
;; expt-deriv
(result-test expt-deriv 1 
  (= (let ((x 1))
       (declare (special x))
       (eval 
         (deriv '(expt x x) 'x))) 
     1.0))

;; ������� 13. ����������� ������������������ �������
(line)
;; sin-deriv
(result-test sin-deriv 1 
  (let ((x (/ pi 4)))
    (declare (special x))
    (= (eval 
         (deriv '(sin x) 'x))
       (cos x))))

(line)
;; cos-deriv
(result-test cos-deriv 1 
  (let ((x (/ pi 4)))
    (declare (special x))
    (= (eval 
         (deriv '(cos x) 'x))
       (- (sin x)))))

;; ������� 14. ����������� �������� ������������������ �������
(line)
;; asin-deriv
(result-test asin-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(asin x) 'x))
       1.0)))

(line)
;; acos-deriv
(result-test acos-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(acos x) 'x))
       -1.0)))

(line)
;; atan-deriv
(result-test atan-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(atan x) 'x))
       1.0)))

;; ������� 15. ����������� ���������� � ������������ ���������
(line)
;; exp-deriv
(result-test exp-deriv 1 
  (equal (simplify (deriv '(exp x) 'x))
         '(exp x)))

(line)
;; log-deriv
(result-test log-deriv 1 
  (equal (simplify (deriv '(log x) 'x))
         '(/ x)))

(line)
;; ����������� ������������ ���������
(result-test deriv 1 
  (let ((expr '(+ (* x x) 
                  (sqrt (* x x))
                  (* x y)
                  (* 2 x x)))
        (x 2) (y 3))
    (declare (special x y))
    (= (eval (deriv (normalize expr) 'x))
       16)))

(error-test deriv 2 on-unknown-expression
  (eq (deriv '(sqrt x) 'x) NIL))

(line)
(starline)