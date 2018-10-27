(define aritycheck
  Name Arity [[Patts Action]] ->
    (do (aritycheck-action Action)
        (aritycheck-name Name Arity (length Patts)))
  Name Arity [[Patts1 Action1] [Patts2 Action2] | Rules] ->
    (if (= (length Patts1) (length Patts2))
        (do (aritycheck-action Action1)
            (aritycheck Name [[Patts2 Action2] | Rules]))
        (error "arity error in ~A~%" Name)))



(define pattern-counts
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

(define max X Y -> X where (>= X Y) _ Y -> Y)

(define vector->list V -> (vector->list-h V [] (limit V)))

(define vector->list-h
  V L 1 -> [(<-vector V 1) | L]
  V L Index -> (vector->list-h V [(<-vector V Index) | L] (- Index 1)))

\\ (fold-left (function max) (fail) (vector->list (pattern-counts [])))
