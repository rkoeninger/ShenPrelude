(define not=
  doc "Equivalent to (not (= X Y))."
  {A --> (A --> boolean)}
  X Y -> (not (= X Y)))

(define not==
  doc "Equivalent to (not (== X Y))."
  {A --> (B --> boolean)}
  X Y -> (not (== X Y)))

(define fail?
  doc "Returns true if argument is the fail symbol."
  {A --> boolean}
  X -> (== X shen.fail!))

(define skip?
  doc "Returns true if argument is the skip symbol."
  {A --> boolean}
  X -> (== X shen.skip))
