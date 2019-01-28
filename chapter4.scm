(load "axioms.scm")

;;; The Little Prover
;;; Chapter 4 - Part of This Total Breakfast

(defun partial (x)
  (if (partial x)
      'nil
      't))

(defun list? (x)
  (if (atom x)
      (equal x '())
      (list? (cdr x))))

(list? 'nil)
(list? '())
(list? '(1 2 3))

(defun sub (x y)
  (if (atom y)
      (if (equal y '?) x y)
      (cons
       (sub x (car y))
       (sub x (cdr y)))))

(sub '(a ? b) '(x ? y))
