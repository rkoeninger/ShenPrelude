(define generic.dispatch
  [(@p Pred Body) | _] Arg -> (Body Arg) where (Pred Arg)
  [_ | More]           Arg -> (generic.dispatch More Arg)
  _ _ -> (error "no matching implementation"))

(define defgeneric
  doc "Declares a new generic method with the given type."
  Name Type ->
    (do
      (put Name dispatch-list [])
      (eval [define Name ~'Arg -> [generic.dispatch [get Name dispatch-list] ~'Arg]])
      (declare Name Type)
      Name))

(define defspecific
  doc "Declares a case-specific implementation of a generic method. New implementations supercede old ones."
  Name Pred Body ->
    (do
      (put Name dispatch-list [(@p Pred Body) | (get Name dispatch-list)])
      Name))

(defmacro defgeneric-macro
  [defgeneric Name doc Doc | More] ->
    [do
      [set-doc Name Doc]
      [defgeneric Name | More]]
  [defgeneric Name] ->
    [defgeneric Name (internal.rcons [[protect (gensym A)] --> [protect (gensym B)]])]
  [defgeneric Name { | More] ->
    (if (= } (last More))
      [defgeneric Name (internal.rcons (but-last More))]
      (error "invalid type signature in (defgeneric ~A ...)" Name)))

(declare defgeneric [symbol --> [T --> symbol]])
(declare defspecific [symbol --> [[A --> boolean] --> [[A --> B] --> symbol]]])
