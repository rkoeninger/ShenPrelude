(set *loaded* [])

(define with-tc
  Tc F ->
    (let Prev (if (value shen.*tc*) + -)
      (if (= Tc Prev)
        (thaw F)
        (do
          (tc Tc)
          (trap-error
            (thaw F)
            (/. E
              (do
                (tc Prev)
                (simple-error (error-to-string E)))))
          (tc Prev)))))

(define reload
  Name -> (load (@s (str Name) ".shen")))

(define reload-typed
  Name -> (with-tc + (freeze (reload Name))))

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

(declare with-tc [symbol --> [[--> A] --> A]])
(declare reload [symbol --> symbol])
(declare reload-typed [symbol --> symbol])
(declare require-mode [[symbol --> symbol] --> [symbol --> symbol]])
(declare require [symbol --> symbol])
(declare require-typed [symbol --> symbol])
