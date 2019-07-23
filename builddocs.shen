(load "prelude.shen")

(define format-type-sub
  Type -> (cn "(" (cn (join-strings " " (map (function format-type-sub) Type)) ")")) where (cons? Type)
  -->  -> "→"
  Type -> (str Type))

(define format-type
  Type -> (join-strings " " (map (function format-type-sub) Type)) where (cons? Type)
  Type -> (str Type))

(define api-entry
  Name Doc Type ->
    (let Heading (@s "### `" (str Name) "`")
         Heading (if (fail? Type) Heading (@s Heading " : `" (format-type Type) "`"))
      [Heading Doc]))

(let NameDocs (value *doc-index*)
     Entries  (flat-map (/. D (api-entry (fst D) (snd D) (type-of (fst D)))) (value *doc-index*))
     Markdown (join-strings "c#10;c#13;c#10;c#13;" ["# Shen Prelude API Docs" | Entries])
  (write-to-file "api.md" Markdown))
