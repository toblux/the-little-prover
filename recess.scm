(load "axioms.scm")

;;; Recess - Appendix A

;; frame recess:3
(J-Bob/step (prelude)
            '(car (cons 'ham '(cheese)))
            '())

;; frame recess:7
(J-Bob/step (prelude)
            '(car (cons 'ham '(cheese)))
            '((() (car/cons 'ham '(cheese)))))

;; frame recess:9
(J-Bob/step (prelude)
            '(equal 'flapjack (atom (cons a b)))
            '(((2) (atom/cons a b))
              (() (equal 'flapjack 'nil))))

;; frame recess:10
(J-Bob/step (prelude)
            '(atom (cdr (cons (car (cons p q)) '())))
            '(((1 1 1) (car/cons p q))
              ((1) (cdr/cons p '()))
              (() (atom '()))))

;; frame recess:14
(J-Bob/step (prelude)
            '(if a c c)
            '())

;; frame recess:15
(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))))

;; frame recess:16
(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (()
               (if-same
                (if (equal a 't)
                    (if (equal 'nil 'nil) a b)
                    (equal 'or
                           (cons 'black '(coffee))))
                c))))

;; frame recess:17
(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (() (if-same
                   (if (equal a 't)
                       (if (equal 'nil 'nil) a b)
                       (equal 'or
                              (cons 'black '(coffee))))
                   c))
              ((Q E 2) (cons 'black '(coffee)))))

;; frame recess:22
(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (() (if-same
                   (if (equal a 't)
                       (if (equal 'nil 'nil) a b)
                       (equal 'or
                              (cons 'black '(coffee))))
                   c))
              ((Q E 2) (cons 'black '(coffee)))
              ((Q A Q) (equal-same 'nil))))

;; frame recess:27
(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (() (if-same
                   (if (equal a 't)
                       (if (equal 'nil 'nil) a b)
                       (equal 'or
                              (cons 'black '(coffee))))
                   c))
              ((Q E 2) (cons 'black '(coffee)))
              ((Q A Q) (equal-same 'nil))
              ((Q A) (if-true a b))))

;; frame recess:30
(J-Bob/prove (prelude)
             '(((defun pair (x y)
                  (cons x (cons y '())))
                nil)))

;; Prove theorem `first-of-pair` - frame recess:38
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
               ((dethm first-of-pair (a b)
                       (equal (first-of (pair a b)) a))
                nil
                ((1 1) (pair a b))
                ((1) (first-of (cons a (cons b '()))))
                ((1) (car/cons a (cons b '())))
                (() (equal-same a)))))

;; Extend `prelude` with theorem `first-of-pair` - frame recess:42
(defun prelude+first-of-pair ()
  (J-Bob/define (prelude)
                '(((defun pair (x y)
                     (cons x (cons y '())))
                   nil)
                  ((defun first-of (x)
                     (car x))
                   nil)
                  ((defun second-of (x)
                     (car (cdr x)))
                   nil)
                  ((dethm first-of-pair (a b)
                          (equal (first-of (pair a b)) a))
                   nil
                   ((1 1) (pair a b))
                   ((1) (first-of (cons a (cons b '()))))
                   ((1) (car/cons a (cons b '())))
                   (() (equal-same a))))))

;; Prove theorem `second-of-pair` - frame recess:45
(J-Bob/prove (prelude+first-of-pair)
             '(((dethm second-of-pair (a b)
                       (equal (second-of (pair a b)) b))
                nil
                ((1 1) (pair a b))
                ((1) (second-of (cons a (cons b '()))))
                ((1 1) (cdr/cons a (cons b '())))
                ((1) (car/cons b '()))
                (() (equal-same b)))))

;; Prove that `list?` is total - frame recess:53
(J-Bob/prove (prelude)
             '(((defun list? (x)
                  (if (atom x)
                      'nil
                      (list? (cdr x))))
                (size x)
                ((Q) (natp/size x))
                ((A E) (size/cdr x))
                ((A) (if-same (atom x) 't))
                (() (if-true 't 'nil)))))

;; Prove that `memb?` and `remb` are total - frame recess:55
(J-Bob/prove (prelude)
             '(((defun memb? (xs)
                  (if (atom xs)
                      'nil
                      (if (equal (car xs) '?)
                          't
                          (memb? (cdr xs)))))
                (size xs)
                ((Q) (natp/size xs))
                ((A E E) (size/cdr xs))
                ((A E) (if-same (equal (car xs) '?) 't))
                ((A) (if-same (atom xs) 't))
                (() (if-true 't 'nil)))
               ((defun remb (xs)
                  (if (atom xs)
                      '()
                      (if (equal (car xs) '?)
                          (remb (cdr xs))
                          (cons (car xs) (remb (cdr xs))))))
                (size xs)
                ((Q) (natp/size xs))
                ((A E) (size/cdr xs))
                ((A) (if-same (atom xs) 't))
                (() (if-true 't 'nil)))))
