(load "axioms.scm")

;;; The Little Prover
;;; Chapter 3 - What's in a Name?

;; Prove theorem `in-first-of-pair`
(J-Bob/prove (prelude)
             '(((defun pair (x y)
                  (cons x (cons y '())))
                nil)
               ((defun first-of (x)
                  (car x))
                nil)
               ((defun second-of (x)
                  (car (cdr x)))
                nil)
               ((defun in-pair? (xs)
                  (if (equal (first-of xs) '?)
                      't
                      (equal (second-of xs) '?)))
                nil)
               ((dethm in-first-of-pair (b)
                       (equal (in-pair? (pair '? b)) 't))
                nil
                ((1 1) (pair '? b))
                ((1) (in-pair? (cons '? (cons b '()))))
                ((1 Q 1) (first-of (cons '? (cons b '()))))
                ((1 Q 1) (car/cons '? (cons b '())))
                ((1 Q) (equal-same '?))
                ((1 E 1) (second-of (cons '? (cons b '()))))
                ((1 E 1 1) (cdr/cons '? (cons b '())))
                ((1 E 1) (car/cons b '()))
                ((1) (if-true 't (equal b '?)))
                (() (equal-same 't)))))

;; Prove theorem `in-second-of-pair`
(J-Bob/prove (prelude)
             '(((defun pair (x y)
                  (cons x (cons y '())))
                nil)
               ((defun first-of (x)
                  (car x))
                nil)
               ((defun second-of (x)
                  (car (cdr x)))
                nil)
               ((defun in-pair? (xs)
                  (if (equal (first-of xs) '?)
                      't
                      (equal (second-of xs) '?)))
                nil)
               ((dethm in-second-of-pair (b)
                       (equal (in-pair? (pair b '?)) 't))
                nil
                ((1 1) (pair b '?))
                ((1) (in-pair? (cons b (cons '? '()))))
                ((1 E 1) (second-of (cons b (cons '? '()))))
                ((1 E 1 1) (cdr/cons b (cons '? '())))
                ((1 E 1) (car/cons '? '()))
                ((1 E) (equal-same '?))
                ((1 Q 1) (first-of (cons b (cons '? '()))))
                ((1 Q 1) (car/cons b (cons '? '())))
                ((1) (if-same (equal b '?) 't))
                (() (equal-same 't)))))

;; Proven in recess.scm
(dethm first-of-pair (a b)
       (equal (first-of (pair a b)) a))

;; Proven in recess.scm
(dethm second-of-pair (a b)
       (equal (second-of (pair a b)) b))
