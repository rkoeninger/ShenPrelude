(define map-fst
  doc "Uses given function to transform the first value in a 2-tuple."
  {(A --> C) --> (A * B) --> (C * B)}
  F (@p X Y) -> (@p (F X) Y))

(define map-snd
  doc "Uses given function to transform the second value in a 2-tuple."
  {(B --> C) --> (A * B) --> (A * C)}
  F (@p X Y) -> (@p X (F Y)))

(define map-both
  doc "Uses given function to transform both values in a 2-tuple."
  {(A --> B) --> (A * A) --> (B * B)}
  F (@p X Y) -> (@p (F X) (F Y)))
