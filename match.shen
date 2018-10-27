\*
(match Exprs+ with
  [Patterns+ -> Action [where Cond]?]+)
*\

(define compile-match-bindings
  [] [] Body -> Body
  [V | Vs] [E | Es] Body -> [let V E (compile-match-bindings Vs Es Body)])

(define all?
  _ [] -> true
  F [X | Xs] -> (and (F X) (all? F Xs)))

\\ TODO: respect *optimise* flag and generate type declarations
\\ TODO: clearer arity error message
(define compile-match
  Exprs Rules ->
    (let ExprCount (length Exprs)
      (if (not (all? (/. Rule (= ExprCount (length (hd Rule)))) Rules))
        (error "arity error in match expression~%")
        (let Vars (shen.parameters ExprCount)
             Apps (map
                    (/. Rule
                      (shen.reduce
                        (shen.application_build Vars
                          (shen.abstract_rule
                            (shen.strip-protect Rule)))))
                    Rules)
             Body (shen.cond-expression match-expression Vars Apps)
          (compile-match-bindings Vars Exprs Body)))))

\\ TODO: we could count off the expressions before the first arrow
\\       and the first half are the keys (and the arity) and
\\       the second half are the first pattern
(defcc <exprs>
  Expr <exprs> := [Expr | <exprs>] where (not (= with Expr));
  Expr := [Expr] where (not (= with Expr));)

(defcc <match>
  match <exprs> with shen.<rules> := (compile-match <exprs> shen.<rules>);)

(defmacro match-macro
  [match | M] -> (compile (function <match>) [match | M]))

(defmacro letm-macro
  [letm Pattern Val Body where Cond] ->
    [match Val with Pattern -> Body where Cond]
  [letm Pattern Val Body] ->
    [match Val with Pattern -> Body])
