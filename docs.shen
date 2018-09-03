(define get/or
  Object Property F ->
    (trap-error
      (get Object Property)
      (/. _ (thaw F))))

(defmacro define-with-doc-macro
  [define Name doc Doc | Rest] ->
    (do
      (write-doc Name Doc)
      [define Name | Rest]))

(defmacro set-with-doc-macro
  [set Name doc Doc | Rest] ->
    (do
      (write-doc Name Doc)
      [set Name | Rest]))

(define read-doc
  {symbol --> string}
  Name -> (type (get/or Name doc (freeze "n/a")) string))

(define write-doc
  {symbol --> string --> string}
  Name Content -> (put Name doc Content))

(define info
  {symbol --> string}
  Name ->
    (make-string "~%type:   ~A~%doc:    ~A~%source: ~A~%"
      (let TypeSig (shen.get-type Name)
        (if (= shen.skip TypeSig)
          "n/a"
          TypeSig))
      (read-doc Name)
      (get/or Name source (freeze "n/a"))))

(write-doc fst "Returns the first value in a 2-tuple.")
(write-doc snd "Returns the first value in a 2-tuple.")
