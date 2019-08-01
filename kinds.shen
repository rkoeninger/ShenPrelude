(defgeneric kind-of
  doc "Returns a symbol identifying the type family of given value."
  {A --> symbol})

(define defkind
  doc "Defines a specific implementation of `kind-of` with the given predicate and symbol."
  {(A --> boolean) --> symbol --> symbol}
  Pred Kind -> (defspecific kind-of Pred (const Kind)))
