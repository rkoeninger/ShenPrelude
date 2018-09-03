(set *seed* (shen.mod (get-time unix) (* 32768 32768)))

(define next-random ->
  (let Seed (value *seed*)
       Next (shen.mod (* 5137 (+ Seed 10101)) (* 32768 32768))
    (do
      (set *seed* Next)
      Next)))

(define next-random-between
  I I -> I
  I J -> (+ I (shen.mod (next-random) (+ 1 (- J I)))))

(define vector-swap
  V I J ->
    (let X (<-vector V I)
      (do
        (vector-> V I (<-vector V J))
        (vector-> V J X)
        V)))

(define shuffle-vector
  V ->
    (do
      (for-each
        (/. I (vector-swap V I (next-random-between I (limit V))))
        (range (limit V)))
      V))

(define shuffle-list
  Xs -> (vector->list (shuffle-vector (list->vector Xs))))
