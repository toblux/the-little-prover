(load "axioms.scm")

;;; The Little Prover
;;; Chapter 5 - Think It Over and Over and Over

(defun prelude+memb?+remb ()
  (J-Bob/define (prelude)
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
                   (() (if-true 't 'nil))))))

;; frame 5:9
(J-Bob/prove (prelude+memb?+remb)
             '(((dethm memb?/remb0 ()
                       (equal (memb? (remb '())) 'nil))
                nil
                ((1 1) (remb '()))
                ((1 1 Q) (atom '()))
                ((1 1) (if-true '()
                                (if (equal (car '()) '?)
                                    (remb (cdr '()))
                                    (cons (car '()) (remb (cdr '()))))))
                ((1) (memb? '()))
                ((1 Q) (atom '()))
                ((1) (if-true 'nil
                              (if (equal (car '()) '?)
                                  't
                                  (memb? (cdr '())))))
                (() (equal-same 'nil)))))
