(load "prelude.shen")

(define flatten-type
  [X --> [Y --> Z]] -> [(flatten-type X) --> | (flatten-type [Y --> Z])]
  [X --> Y] -> [(flatten-type X) --> Y]
  X -> X)

(define format-type-sub
  -->      -> "→"
  shen.==> -> "⇨"
  Type     -> (cn "(" (cn (join-strings " " (map (function format-type-sub) Type)) ")")) where (cons? Type)
  Type     -> (str Type))

(define format-type
  Type -> (join-strings " " (map (function format-type-sub) Type)) where (cons? Type)
  Type -> (str Type))

(define format-entry
  Name Doc Type ->
    (let Heading (@s "### `" (str Name) "`")
         Heading (if (fail? Type) Heading (@s Heading " : `" (format-type (flatten-type Type)) "`"))
      [Heading Doc]))

(let NameDocs (sort-list (/. X Y (>= 0 (string-compare (str (fst X)) (str (fst Y))))) (value *doc-index*))
     Entries  (flat-map (/. D (format-entry (fst D) (snd D) (type-of (fst D)))) NameDocs)
     Markdown (join-strings "c#13;c#10;c#13;c#10;" ["# Shen Prelude API Docs" | Entries])
     _        (write-to-file "api.md" Markdown)
  docs-written)
