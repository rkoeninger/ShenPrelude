(set *tc-stack* [])

(define push-tc
  Tc ->
    (do
      (set *tc-stack* [Tc | (value *tc-stack*)])
      (tc Tc)
      Tc))

(define pop-tc
  ->
    (let TcStack (value *tc-stack*)
      (if (cons? TcStack)
        (do
          (set *tc-stack* (tl TcStack))
          (tc (hd TcStack))
          (hd TcStack))
        (error "tc stack is empty"))))

(set *loaded* [])

(define loaded?
  Name -> (element? Name (value *loaded*)))

(define reload
  Name -> (load (@s (str Name) ".shen")))

(define reload-typed
  Name ->
    (do
      (push-tc +)
      (trap-error
        (reload Name)
        (/. E
          (do
            (pop-tc)
            (simple-error (error-to-string E)))))
      (pop-tc)))

(define reload-untyped
  Name ->
    (do
      (push-tc -)
      (trap-error
        (reload Name)
        (/. E
          (do
            (pop-tc)
            (simple-error (error-to-string E)))))
      (pop-tc)))

(define require-mode
  F Name ->
    (if (loaded? Name)
      cached
      (let Result (F Name)
        (do
          (set *loaded* [Name | (value *loaded*)])
          Result))))

(define require
  Name -> (require-mode (function reload) Name))

(define require-typed
  Name -> (require-mode (function reload-typed) Name))

(define require-untyped
  Name -> (require-mode (function reload-untyped) Name))

(define set-once
  Name Value -> (if (bound? Name) Value (set Name Value)))

(declare push-tc [symbol --> symbol])
(declare pop-tc [--> symbol])
(declare loaded? [symbol --> boolean])
(declare reload [symbol --> symbol])
(declare reload-typed [symbol --> symbol])
(declare reload-untyped [symbol --> symbol])
(declare require-mode [[symbol --> symbol] --> [symbol --> symbol]])
(declare require [symbol --> symbol])
(declare require-typed [symbol --> symbol])
(declare require-untyped [symbol --> symbol])
(declare set-once [symbol --> [A --> A]])

(defmacro require-macro
  [require* + Name | More] -> [do [require-typed   Name] [require* | More]]
  [require* - Name | More] -> [do [require-untyped Name] [require* | More]]
  [require*]               -> [])
