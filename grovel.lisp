(in-package #:cl-glpk)

(include "glpk.h")

(cstruct glp-smcp "glp_smcp"
  (msg_lev "msg_lev" :type :int))

(constant (glp_msg_off "GLP_MSG_OFF"))
(constant (glp_msg_err "GLP_MSG_ERR"))
(constant (glp_msg_on "GLP_MSG_ON")) ; normal
(constant (glp_msg_all "GLP_MSG_ALL"))
(constant (glp_msg_dbg "GLP_MSG_DBG"))

#|
typedef struct
{     /* simplex method control parameters */
      int msg_lev;            /* message level: */
#define GLP_MSG_OFF        0  /* no output */
#define GLP_MSG_ERR        1  /* warning and error messages only */
#define GLP_MSG_ON         2  /* normal output */
#define GLP_MSG_ALL        3  /* full output */
#define GLP_MSG_DBG        4  /* debug output */
      int meth;               /* simplex method option: */
#define GLP_PRIMAL         1  /* use primal simplex */
#define GLP_DUALP          2  /* use dual; if it fails, use primal */
#define GLP_DUAL           3  /* use dual simplex */
      int pricing;            /* pricing technique: */
#define GLP_PT_STD      0x11  /* standard (Dantzig rule) */
#define GLP_PT_PSE      0x22  /* projected steepest edge */
      int r_test;             /* ratio test technique: */
#define GLP_RT_STD      0x11  /* standard (textbook) */
#define GLP_RT_HAR      0x22  /* two-pass Harris' ratio test */
      double tol_bnd;         /* spx.tol_bnd */
      double tol_dj;          /* spx.tol_dj */
      double tol_piv;         /* spx.tol_piv */
      double obj_ll;          /* spx.obj_ll */
      double obj_ul;          /* spx.obj_ul */
      int it_lim;             /* spx.it_lim */
      int tm_lim;             /* spx.tm_lim (milliseconds) */
      int out_frq;            /* spx.out_frq */
      int out_dly;            /* spx.out_dly (milliseconds) */
      int presolve;           /* enable/disable using LP presolver */
      double foo_bar[36];     /* (reserved) */
} glp_smcp;
|#

#|
(constantenum direction
              ((:minimize "GLP_MIN"))
              ((:maximize "GLP_MAX")))

(constantenum structural-variable-type
              ((:continuous "GLP_CV"))
              ((:integer "GLP_IV"))
              ((:binary "GLP_BV")))

(constantenum variable-bounds-type
              ((:free "GLP_FR"))
              ((:lower "GLP_LO"))
              ((:upper "GLP_UP"))
              ((:double "GLP_DB"))
              ((:fixed "GLP_FX")))

(constantenum variable-status
              ((:basic "GLP_BS"))
              ((:non-basic-on-lower "GLP_NL"))
              ((:non-basic-on-upper "GLP_NU"))
              ((:non-basic-free "GLP_NF"))
              ((:non-basic-fixed "GLP_NS")))

(constantenum scaling-options
              )

(constantenum solution-type
              ((:basic "GLP_SOL"))
              ((:interior-point "GLP_IPT"))
              ((:mixed-integer "GLP_MIP")))

(constantenum solution-status
              ((:undefined "GLP_UNDEF"))
              ((:feasible "GLP_FEAS"))
              ((:infeasible "GLP_INFEAS"))
              ((:optimal "GLP_OPT"))
              ((:unbounded "GLP_UNBND")))

(cstruct-and-class-item problem "glp_prob"
                        (name "name" :type :string)
                        (objective-function-name "obj" :type :string)
                        (direction "dir" :type direction)
                        (constant-term "c0" :type :double)
                        (max-row-count "m_max" :type :int)
                        (max-column-count "n_max" :type :int)
                        (row-count "m" :type :int)
                        (column-count "n" :type :int)
                        (non-zero-constraint-count "nnz" :type :int)
                        (rows "row" :type :pointer)
                        (columns "col" :type :pointer)
                        ;; basis factorization (LP)
                        ;; basic solution (LP)
                        (primal-basic-solution-status "pbs_stat"))
|#
