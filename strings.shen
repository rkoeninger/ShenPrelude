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

(define string-compare
  doc "Returns -1 if first string comes first, 1 if it comes later, 0 if they are equal."
  {string --> string --> number}
  "" "" -> 0
  "" _  -> -1
  _  "" -> 1
  (@s S U) (@s S V) -> (string-compare U V)
  (@s S U) (@s T V) -> (signum (- (string->n S) (string->n T))))

(define index-of-plus
  {number --> string --> string --> number}
  _ _ "" -> -1
  I S T  -> I where (prefix? S T)
  I S T  -> (index-of-plus (+ 1 I) S (tlstr T)))

(define index-of
  doc "Finds 0-based index of first occurrence of substring in string, -1 if not found."
  {string --> string --> number}
  S T -> (index-of-plus 0 S T))

(define split-string-recur
  {boolean --> string --> string --> (list string)}
  AfterSep Sep S ->
    (if (and (not AfterSep) (= "" S))
      []
      (let Index (index-of Sep S)
        (if (< Index 0)
          [S]
          (let PostIndex (+ Index (string-length Sep))
               Rest (substring-from PostIndex S)
            [(substring-to Index S) | (split-string-recur true Sep Rest)])))))

(define split-string
  doc "Splits a string into a list of substrings on separator. Retains empty strings."
  {string --> string --> (list string)}
  Sep S -> (split-string-recur false Sep S))

(define split-lines
  doc "Splits a string into a list of lines, consider LF and CRLF line endings."
  {symbol --> string --> (list string)}
  lf   S -> (split-string "c#10;" S)
  crlf S -> (split-string "c#13;c#10;" S)
  _    _ -> (error "split-lines expects either 'lf or 'crlf as the first argument."))

(define join-strings
  doc "Concatenates a list of strings interspersing a separator."
  {string --> (list string) --> string}
  Sep []       -> ""
  Sep [S]      -> S
  Sep [S | Ss] -> (cn (cn S Sep) (join-strings Sep Ss)))

(define join-lines
  doc "Joins lines with either `lf` or `crlf` endings."
  {symbol --> (list string) --> string}
  lf   Ss -> (join-strings "c#10;" Ss)
  crlf Ss -> (join-strings "c#13;c#10;" Ss)
  _    _  -> (error "join-lines expects either 'lf or 'crlf as the first argument."))

(define contains-substring?
  doc "Returns true if substring is contained by string."
  {string --> string --> boolean}
  S T -> (>= (index-of S T) 0))

(define whitespace?
  doc "Returns true if string is all whitespace."
  {string --> boolean}
  "" -> true
  (@s Ch S) -> (and (<= (string->n Ch) 32) (whitespace? S)))

(define trim-start
  doc "Removes whitespace characters from beginning of string."
  {string --> string}
  "" -> ""
  (@s Ch S) -> (trim-start S) where (whitespace? Ch)
  S -> S)

(define trim-end
  doc "Removes whitespace characters from end of string."
  {string --> string}
  S -> (reverse-string (trim-start (reverse-string S))))

(define trim
  doc "Removes whitespace characters from beginning and end of string."
  {string --> string}
  S -> (trim-end (trim-start S)))

(define spaces
  doc "Returns a string of `N` spaces"
  {number --> string}
  0 -> ""
  N -> (@s " " (spaces (- N 1))))
