# cl-glpk

A Common Lisp library for solving linear programs.

## Portability

CL-GLPK should work on any Lisp/OS/machine combination, as long as CFFI,
Trivial-Garbage, Iterate, and GLPK work.

CL-GLPK has been tested on SBCL 1.0.2 / Mac OS X (10.4) / PPC and CCL trunk /
Mac OS X (10.6) / x86-64.

## Quick Introduction

Load the ASDF system. The low-level FFI bindings are implicitly documented by
the GLPK manual. For the (partial) high-level API, see `examples/sample.lisp`. The highest-level API allows you to express linear programs like:

    (make-linear-program
     :maximize (+ (* 10 x1) (* 6 x2) (* 4 x3))
     :subject-to ((<= (+ x1 x2 x3) 100)
                  (<= (+ (* 4 x2) (* 10 x1) (* 5 x3)) 600)
                  (<= (+ (* 2 x1) (* 2 x2) (* 6 x3)) 300))
     :bounds ((>= x3 10)))

Any of the :BOUNDS constraints could be in the :SUBJECT-TO list instead, but I'm
not yet sure what impact that will have on performance, so until I can identify
(and if necessary, prevent) that, I pull my variable bounds into a separate
parameter.

Then you can solve the program and get results with

    (simplex *)
    (format t "z = ~a, x1 = ~a, x2 = ~a, x3 = ~a~%"
            (objective-value **)
            (column-primal-value ** 1)
            (column-primal-value ** 2)
            (column-primal-value ** 3))

There are still a lot of improvements to build into this high-level API before
it's really complete.

Instead of the macro you can also use the underlying functional interface
`compute-linear-program`.

The created object representing the linear program must be destroyed
subsequently with `destroy-linear-program`. This ensures that all data
structures are correctly deallocated when they are no longer needed,
and not wait till GC time.

One can use the macro `with-linear-program` to handle object creation/destruction:

    (with-linear-program (lp (:maximize (+ (* 10 x1) (* 6 x2) (* 4 x3))
                              :subject-to ((<= (+ x1 x2 x3) 100)
                                           (<= (+ (* 4 x2) (* 10 x1) (* 5 x3)) 600)
                                           (<= (+ (* 2 x1) (* 2 x2) (* 6 x3)) 300))
                              :bounds ((>= x3 10))))
       (simplex lp)
       (format t "z = ~a, x1 = ~a, x2 = ~a, x3 = ~a~%"
            (objective-value **)
            (column-primal-value ** 1)
            (column-primal-value ** 2)
            (column-primal-value ** 3)))

## License

BSD sans advertising clause (see file COPYING)

## TODO List

### Write more examples

### Write some tests

### Improve error handling

Currently error handling is done by either `(ERROR ...)` or `(ASSERT ...)`.

### Extend High Level API

### Make up a DSL (similar to GLPK's MPS files, but lispier)

This is partially completed in `make-linear-program`/`compute-linear-problem`.

### Complete FFI bindings

## Memory management

Linear problem FFI objects are properly freed by way of attaching a
finalizer to their CLOS counterpart. Replacing the constraints of
a linear problem CLOS object will free the memory used by replaced
constraints (`glp_load_matrix` will do this on the C side).

