(push #p"./" asdf:*central-registry*)
(ql:quickload 'cl-glpk)

(in-package :cl-glpk)

(defun test1 ()
  (let ((lp (compute-linear-program
              :maximize '(+ (* 1 x))
              :subject-to '((<= (+ (* 1 x)) 5))
              :bounds '((>= x 1)))))
    (glp_simplex lp :output-level :none)))