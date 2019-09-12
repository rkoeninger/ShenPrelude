\\ Based on Clojure multi-methods (https://clojure.org/reference/multimethods)

(define multi.dispatch
  Name [Arg | Args] ->
    (let Dict (get Name methods)
         Kind (kind-of Arg)
         Body (trap-error
                (shen.<-dict Dict Kind)
                (/. _ (error "no matching implementation for kind ~A in multi ~A" Kind Name)))
      (apply Body [Arg | Args])))

(define multi.arity
  [_ --> X] -> (+ 1 (multi.arity X))
  [_ --> | X] -> (+ 1 (multi.arity X))
  _ -> 0)

(define defmulti
  doc "Declares a new multi-method with given type."
  Name Type ->
    (let Args (map (/. _ (gensym ~'Arg)) (range (multi.arity Type)))
      (do
        (put Name methods (shen.dict 16))
        (eval (append [define Name | Args] [-> [multi.dispatch Name (internal.rcons Args)]]))
        (declare Name Type)
        Name)))

(define defmethod
  doc "Adds implementation for multi-method for kind."
  Name Kind Body ->
    (do
      (shen.dict-> (get Name methods) Kind Body)
      Name))

(defmacro defmulti-macro
  [defmulti Name doc Doc | More] ->
    [do
      [set-doc Name Doc]
      [defmulti Name | More]]
  [defmulti Name] ->
    [defmulti Name [[protect (gensym A)] --> [protect (gensym B)]]]
  [defmulti Name { | More] ->
    (if (= } (last More))
      [defmulti Name (internal.rcons (but-last More))]
      (error "invalid type signature in (defmulti ~A ...)" Name)))

(declare defmulti [symbol --> [T --> symbol]])
(declare defmethod [symbol --> [symbol --> [[A --> B] --> symbol]]])
