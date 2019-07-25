(define some
  doc "Maybe something."
  X -> (@p true X))

(define none
  doc "Maybe nothing."
  -> (@p false []))

(define some?
  doc "Maybe something?"
  M -> (fst M))

(define none?
  doc "Maybe nothing?"
  M -> (not (fst M)))

(define unwrap
  doc "Get the something. Error if nothing."
  M -> (snd M) where (some? M)
  _ -> (error "Can't unwrap nothing."))

(define maybe-map
  doc "Apply function if something."
  F M -> (some (F (unwrap M))) where (some? M)
  _ _ -> (none))

(define or-else
  doc "Get the something or default value."
  _ M -> (snd M) where (some? M)
  X _ -> X)

(declare some [A --> [maybe A]])
(declare none [--> [maybe A]])
(declare some? [A --> boolean])
(declare none? [A --> boolean])
(declare unwrap [[maybe A] --> A])
(declare maybe-map [[A --> B] --> [[maybe A] --> [maybe B]]])
(declare or-else [A --> [[maybe A] --> A]])
