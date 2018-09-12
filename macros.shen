(defmacro when-macro
  [when Cond IfTrue] -> [if Cond IfTrue []])

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

\\ TODO: emit the calls to set-doc instead of running them in macro

(defmacro define-doc-macro
  [define Name doc Doc | Rest] ->
    (do
      (set-doc Name Doc)
      [define Name | Rest]))

(defmacro define-global-macro
  [define Name doc Doc { Type } Value] ->
    [do
      [set Name Value]
      [set-doc Name Doc]
      (let TypeName (symbol (make-string "~S-global" (str Name)))
        [datatype TypeName
                                     __ [value Name] : Type;
          (protect SetValue) : Type; __ [set Name (protect SetValue)] : Type;])])
