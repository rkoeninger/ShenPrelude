(defmacro ???-macro
  ??? -> [error "not implemented"])

(defmacro function-syntax-macro
  S -> [function (intern (internal.subs 2 (str S)))] where (internal.sympre? "#'" S))

(defmacro value-syntax-macro
  S -> [value (intern (internal.subs 2 (str S)))] where (internal.sympre? "&'" S))

(defmacro protect-syntax-macro
  S -> [protect (intern (internal.subs 2 (str S)))] where (internal.sympre? "~'" S))

(defmacro intern-syntax-macro
  S -> [intern (internal.subs 2 (str S))] where (internal.sympre? "@'" S))

(defmacro thru-macro
  [thru] -> []
  [thru X] -> X
  [thru X F | Fs] -> [thru (append F [X]) | Fs] where (cons? F)
  [thru X F | Fs] -> [thru [F X] | Fs])

(define internal.label
  [: X T] -> [X : T ;]
  X -> [X ;])

(define internal.sequent
  [if [and | Ps] Q] -> (append (mapcan (function internal.label) Ps) [__] (label Q))
  [if [or  | Ps] Q] -> (mapcan (/. P (internal.sequent [if P Q])) Ps)
  [if P [and | Qs]] -> (mapcan (/. Q (internal.sequent [if P Q])) Qs)
  [if P [or  | Qs]] -> (append (internal.label P) [__] (mapcan (function internal.label) Qs))
  [if P Q] -> (append (internal.label P) [__] (internal.label Q))
  Q -> (append [__] (internal.label Q)))

(defmacro deftype-macro
  [deftype Name | Rules] ->
    [datatype (intern (@s (str Name) "-type")) | (mapcan (function internal.sequent) Rules)])

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
