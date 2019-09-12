\\ TODO: replace with (ref _) containing a list

(define queue
  doc "Creates a new queue."
  -> (@v queue 0 [] [] <>))

(define queue?
  doc "Returns true if argument is a queue."
  X -> (trap-error (= queue (<-vector X 1)) (/. _ false)))

(define queue-empty?
  doc "Returns true if given queue is empty."
  Queue -> (= (<-vector Queue 2) 0))

(define queue-size
  doc "Returns size of queue."
  Queue -> (<-vector Queue 2))

(define queue-push
  doc "Pushes a value onto queue, returns queue."
  Queue Value ->
    (do
      (vector-update Queue 2 (+ 1))
      (vector-update Queue 3 (cons Value))
      Queue))

(define queue-peek
  doc "Returns the head value of mutable queue, raises error if empty."
  Queue ->
    (do
      (when (queue-empty? Queue)
        (error "mutable queue is empty"))
      (when (= [] (<-vector Queue 4))
        (do
          (vector-> Queue 4 (reverse (<-vector Queue 3)))
          (vector-> Queue 3 [])))
      (hd (<-vector Queue 4))))

(define queue-pop
  doc "Pops value off of mutable queue, raises error if empty."
  Queue ->
    (let Value (queue-peek Queue)
      (do
        (vector-update Queue 2 #'decrement)
        (vector-update Queue 4 #'tl)
        Value)))

(declare queue [--> [queue A]])
(declare queue? [A --> boolean])
(declare queue-empty? [[queue A] --> boolean])
(declare queue-size [[queue A] --> number])
(declare queue-push [[queue A] --> [A --> [queue A]]])
(declare queue-peek [[queue A] --> A])
(declare queue-pop [[queue A] --> A])
