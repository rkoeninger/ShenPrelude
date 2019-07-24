(define join-strings
  doc "Concatenates a list of strings interspersing a separator string."
  {string --> (list string) --> string}
  Sep []       -> ""
  Sep [S]      -> S
  Sep [S | Ss] -> (cn (cn S Sep) (join-strings Sep Ss)))

(define signum
  doc "Returns -1 for negative number, 1 for positive, 0 for 0."
  {number --> number}
  X -> -1 where (< X 0)
  X ->  1 where (> X 0)
  _ ->  0)

(define string-compare
  doc "Returns -1 if first string comes first, 1 if it comes later, 0 if they are equal."
  {string --> string --> number}
  "" "" -> 0
  "" _  -> -1
  _  "" -> 1
  (@s S U) (@s S V) -> (string-compare U V)
  (@s S U) (@s T V) -> (signum (- (string->n S) (string->n T))))

(define prefix?
  doc "Checks if second argument starts with the first."
  {string --> string --> boolean}
  P S -> (internal.pre? P S))

(define suffix?
  doc "Checks if second argument ends with the first."
  {string --> string --> boolean}
  S S -> true
  S "" -> false
  S (@s _ Ss) -> (suffix? S Ss))

(define substring-from
  doc "Extracts substring from starting 0-based index."
  {number --> string --> string}
  I S -> (internal.subs I S))

(define substring-to
  doc "Extracts substring up to 0-based index."
  {number --> string --> string}
  _ "" -> ""
  I _ -> "" where (<= I 0)
  I (@s S Ss) -> (@s S (substring-to (- I 1) Ss)))

(define substring
  doc "Extracts between starting and ending 0-based indicies."
  {number --> number --> string --> string}
  I J S -> (substring-to (- J I) (substring-from I S)))

(define string-length-onto
  doc "Adds string length onto given amount and returns."
  {number --> string --> number}
  N "" -> N
  N (@s _ S) -> (string-length-onto (+ 1 N) S))

(define string-length
  doc "Returns length of string."
  {string --> number}
  S -> (string-length-onto 0 S))

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
