(define map-fst
  {(A --> C) --> (A * B) --> (C * B)}
  F (@p X Y) -> (@p (F X) Y))

(define map-snd
  {(B --> C) --> (A * B) --> (A * C)}
  F (@p X Y) -> (@p X (F Y)))

(define map-both
  {(A --> B) --> (A * A) --> (B * B)}
  F (@p X Y) -> (@p (F X) (F Y)))
