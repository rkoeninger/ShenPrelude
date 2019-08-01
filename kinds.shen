(defgeneric kind-of {A --> symbol})

(defmacro defkind-macro
  [defkind Pred Kind] -> [defspecific kind-of Pred [const Kind]])

(set-doc kind-of "Returns a symbol identifying the type family of given value.")
(set-doc defkind "Defines a specific implementation of `kind-of` with the given predicate and symbol.")
