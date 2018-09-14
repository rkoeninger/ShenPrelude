(defmacro function-syntax-macro
  S -> [function (intern (internal.subs 2 (str S)))] where (internal.sympre? "#'" S))

(defmacro value-syntax-macro
  S -> [value (intern (internal.subs 2 (str S)))] where (internal.sympre? "&'" S))

(defmacro protect-syntax-macro
  S -> [protect (intern (internal.subs 2 (str S)))] where (internal.sympre? "~'" S))

(defmacro thru-macro
  [thru] -> []
  [thru X] -> X
  [thru X F | Fs] -> [thru (append F [X]) | Fs] where (cons? F)
  [thru X F | Fs] -> [thru [F X] | Fs])

(define internal.typeann
  [type E T] -> [[E : T ;]]
  E -> E)

(define internal.condition
  [and | Ps] -> (mapcan (function internal.typeann) Ps)
  [or | Ps] -> (error "Dont' know how to or condition")
  P -> (internal.typeann P))

(define internal.consequent
  [and | Qs] -> (mapcan (function internal.typeann) Qs)
  [or | Qs] -> (error "Don't know how to or consequent")
  Q -> (internal.typeann Q))

(define internal.typerule
  [if Ps Qs] ->
    (mapcan
      (/. Q (mapcan (/. P (append P [__] Q)) Ps))
      (internal.consequent Qs))
  R -> [__ R ;])

(defmacro deftype-macro
  [deftype Name | Rules] ->
    [datatype Name | (mapcan (function internal.typerule) Rules)])

(defmacro define-doc-macro
  [define Name doc Doc | Rest] ->
    [do
      [set-doc Name Doc]
      [define Name | Rest]])

(defmacro define-global-doc-macro
  [define Name doc Doc { Type } Value] ->
    [do
      [set-doc Name Doc]
      [define Name { Type } Value]])

(defmacro define-global-macro
  [define Name { Type } Value] ->
    [do
      [push-tc -]
      [datatype (intern (cn (str Name) "-type"))

        ____________________
        [value Name] : Type;

        (protect V) : Type;
        ____________________
        [set Name (protect V)] : Type;]
      [set Name Value]
      [pop-tc]
      Name])
