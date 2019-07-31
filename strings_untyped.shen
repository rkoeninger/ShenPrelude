(define reverse-string
  doc "Returns string with same characters in reverse order."
  S -> (reverse S))

(define string->bytes
  doc "Converts a string to a list of code points."
  S -> (shen.string->bytes S))

(declare reverse-string [string --> string])
(declare string->bytes [string --> [list number]])
