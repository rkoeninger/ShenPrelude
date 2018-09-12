(package internal []

  (define pre?
    "" _ -> true
    (@s Ch Ss) (@s Ch Ts) -> (pre? Ss Ts)
    _ _ -> false)

  (define sympre?
    P S -> (and (symbol? S) (pre? P (str S))))

  (define subs?
    _ "" -> false
    S T -> true where (pre? S T)
    S (@s _ T) -> (subs? S T))

  (define subs
    _ "" -> ""
    I S -> S where (<= I 0)
    I (@s _ S) -> (subs (- I 1) S))

  (declare pre? [string --> [string --> boolean]])
  (declare sympre? [string --> [symbol --> boolean]])
  (declare subs? [string --> [string --> boolean]])
  (declare subs [number --> [string --> string]]))
