(define internal.pre?
  "" _ -> true
  (@s Ch Ss) (@s Ch Ts) -> (internal.pre? Ss Ts)
  _ _ -> false)

(define internal.sympre?
  P S -> (and (symbol? S) (internal.pre? P (str S))))

(define internal.subs?
  _ "" -> false
  S T -> true where (internal.pre? S T)
  S (@s _ T) -> (internal.subs? S T))

(define internal.subs
  _ "" -> ""
  I S -> S where (<= I 0)
  I (@s _ S) -> (internal.subs (- I 1) S))

(define internal.dset
  S E -> (do (set S (eval E)) true))

(define internal.un-rcons
  [cons X Y] -> [(internal.un-rcons X) | (internal.un-rcons Y)]
  X -> X)

(declare internal.pre? [string --> [string --> boolean]])
(declare internal.sympre? [string --> [symbol --> boolean]])
(declare internal.subs? [string --> [string --> boolean]])
(declare internal.subs [number --> [string --> string]])
(declare internal.dset [symbol --> [A --> boolean]])
