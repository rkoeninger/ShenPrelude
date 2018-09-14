(define *seed*
  doc "Current random seed."
  {number}
  (shen.mod (get-time unix) (* 32768 32768)))

(define next-random
  doc "Returns the next random value based on the current value of *seed*."
  {--> number}
  ->
  (let Next (shen.mod (* 5137 (+ &'*seed* 10101)) (* 32768 32768))
    (do
      (set *seed* Next)
      Next)))

(define next-random-between
  doc "Returns the next random value within the given range."
  {number --> number --> number}
  I I -> I
  I J -> (+ I (shen.mod (next-random) (+ 1 (- J I)))))

(define vector-swap
  doc "Swaps two elements in given vector at following indicies."
  {(vector A) --> number --> number --> (vector A)}
  V I J ->
    (let X (<-vector V I)
      (do
        (vector-> V I (<-vector V J))
        (vector-> V J X)
        V)))

(define shuffle-vector
  doc "Randomizes elements in vector in place."
  {(vector A) --> (vector A)}
  V ->
    (do
      (shen.for-each
        (/. I (vector-swap V I (next-random-between I (limit V))))
        (range (limit V)))
      V))

(define shuffle-list
  doc "Randomizes elements in cons list, returning a new list."
  {(list A) --> (list A)}
  Xs -> (vector->list (shuffle-vector (list->vector Xs))))
