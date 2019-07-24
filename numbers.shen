(define signum
  doc "Returns -1 for negative number, 1 for positive, 0 for 0."
  {number --> number}
  X -> -1 where (< X 0)
  X ->  1 where (> X 0)
  _ ->  0)

(define floor
  doc "Rounds down to nearest integer (only for positive numbers)."
  {number --> number}
  X -> (if (int? X) X (- X (mod X 1))))

(define ceiling
  doc "Rounds up to nearest integer (only for positive numbers)."
  {number --> number}
  X -> (if (int? X) X (+ 1 (- X (mod X 1)))))
