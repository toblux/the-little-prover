(load "axioms.scm")

;;; The Little Prover
;;; Chapter 1 - Old Games, New Rules

;; frame 1:44
(J-Bob/step (prelude)
            '(car (cons (equal (cons x y) (cons x y))
                        '(and crumpets)))
            '(((1 1) (equal-same (cons x y)))
              (() (car/cons 't '(and crumpets)))))

;; frame 1:54 - doesn't lead anywhere
(J-Bob/step (prelude)
            '(cons y
                   (equal (car (cons (cdr x) (car y)))
                          (equal (atom x) 'nil)))
            '(((2 1) (car/cons (cdr x) (car y)))))
