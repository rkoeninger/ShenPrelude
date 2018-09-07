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
  I (@s _ S) -> (substring-from (- I 1) S))

(define substring-to
  doc "Extracts substring up to 0-based index."
  {number --> string --> string}
  0 _ -> ""
  I (@s S Ss) -> (@s S (substring-to (- I 1) Ss)))

(define substring
  doc "Extracts between starting and ending 0-based indicies."
  {number --> number --> string --> string}
  I J S -> (substring-to (- J I) (substring-from I S)))

(define string-length
  doc "Returns length of string."
  {string --> number}
  "" -> 0
  (@s _ S) -> (+ 1 (string-length S)))

(define lower-case-1
  doc "Returns lower-case of given unit string."
  {string --> string}
  S -> (let N (string->n S) (n->string (+ N (if (and (>= N 65) (<= N 90)) 32 0)))))

(define upper-case-1
  doc "Returns upper-case of given unit string."
  {string --> string}
  S -> (let N (string->n S) (n->string (- N (if (and (>= N 97) (<= N 122)) 32 0)))))

(define lower-case
  doc "Returns copy of string with all characters converted to lower-case."
  {string --> string}
  "" -> ""
  (@s S Ss) -> (@s (lower-case-1 S) (lower-case Ss)))

(define upper-case
  doc "Returns copy of string with all characters converted to upper-case."
  {string --> string}
  "" -> ""
  (@s S Ss) -> (@s (upper-case-1 S) (upper-case Ss)))
