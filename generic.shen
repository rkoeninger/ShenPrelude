(define defgeneric
  {symbol --> unit --> symbol}
  Name Type ->
    (do
      () \\ create dispatch list in global
      (elim-def [define Name ~'Arg -> [call-generic Name ~'Arg]])
      (declare Name Type)
      Name))

(define defspecific
  {symbol --> (A --> boolean) --> (A --> B) --> symbol}
  Name Pred Body ->
    (do
      () \\ prepend to dispatch list
      Name))

(define call-generic
  {symbol --> A --> B}
  Name Arg ->
    []) \\ lookup dispatch list, pick one, run it

(defmacro defgeneric-macro
  [defgeneric Name { | More] -> [defgeneric Name (take-while (not= }) Xs)])
