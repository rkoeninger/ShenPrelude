(match (K1 K2 K3)
  PA1 PA2 PA3 -> BA where (GA)
  PB1 PB2 PB3 -> BB where (GB)
  PC1 PC2 PC3 -> BC where (GC))



(define match4356
  PA1 PA2 PA3 -> BA where (GA)
  PB1 PB2 PB3 -> BB where (GB)
  PC1 PC2 PC3 -> BC where (GC))

(match4356 K1 K2 K3)



\\ TODO: doesn't capture scope
(defmacro match-macro
  [match Keys | More] ->
    (let GenName (gensym match)
      (do
        (eval [define GenName | More])
        (if (shen.list? Keys)
          [GenName | Keys]
          [GenName Keys]))))

(define len Xs N ->
  (match (Xs N)
    []      M -> M
    [_ | Y] M -> (len Y (+ 1 M))))
