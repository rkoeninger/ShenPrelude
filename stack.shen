(define stack
  doc "Creates a new mutable stack."
  -> (@v stack 0 (vector 32)))

(define stack?
  doc "Returns true if argument is a mutable stack."
  X -> (trap-error (= stack (<-vector X 1)) (/. _ false)))

(define stack-size
  doc "Returns size of mutable stack."
  Stack -> (<-vector Stack 2))

(define stack-push
  doc "Pushes a value onto mutable stack, returns stack."
  Stack Value ->
    (let Size     (<-vector Stack 2)
         Vector   (<-vector Stack 3)
         Capacity (limit Vector)
      (if (= Size Capacity)
        (let NewVector (shen.resize-vector Vector (* 2 Capacity) (fail))
          (do
            (vector-> NewVector (+ 1 Size) Value)
            (vector-> Stack 2 (+ 1 Size))
            (vector-> Stack 3 NewVector)
            Stack))
        (do
          (vector-> Vector (+ 1 Size) Value)
          (vector-> Stack 2 (+ 1 Size))
          Stack))))

(define stack-pop
  doc "Pops value off of mutable stack, raises error if empty."
  Stack ->
    (let Size   (<-vector Stack 2)
         Vector (<-vector Stack 3)
      (if (> Size 0)
        (let Value (<-vector Vector Size)
          (do
            (vector-> Vector Size (fail))
            (vector-> Stack 2 (- Size 1))
            Value))
        (error "mutable stack is empty"))))

(declare stack [--> [stack A]])
(declare stack? [A --> boolean])
(declare stack-size [[stack A] --> number])
(declare stack-push [[stack A] --> [A --> [stack A]]])
(declare stack-pop [[stack A] --> A])
