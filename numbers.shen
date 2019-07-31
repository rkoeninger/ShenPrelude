(define pos?
  doc "Determines if number is positive."
  {number --> boolean}
  X -> (> X 0))

(define neg?
  doc "Determines if number is negative."
  {number --> boolean}
  X -> (< X 0))

(define signum
  doc "Returns -1 for negative number, 1 for positive, 0 for 0."
  {number --> number}
  X -> -1 where (< X 0)
  X ->  1 where (> X 0)
  _ ->  0)

(define abs
  doc "Returns the absolute value of given number."
  {number --> number}
  X -> (* X (signum X)))

(define neg
  doc "Returns negation of given number."
  {number --> number}
  X -> (* -1 X))

(define ceil {number --> number} X -> X)

(define floor
  doc "Rounds down to nearest integer."
  {number --> number}
  X -> X where (int? X)
  X -> (neg (ceil (neg X))) where (neg? X)
  X -> (- X (mod X 1)))

(define ceil
  doc "Rounds up to nearest integer."
  {number --> number}
  X -> X where (int? X)
  X -> (neg (floor (neg X))) where (neg? X)
  X -> (+ 1 (- X (mod X 1))))
