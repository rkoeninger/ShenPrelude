\\ TODO: broken?

(define queue
  doc "Creates a new mutable queue."
  -> (@v queue 0 [] [] <>))

(define queue?
  doc "Returns true if argument is a mutable queue."
  X -> (trap-error (= queue (<-vector X 1)) (/. _ false)))

(define queue-size
  doc "Returns size of mutable queue."
  Queue -> (<-vector Queue 2))

(define queue-push
  doc "Pushes a value onto mutable queue, returns queue."
  Queue Value ->
    (do
      (vector-update Queue 2 (+ 1))
      (vector-update Queue 3 (cons Value))
      Queue))

(define queue-pop
  doc "Pops value off of mutable queue, raises error if empty."
  Queue ->
    (let Size     (<-vector Queue 2)
         Incoming (<-vector Queue 3)
         Outgoing (<-vector Queue 4)
      (if (> Size 0)
        (do
          (vector-update Queue 2 #'decrement)
          (if (empty? Outgoing)
            (let Outgoing (reverse Incoming)
                 Incoming []
              (do
                (vector-> Queue 3 Incoming)
                (vector-> Queue 4 (tl Outgoing))
                (hd Outgoing)))
            (do
              (vector-update Queue 3 #'tl)
              (hd Outgoing))))
        (error "mutable queue is empty"))))

(declare queue [--> [queue A]])
(declare queue? [A --> boolean])
(declare queue-size [[queue A] --> number])
(declare queue-push [[queue A] --> [A --> [queue A]]])
(declare queue-pop [[queue A] --> A])
