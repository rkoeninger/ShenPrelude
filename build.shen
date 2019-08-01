(define flatten-type
  [X --> [Y --> Z]] -> [(flatten-type X) --> | (flatten-type [Y --> Z])]
  [X --> Y] -> [(flatten-type X) --> Y]
  X -> X)

(define format-type-sub
  -->      -> "→"
  shen.==> -> "⇨"
  Type     -> (make-string "(~A)" (join-strings " " (map #'format-type-sub Type))) where (cons? Type)
  Type     -> (str Type))

(define format-type
  Type -> (join-strings " " (map #'format-type-sub Type)) where (cons? Type)
  Type -> (str Type))

(define format-entry
  Name Doc Type ->
    (let Heading (@s "### `" (str Name) "`")
         Heading (if (fail? Type) Heading (@s Heading " : `" (format-type (flatten-type Type)) "`"))
      [Heading Doc]))

(do
  (->>
    &'*doc-index*
    (sort-list (/. X Y (>= 0 (string-compare (str (fst X)) (str (fst Y))))))
    (flat-map (/. D (format-entry (fst D) (snd D) (type-of (fst D)))))
    (cons "# Shen Prelude API Docs")
    (join-strings "c#13;c#10;c#13;c#10;")
    (write-to-file "api.md"))
  docs-written)
