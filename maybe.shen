(define maybe
  doc "Maybe."
  B X ->
    (let Array (absvector 3)
      (do
        (address-> Array 0 maybe)
        (address-> Array 1 B)
        (address-> Array 2 X))))

(define some
  doc "Maybe something."
  X -> (maybe true X))

(define none
  doc "Maybe nothing."
  -> (maybe false []))

(define maybe?
  doc "Maybe?"
  M -> (and (absvector? M) (= maybe (<-address M 0))))

(define some?
  doc "Maybe something?"
  M -> (and (maybe? M) (<-address M 1)))

(define none?
  doc "Maybe nothing?"
  M -> (and (maybe? M) (not (<-address M 1))))

(define unwrap
  doc "Get the something. Error if nothing."
  M -> (<-address M 2) where (some? M)
  _ -> (error "Can't unwrap nothing."))

(define maybe-map
  doc "Apply function if something."
  F M -> (some (F (unwrap M))) where (some? M)
  _ _ -> (none))

(define or-else
  doc "Get the something or default value."
  _ M -> (unwrap M) where (some? M)
  X _ -> X)

(declare maybe [boolean --> [A --> [maybe A]]])
(declare some [A --> [maybe A]])
(declare none [--> [maybe A]])
(declare maybe? [A --> boolean])
(declare some? [A --> boolean])
(declare none? [A --> boolean])
(declare unwrap [[maybe A] --> A])
(declare maybe-map [[A --> B] --> [[maybe A] --> [maybe B]]])
(declare or-else [A --> [[maybe A] --> A]])
