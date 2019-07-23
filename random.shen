(set *seed* (shen.mod (get-time unix) (* 32768 32768)))

(define next-random
  doc "Returns the next random value based on the current value of *seed*."
  ->
  (let Next (shen.mod (* 5137 (+ &'*seed* 10101)) (* 32768 32768))
    (do
      (set *seed* Next)
      Next)))

(define next-random-between
  doc "Returns the next random value within the given range."
  I I -> I
  I J -> (+ I (shen.mod (next-random) (+ 1 (- J I)))))

(define vector-swap
  doc "Swaps two elements in given vector at following indicies."
  V I J ->
    (let X (<-vector V I)
      (do
        (vector-> V I (<-vector V J))
        (vector-> V J X)
        V)))

(define shuffle-vector
  doc "Randomizes elements in vector in place."
  V ->
    (do
      (shen.for-each
        (/. I (vector-swap V I (next-random-between I (limit V))))
        (range (limit V)))
      V))

(define shuffle-list
  doc "Randomizes elements in cons list, returning a new list."
  Xs -> (vector->list (shuffle-vector (list->vector Xs))))

(declare next-random [--> number])
(declare next-random-between [number --> number --> number])
(declare vector-swap [[vector A] --> number --> number --> [vector A]])
(declare shuffle-vector [[vector A] --> [vector A]])
(declare shuffle-list [[list A] --> [list A]])
