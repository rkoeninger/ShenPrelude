\\ TODO: replace with (ref _) containing a list

(define stack
  doc "Creates a new mutable stack."
  -> (@v stack 0 [] <>))

(define stack?
  doc "Returns true if argument is a mutable stack."
  X -> (trap-error (= stack (<-vector X 1)) (/. _ false)))

(define stack-empty?
  doc "Returns true if given stack is empty."
  Stack -> (= (<-vector Stack 2) 0))

(define stack-size
  doc "Returns size of mutable stack."
  Stack -> (<-vector Stack 2))

(define stack-push
  doc "Pushes a value onto mutable stack, returns stack."
  Stack Value ->
    (do
      (vector-update Stack 2 (+ 1))
      (vector-update Stack 3 (cons Value))
      Stack))

(define stack-peek
  doc "Returns the top value of mutable stack, raises error if empty."
  Stack ->
    (if (stack-empty? Stack)
      (error "mutable stack is empty")
      (hd (<-vector Stack 3))))

(define stack-pop
  doc "Pops value off of mutable stack, raises error if empty."
  Stack ->
    (let Value (stack-peek Stack)
      (do
        (vector-update Stack 2 #'decrement)
        (vector-update Stack 3 #'tl)
        Value)))

(declare stack [--> [stack A]])
(declare stack? [A --> boolean])
(declare stack-empty? [[stack A] --> boolean])
(declare stack-size [[stack A] --> number])
(declare stack-push [[stack A] --> [A --> [stack A]]])
(declare stack-peek [[stack A] --> A])
(declare stack-pop [[stack A] --> A])

(defmacro stack-macro
  [stack | Xs] ->
    (fold-right (/. X S [stack-push S X]) [stack] Xs)
  where (cons? Xs))
