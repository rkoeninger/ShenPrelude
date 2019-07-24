(define stack
  doc "Creates a new mutable stack."
  ->
    (let Stack (absvector 3)
      (do
        (address-> Stack 0 stack)
        (address-> Stack 1 0)
        (address-> Stack 2 (vector 32)))))

(define stack?
  doc "Returns true if argument is a mutable stack."
  X -> (trap-error (= stack (<-address X 0)) (/. _ false)))

(define stack-size
  doc "Returns size of mutable stack."
  Stack -> (<-address Stack 1))

(define stack-push
  doc "Pushes a value onto mutable stack, returns stack."
  Stack Value ->
    (let Size     (<-address Stack 1)
         Vector   (<-address Stack 2)
         Capacity (limit Vector)
      (if (= Size Capacity)
        (let NewVector (shen.resize-vector Vector (* 2 Capacity) (fail))
          (do
            (vector-> NewVector (+ 1 Size) Value)
            (address-> Stack 1 (+ 1 Size))
            (address-> Stack 2 NewVector)
            Stack))
        (do
          (vector-> Vector (+ 1 Size) Value)
          (address-> Stack 1 (+ 1 Size))
          Stack))))

(define stack-pop
  doc "Pops value off of mutable stack, raises error if empty."
  Stack ->
    (let Size   (<-address Stack 1)
         Vector (<-address Stack 2)
      (if (> Size 0)
        (let Value (<-vector Vector Size)
          (do
            (vector-> Vector Size (fail))
            (address-> Stack 1 (- Size 1))
            Value))
        (error "mutable stack is empty"))))

(declare stack [--> [stack A]])
(declare stack? [A --> boolean])
(declare stack-size [[stack A] --> number])
(declare stack-push [[stack A] --> [A --> [stack A]]])
(declare stack-pop [[stack A] --> A])
