(set *loaded* [])

(define reload
  Name -> (load (@s (str Name) ".shen")))

(define reload-typed
  Name ->
    (let Tc (value shen.*tc*)
         _  (tc +)
         Result
          (trap-error
            (reload Name)
            (/. E
              (do
                (tc (if Tc + -))
                (simple-error (error-to-string E)))))
         _ (tc (if Tc + -))
      Result))

(define require-mode
  F Name ->
    (if (element? Name (value *loaded*))
      cached
      (let Result (F Name)
        (do
          (set *loaded* [Name | (value *loaded*)])
          Result))))

(define require
  Name -> (require-mode (function reload) Name))

(define require-typed
  Name -> (require-mode (function reload-typed) Name))

(declare reload [symbol --> symbol])
(declare reload-typed [symbol --> symbol])
(declare require-mode [[symbol --> symbol] --> [symbol --> symbol]])
(declare require [symbol --> symbol])
(declare require-typed [symbol --> symbol])
