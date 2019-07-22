(define flat-map
  _ []       -> []
  F [X | Xs] -> (append (F X) (flat-map F Xs)))

(define filter
  _ []       -> []
  F [X | Xs] -> [X | (filter F Xs)] where (F X)
  F [_ | Xs] -> (filter F Xs))

(define define?
  [define | _] -> true
  _            -> false)

(define cn*
  []       -> ""
  [S | Ss] -> (cn (cn S "c#13;c#10;c#13;c#10;") (cn* Ss)))

(define sjoin
  Sep []       -> ""
  Sep [S]      -> S
  Sep [S | Ss] -> (cn (cn S Sep) (sjoin Sep Ss)))

(define take-until-right-curly
  [] -> []
  [} | _] -> []
  [X | Xs] -> [X | (take-until-right-curly Xs)])

(define markdown-typesig-sub
  Type -> (cn "(" (cn (sjoin " " (map (function markdown-typesig-sub) Type)) ")")) where (cons? Type)
  -->  -> "→"
  Type -> (str Type))

(define markdown-typesig
  Type -> (sjoin " " (map (function markdown-typesig-sub) Type)) where (cons? Type)
  Type -> (str Type))

(define markdown-typesig-take
  More -> (markdown-typesig (take-until-right-curly More)))

(define markdown-define
  [define Name doc Desc { | More] -> [(sjoin "" ["#### " (str Name) " : `" (markdown-typesig-take More) "`"]) Desc]
  [define Name doc Desc   | _]    -> [(cn "#### " (str Name)) Desc]
  [define Name          { | More] -> [(sjoin "" ["#### " (str Name) " : `" (markdown-typesig-take More) "`"])]
  [define Name            | _]    -> [(cn "#### " (str Name))])

(let Modules  [lists strings]
     Files    (map (/. M (cn (str M) ".shen")) Modules)
     Exprs    (flat-map (function read-file) Files)
     Defines  (filter (function define?) Exprs)
     Markdown (cn* ["# Shen Prelude API Docs" | (flat-map (function markdown-define) Defines)])
  (write-to-file "output.md" Markdown))
