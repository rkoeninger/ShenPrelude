\\ TODO: how to make this work?

\\(define function?
\\  doc "Returns true if argument is a function."
\\  {A --> boolean}
\\  F -> (posint? (arity F)))

(define curry
  doc "Converts function that takes tuple to function that takes arguments individually."
  {((A * B) --> C) --> A --> B --> C}
  F -> (/. X Y (F (@p X Y))))

(define uncurry
  doc "Converts function that takes arguments individually to function that takes tuple."
  {(A --> B --> C) --> (A * B) --> C}
  F -> (/. P (F (fst P) (snd P))))
