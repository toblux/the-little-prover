(load "axioms.scm")

;;; The Little Prover
;;; Chapter 2 - Even Older Games

;; frame 2:11-28
(J-Bob/step (prelude)
            '(if (if (equal a 't)
                     (if (equal 'nil 'nil) a b)
                     (equal 'or (cons 'black '(coffee))))
                 c
                 c)
            '(((Q E 2) (cons 'black '(coffee)))
              ((Q A Q) (equal-same 'nil))
              ((Q A) (if-true a b))
              ((Q E) (equal 'or '(black coffee)))
              ((Q A) (equal-if a 't))))

;; frame 2:60
(J-Bob/step (prelude)
            '(if (atom (car a))
                 (if (equal (car a) (cdr a))
                     'hominy
                     'grits)
                 (if (equal (cdr (car a)) '(hash browns))
                     (cons 'ketchup (car a))
                     (cons 'mustard (car a))))
            '(((E A 2) (cons/car+cdr (car a)))))
