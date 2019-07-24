(define int?
  doc "Checks if number is an integer."
  X -> (integer? X))

(define mod
  doc "Performs modulus operation."
  X Y -> (shen.mod X Y))

(declare int? [number --> boolean])
(declare mod [number --> [number --> number]])
