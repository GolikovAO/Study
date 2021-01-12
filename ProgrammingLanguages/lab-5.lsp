;;; ������ ��� ���������� ������� ������������ ������ �5 
;;; ��� ����������� ����������� � ������ ����� ������ �������� �� ����� ������
;;; ������ ������������ ������� �����-���� ����� ������� �����
;;; ������� ������� ������ ���� ������� � ���������� ��� ����� ������� 

;;; ��������������� ����������� 
;;; ������ ������� ��������� � ��������� ����
;; ���������� �������������� (�.�. �������������� �������������
;; �������� �������� � ����� �������������� �� ������������� 
;; ����������� �������)
(declaim (sb-ext:muffle-conditions style-warning))

;; ������������ ���������� on-unknown-expression
;; ������� �������������� ��������� ��� ��������� 
;; ������������ ���������
(define-condition on-unknown-expression (error)
   ((message :initarg :message :reader message))
)

;;; ������� ������� 

;; ������� 1. ��������� ��� ���������

(defun 0? (x) (cond ((numberp x) (= x 0))))

(defun 1? (x) (cond ((numberp x) (= x 1))))

(defun +? (expr) (cond ((listp expr) (eq (car expr) '+))))

(defun -? (expr) (cond ((listp expr) 
                        (cond ((eq (car expr) '-) 
                               (> (length (cdr expr)) 0))))))

(defun *? (expr) (cond ((listp expr) (eq (car expr) '*))))

(defun /? (expr) (cond ((listp expr) 
                        (cond ((eq (car expr) '/) 
                               (> (length (cdr expr)) 0))))))

(defun expt? (expr) (cond ((listp expr) 
                           (cond ((eq (car expr) 'expt)
                                  (= (length (cdr expr)) 2))))))

(defun sqrt? (expr) (cond ((listp expr) 
                           (cond ((eq (car expr) 'sqrt)
                                  (= (length (cdr expr)) 1))))))

(defun sin? (expr) (cond ((listp expr) 
                          (cond ((eq (car expr) 'sin)
                                 (= (length (cdr expr)) 1))))))

(defun cos? (expr) (cond ((listp expr) 
                          (cond ((eq (car expr) 'cos)
                                 (= (length (cdr expr)) 1))))))

(defun tan? (expr) (cond ((listp expr) 
                          (cond ((eq (car expr) 'tan)
                                 (= (length (cdr expr)) 1))))))

(defun asin? (expr) (cond ((listp expr) 
                           (cond ((eq (car expr) 'asin)
                                  (= (length (cdr expr)) 1))))))

(defun acos? (expr) (cond ((listp expr) 
                           (cond ((eq (car expr) 'acos)
                                  (= (length (cdr expr)) 1))))))

(defun atan? (expr) (cond ((listp expr) 
                           (cond ((eq (car expr) 'atan)
                                  (= (length (cdr expr)) 1))))))

(defun exp? (expr) (cond ((listp expr) 
                          (cond ((eq (car expr) 'exp)
                                 (= (length (cdr expr)) 1))))))

(defun log? (expr) (cond ((listp expr) 
                          (cond ((eq (car expr) 'log)
                                 (cond ((> (length (cdr expr)) 0)
                                        (< (length (cdr expr)) 3))))))))

;; ������� 2. ������������ ��� ���������

(defun make+ (&rest x) (append '(+) x))

(defun make- (y &rest x) (append (list '- y) x))

(defun make* (&rest x) (append '(*) x))

(defun make/ (y &rest x) (append (list '/ y) x))

(defun makeexpt (x y) (list 'expt x y))

(defun makesqrt (x) (list 'sqrt x))

(defun makesin (x) (list 'sin x))

(defun makecos (x) (list 'cos x))

(defun maketan (x) (list 'tan x))

(defun makeasin (x) (list 'asin x))

(defun makeacos (x) (list 'acos x))

(defun makeatan (x) (list 'atan x))

(defun makeexp (x) (list 'exp x))

(defun makelog (x &optional y) (if (null y) (list 'log x) (list 'log x y)))

;; ������� 3. ������������ ���������
;; ��������� ������� ������ �������� ��� ���������
(defun normalize (expr)
  (cond 
    ((atom expr) expr)  
    ((+? expr) (+-normalize expr))
    ((-? expr) (--normalize expr))
    ((*? expr) (*-normalize expr))
    ((/? expr) (/-normalize expr))
    ((expt? expr) (expt-normalize expr))
    ((sqrt? expr) (sqrt-normalize expr))
    ((sin? expr) (sin-normalize expr))
    ((cos? expr) (cos-normalize expr))
    ((tan? expr) (tan-normalize expr))
    ((asin? expr) (asin-normalize expr))
    ((acos? expr) (acos-normalize expr))
    ((atan? expr) (atan-normalize expr))
    ((exp? expr) (exp-normalize expr))
    ((log? expr) (log-normalize expr))
    (T (error 'on-unknown-expression))))

;; +-normalize

(defun +-normalize (expr) 
  (let ((len (length (cdr expr))))
    (if (= len 0) 0 
      (if (= len 1) (normalize (cadr expr)) 
        (make+ (normalize (cadr expr)) 
               (normalize (append '(+) (cddr expr))))))))

;; --normalize

(defun --normalize (expr)
  (if (= (length (cdr expr)) 1) (make* -1 (normalize (cadr expr)))
    (make+ (normalize (cadr expr))
           (make* -1 (normalize (append '(+) (cddr expr)))))))

;; *-normalize

(defun *-normalize (expr) 
  (let ((len (length (cdr expr))))
    (if (= len 0) 1 
      (if (= len 1) (normalize (cadr expr)) 
        (make* (normalize (cadr expr)) 
               (normalize (append '(*) (cddr expr))))))))

;; /-normalize

(defun /-normalize (expr)
  (let ((len (length (cdr expr))))
    (if (= len 1) (make/ (normalize (cadr expr)))
      (make* (normalize (cadr expr))
             (if (= len 2) 
               (make/ (make* (normalize (caddr expr))))
               (make/ (normalize (append '(*) (cddr expr)))))))))

;; expt-normalize

(defun expt-normalize (expr)
  (makeexpt (normalize (cadr expr))
            (normalize (caddr expr))))

;; sqrt-normalize

(defun sqrt-normalize (expr)
  (makeexpt (normalize (cadr expr)) (/ 1 2)))

;; sin-normalize

(defun sin-normalize (expr)
  (makesin (normalize (cadr expr))))

;; cos-normalize

(defun cos-normalize (expr)
  (makecos (normalize (cadr expr))))

;; tan-normalize

(defun tan-normalize (expr)
  (let ((e (normalize (cadr expr))))
    (make* (makesin e) (make/ (makecos e)))))

;; asin-normalize

(defun asin-normalize (expr)
  (makeasin (normalize (cadr expr))))

;; acos-normalize

(defun acos-normalize (expr)
  (makeacos (normalize (cadr expr))))

;; atan-normalize

(defun atan-normalize (expr)
  (makeatan (normalize (cadr expr))))

;; exp-normalize

(defun exp-normalize (expr)
  (makeexp (normalize (cadr expr))))

;; log-normalize

(defun log-normalize (expr)
  (cond
    ((null (caddr expr)) expr)
    (T (make* (makelog (normalize (cadr expr))) 
           (make/ (makelog (normalize (caddr expr))))))))

;; ��������� ���������
;; ��������� ������� ������ �������� ��� ���������
(defun simplify (expr)
  (let ((expr (normalize expr)))
    (cond 
      ((atom expr) expr)
      ((+? expr) (simplify+ expr))
      ((*? expr) (simplify* expr))
      ((/? expr) (simplify/ expr))
      ((expt? expr) (simplifyexpt expr))
      ((sin? expr) (simplify-fun-1 expr))
      ((cos? expr) (simplify-fun-1 expr))
      ((asin? expr) (simplify-fun-1 expr))
      ((acos? expr) (simplify-fun-1 expr))
      ((atan? expr) (simplify-fun-1 expr))
      ((exp? expr) (simplifyexp expr))
      ((log? expr) (simplifylog expr))
      (T (error 'on-unknown-expression)))))

;; ������� 4. ��������� ��������
;; simplify+

(defun simplify+ (expr)
  (let ((slugA (simplify (cadr expr)))
        (slugB (simplify (caddr expr))))
    (cond
      ((0? slugA) slugB)
      ((0? slugB) slugA)
      ((numberp slugA) (simplify+-aux1 slugB slugA))
      ((numberp slugB) (simplify+-aux1 slugA slugB))
      ((+? slugA) (simplify+-aux2 slugB slugA))
      ((+? slugB) (simplify+-aux2 slugA slugB))
      (T (make+ slugA slugB)))))

;; simplify+-aux1

(defun simplify+-aux1 (expr n)
  (cond
    ((numberp expr) (+ expr n))
    ((+? expr) (if (numberp (cadr expr)) 
                 (append '(+) (list (+ (cadr expr) n)) (cddr expr)) 
                 (append '(+) (list n) (cdr expr))))
    (T (make+ n expr))))

;; simplify+-aux2

(defun simplify+-aux2 (expr +expr)
  (cond
    ((numberp expr) (simplify+-aux1 +expr expr))
    ((+? expr) (cond
                 ((numberp (cadr expr)) 
                    (simplify+-aux1 (append +expr (cddr expr)) (cadr expr)))
                 ((numberp (cadr +expr)) 
                    (simplify+-aux1 (append expr (cddr +expr)) (cadr +expr)))
                 (T (append '(+) (cdr expr) (cdr +expr)))))
    (T (append +expr (list expr)))))

;; ������� 5. ��������� ���������
;; simplify*

(defun simplify* (expr)
  (let ((mn1 (simplify (cadr expr)))
        (mn2 (simplify (caddr expr))))
    (cond
      ((0? mn1) 0)
      ((0? mn2) 0)
      ((1? mn1) mn2)
      ((1? mn2) mn1)
      ((numberp mn1) (simplify*-aux1 mn2 mn1))
      ((numberp mn2) (simplify*-aux1 mn1 mn2))
      ((*? mn1) (simplify*-aux2 mn2 mn1))
      ((*? mn2) (simplify*-aux2 mn1 mn2))
      ((and (/? mn1) (equal (cadr mn1) mn2)) 1)
      ((and (/? mn2) (equal (cadr mn2) mn1)) 1)
      ((+? mn1) (simplify (append '(+) (simplify*-through+ 
                                       (cdr mn1) 
                                       mn2))))
      ((+? mn2) (simplify (append '(+) (simplify*-through+ 
                                       (cdr mn2) 
                                       mn1))))
      (T (make* mn1 mn2)))))

;; simplify*-through+

(defun simplify*-through+ (exprs n)
  (let ((x (car exprs)))
    (cond
      ((eq x NIL) NIL)
      (T (append (list (make* n x)) (simplify*-through+ (cdr exprs) n))))))

;; simplify*-aux1

(defun simplify*-aux1 (expr n)
  (cond
    ((numberp expr) (* expr n))
    ((*? expr) (if (numberp (cadr expr)) 
                 (append '(*) (list (* (cadr expr) n)) (cddr expr)) 
                 (append '(*) (list n) (cdr expr))))
    ((+? expr) (simplify (append '(+) (simplify*-through+ (cdr expr) n))))
    (T (make* n expr))))

;; simplify*-aux2

(defun simplify*-aux2 (expr *expr)
  (cond
    ((numberp expr) (simplify*-aux1 *expr expr))
    ((*? expr) (cond
                 ((numberp (cadr expr)) 
                    (simplify*-aux1 (append *expr (cddr expr)) (cadr expr)))
                 ((numberp (cadr *expr)) 
                    (simplify*-aux1 (append expr (cddr *expr)) (cadr *expr)))
                 (T (append '(*) (cdr expr) (cdr *expr)))))
    ((+? expr) (simplify (append '(+) (simplify*-through+ (cdr expr) *expr))))
    (T (append *expr (list expr)))))

;; ������� 6. ��������� ��������� �������� (�������� �������)
;; simplify/

(defun simplify/ (expr)
  (let ((expr (simplify (cadr expr))))
    (cond
      ((numberp expr) (/ expr))
      ((/? expr) (cadr expr))
      ((*? expr) (simplify (append '(*) (simplify/-through* (cdr expr)))))
      (T (make/ expr)))))

;; simplify/-through*

(defun simplify/-through* (exprs)
  (let ((x (car exprs)))
    (cond
      ((eq x NIL) NIL)
      (T (append (list (make/ x)) (simplify/-through* (cdr exprs)))))))

;; ������� 7. ��������� ���������� � �������
;; simplifyexpt

(defun simplifyexpt (expr)
  (let ((base (simplify (cadr expr)))
        (pow (simplify (caddr expr))))
    (cond
      ((0? pow) 1)
      ((0? base) 0)
      ((1? base) 1)
      ((1? pow) base)
      ((and (numberp base) (numberp pow)) (expt base pow))
      ((expt? base) (simplify (makeexpt (cadr base) 
                                          (make* (caddr base) pow))))
      ((exp? base) (simplify (makeexp (make* (cadr base) pow))))
      (T (makeexpt base pow)))))

;; ������� 8. ��������� ��������� �������
;; simplify-fun-1

(defun simplify-fun-1 (expr)
  (let* ((argument (simplify (cadr expr)))
         (expr (append (list (car expr)) (list argument))))
    (cond
      ((numberp argument) (eval expr))
      (T expr))))

;; simplifyexp

(defun simplifyexp (expr)
  (let* ((argument (simplify (cadr expr)))
         (expr (append (list (car expr)) (list argument))))
    (cond
      ((numberp argument) (eval expr))
      ((log? argument) (cadr argument))
      (T expr))))

;; simplifylog

(defun simplifylog (expr)
  (let ((argument (simplify (cadr expr))))
    (cond
      ((numberp argument) (log argument))
      ((exp? argument) (cadr argument))
      ((expt? argument) (simplify (make* (caddr argument) (makelog (cadr argument)))))
      (T (makelog argument)))))

;; ����������� ���������
;; ��������� ������� ������ �������� ��� ���������
(defun deriv (expr var) 
  (cond 
    ((atom expr) (if (eq expr var) 1 0))  
    ((+? expr) (+-deriv expr var))
    ((*? expr) (*-deriv expr var))
    ((/? expr) (/-deriv expr var))
    ((expt? expr) (expt-deriv expr var))
    ((sin? expr) (sin-deriv expr var))
    ((cos? expr) (cos-deriv expr var))
    ((asin? expr) (asin-deriv expr var))
    ((acos? expr) (acos-deriv expr var))
    ((atan? expr) (atan-deriv expr var))
    ((exp? expr) (exp-deriv expr var))
    ((log? expr) (log-deriv expr var))
    (T (error 'on-unknown-expression))))

;; ������� 9. ����������� ����� 
;; +-deriv

(defun +-deriv (expr var)
  (make+ (deriv (cadr expr) var)
         (deriv (caddr expr) var)))

;; ������� 10. ����������� ������������
;; *-deriv

(defun *-deriv (expr var)
  (let ((u (cadr expr))
        (v (caddr expr)))
    (make+ (make* (deriv u var) v)
           (make* (deriv v var) u))))

;; ������� 11. ����������� ��������� ��������
;; /-deriv

(defun /-deriv (expr var)
  (let ((u (cadr expr)))
    (make* (make- (make/ (makeexpt u 2))) (deriv u var))))

;; ������� 12. ����������� ��������� �������
;; expt-deriv

(defun expt-deriv (expr var)
  (let ((u (cadr expr))
        (v (caddr expr)))
    (make+ (make* v (makeexpt u (make- v 1)) (deriv u var))
           (make* (makeexpt u v) (deriv v var) (makelog u)))))

;; ������� 13. ����������� ������������������ �������
;; sin-deriv

(defun sin-deriv (expr var)
  (let ((u (cadr expr)))
    (make* (deriv u var) (makecos u))))

;; cos-deriv

(defun cos-deriv (expr var)
  (let ((u (cadr expr)))
    (make* (make- (deriv u var)) (makesin u))))

;; ������� 14. ����������� �������� ������������������ �������
;; asin-deriv

(defun asin-deriv (expr var)
  (let ((u (cadr expr)))
    (make/ (deriv u var) (makesqrt (make- 1 (makeexpt u 2))))))

;; acos-deriv

(defun acos-deriv (expr var)
  (let ((u (cadr expr)))
    (make- (make/ (deriv u var) (makesqrt (make- 1 (makeexpt u 2)))))))

;; atan-deriv

(defun atan-deriv (expr var)
  (let ((u (cadr expr)))
    (make/ (deriv u var) (makesqrt (make+ 1 (makeexpt u 2))))))

;; ������� 15. ����������� ���������� � ������������ ���������
;; exp-deriv

(defun exp-deriv (expr var)
  (let ((u (cadr expr)))
    (make* (makeexp u) (deriv u var))))

;; log-deriv

(defun log-deriv (expr var)
  (let ((u (cadr expr)))
    (make* (make/ u) (deriv u var))))