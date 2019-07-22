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

(define second
  [_ X | _] -> X
  _ -> (error "no 2nd!"))

(define string-lt?
  "" _  -> true
  _  "" -> false
  S  T  -> (or (< (string->n S) (string->n T)) (string-lt? (tlstr S) (tlstr T)))
  _  _  -> false)

(define bubble-sort-swap
  N V ->
    (if (string-lt? (<-vector V N) (<-vector V (+ N 1)))
      (let Temp (<-vector V N)
        (do
          (vector-> V N (<-vector V (+ N 1)))
          (vector-> V (+ N 1) Temp)))
      V))

(define bubble-sort-vector-iteration
  1 V -> V
  N V -> (bubble-sort-vector-iteration (- N 1) V))

(define bubble-sort-vector
  1 V -> V
  N V -> (bubble-sort-vector (- N 1) (bubble-sort-vector-iteration (- (limit V) 1) V)))

(define list->vector-iteration
  []       _ V -> V
  [X | Xs] N V -> (list->vector-iteration Xs (+ N 1) V))

(define list->vector
  Xs -> (list->vector-iteration Xs 1 (vector (length Xs))))

(define vector->list-iteration
  Xs 0 V -> Xs
  Xs N V -> (vector->list-iteration [(<-vector V N) | Xs] (- N 1) V))

(define vector->list
  V -> (vector->list-iteration [] (limit V) V))

(define bubble-sort-list
  List ->
    (list->vector
      (let Vector (list->vector List)
        (bubble-sort-vector (limit Vector) Vector))))

(let Modules  [functions lists strings tuples]
     Files    (map (/. M (cn (str M) ".shen")) Modules)
     Exprs    (flat-map (function read-file) Files)
     Defines  (filter (function define?) Exprs)
     \\ (bubble-sort-list (map (/. D (str (second D))) Defines))
     Markdown (cn* ["# Shen Prelude API Docs" | (flat-map (function markdown-define) Defines)])
  (write-to-file "output.md" Markdown))
