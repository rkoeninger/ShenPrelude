(define prefix?
  doc "Checks if second argument starts with the first."
  {string --> string --> boolean}
  "" _ -> true
  (@s Ch Ss) (@s Ch Ts) -> (prefix? Ss Ts)
  _ _ -> false)

(define substring-from
  doc "Extracts substring from starting 0-based index."
  {number --> string --> string}
  0 S -> S
  N (@s _ S) -> (substring-from (- N 1) S))

(define string-length
  doc "Returns length of string."
  {string --> number}
  "" -> 0
  (@s _ S) -> (+ 1 (string-length S)))
