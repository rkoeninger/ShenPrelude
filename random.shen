(set-doc *seed* "The seed from which the next random value is derived.")
(set *seed* (shen.mod (get-time unix) (* 32768 32768)))

(define next-random
  doc "Returns the next random value based on the current value of `*seed*`."
  ->
  (let Next (shen.mod (* 5137 (+ &'*seed* 10101)) (* 32768 32768))
    (do
      (set *seed* Next)
      Next)))

(define next-random-boolean
  doc "Returns the next random boolean based on the current value of `*seed*`."
  -> (= 0 (mod (next-random) 2)))

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

(define vector-update
  doc "Transforms value at index by given function."
  V I F ->
    (do
      (vector-> V I (F (<-vector V I)))
      V))

(define bubble-sort
  doc "Bubble-sorts a slice of a vector."
  F 1 _ V -> V
  F N I V -> (bubble-sort F (- N 1) 1 V) where (= I (limit V))
  F N I V -> (let J (+ 1 I) (bubble-sort F N J (if (F (<-vector V I) (<-vector V J)) V (vector-swap V I J)))))

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

(declare-value *seed* number)
(declare next-random [--> number])
(declare next-random-boolean [--> boolean])
(declare next-random-between [number --> [number --> number]])
(declare vector-swap [[vector A] --> [number --> [number --> [vector A]]]])
(declare vector-update [[vector A] --> [number --> [[A --> A] --> [vector A]]]])
(declare bubble-sort [[A --> [A --> boolean]] --> [number --> [number --> [[vector A] --> [vector A]]]]])
(declare shuffle-vector [[vector A] --> [vector A]])
(declare shuffle-list [[list A] --> [list A]])
