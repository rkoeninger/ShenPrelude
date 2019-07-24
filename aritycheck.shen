(define internal.aritycheck
  Name Arity [[Patts Action]] ->
    (do (aritycheck-action Action)
        (aritycheck-name Name Arity (length Patts)))
  Name Arity [[Patts1 Action1] [Patts2 Action2] | Rules] ->
    (if (= (length Patts1) (length Patts2))
        (do (aritycheck-action Action1)
            (aritycheck Name [[Patts2 Action2] | Rules]))
        (error "arity error in ~A~%" Name)))



(define internal.pattern-counts
  [] ->
    (let Counts (vector 8)
      (do
        (shen.fillvector Counts 1 8 0)
        Counts))
  [P | Ps] ->
    (let Counts (pattern-counts Ps)
         Arity  (length P)
      (do
        (vector-> Counts (+ 1 Arity) (+ 1 (<-vector Counts (+ 1 Arity))))
        Counts)))

(define internal.max-of X Y -> X where (>= X Y) _ Y -> Y)

\\ (fold-left (function max-of) (fail) (vector->list (pattern-counts [])))
