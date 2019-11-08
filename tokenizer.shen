\**********************************
 * Standard Utility Functions     *
 *                                *
 * Functions that would likely be *
 * in the standard library.       *
 **********************************\

(define string-length X -> (length (explode X)))

(define sum-by-onto
  N F [X | Xs] -> (sum-by-onto (+ N (F X)) F Xs)
  N _ _        -> N)

(define sum-by
  F Xs -> (sum-by-onto 0 F Xs))

(define reverse-map-onto
  R F [X | Xs] -> (reverse-map-onto [(F X) | R] F Xs)
  R _ _        -> R)

(define reverse-map
  F Xs -> (reverse-map-onto [] F Xs))

(define push-onto
  R [X | Xs] -> (push-onto [X | R] Xs)
  R _        -> R)

(define flatten-onto
  R [Xs | Xss] -> (flatten-onto (push-onto R Xs) Xss)
  R _          -> R)

(define flatten
  Xs -> (reverse (flatten-onto [] Xs)))

(define flat-map
  F Xs -> (flatten (map F Xs)))

(define list-join
  _ []       -> []
  _ [X]      -> [X]
  Y [X | Xs] -> [X Y | (list-join Y Xs)])

(define reverse-flat-map
  F Xs -> (flatten-onto [] (map F Xs)))

(define any?
  _ []       -> false
  F [X | _]  -> true where (F X)
  F [_ | Xs] -> (any? F Xs))

(define implode-onto
  S []       -> S
  S [X | Xs] -> (implode-onto (@s X S) Xs))

(define implode
  X -> (implode-onto "" (reverse X)))

(define join-lines-onto
  _  S  []       -> S
  Nl "" [X | Xs] -> (join-lines-onto Nl X Xs)
  Nl S  [X | Xs] -> (join-lines-onto Nl (@s S Nl X) Xs))

(define reverse-join-lines
  Nl Xs -> (join-lines-onto Nl "" (reverse Xs)))

(define join-lines
  Nl Xs -> (reverse-join-lines Nl (reverse Xs)))

\**********************
 * Syntax Recognisors *
 **********************\

(define delimiter?
  X -> (element? X ["(" ")" "[" "]" "|" "{" "}" "," ";" ":"]))

(define delimiter2?
  X Y -> (and (= ":" X) (element? Y ["=" "-"])))

(define digit?
  X -> (element? X ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9"]))

(define sign?
  X -> (element? X ["-" "+"]))

(define whitespace?
  X -> (<= (string->n X) 32))

(define quote?
  X -> (= "c#34;" X))

(define lf?
  X -> (= "c#10;" X))

(define crlf?
  X Y -> (and (= "c#13;" X) (lf? Y)))

(define input-terminator?
  X -> (= "c#94;" X))

(define numeric-literal-decimal?
  []       -> true
  [X | Xs] -> (numeric-literal-decimal? Xs) where (digit? X)
  _        -> false)

(define numeric-literal-sans-sign?
  []         -> true
  [X   | Xs] -> (numeric-literal-sans-sign? Xs) where (digit? X)
  ["." | Xs] -> (numeric-literal-decimal? Xs)
  _          -> false)

(define numeric-literal?
  [X]      -> (digit? X)
  [X | Xs] -> (numeric-literal-sans-sign? Xs) where (sign? X)
  Xs       -> (numeric-literal-sans-sign? Xs))

\*******************************************
 * Tokenizer Functions                     *
 *                                         *
 * Pick a character sequence into a linear *
 * sequence of syntax tokens.              *
 *******************************************\

(define advance1
  [L C Ln Cn] X -> [L C (+ 1 Ln) 1] where (lf? X)
  [L C Ln Cn] X -> [L C Ln (+ 1 Cn)])

(define advance
  L []       -> L
  L [X | Xs] -> (advance (advance1 L X) Xs))

(define advance-by-token
  L [_ X | _] -> (advance L X)
  A B         -> (error "pattern match fallthrough: ~A, ~A" A B))

(define after
  [_ _ L C] -> [L C L C])

(define location-str
  [L C L  C ] -> (make-string "line ~A, column ~A" L C)
  [L C Ln Cn] -> (make-string "line ~A, column ~A to line ~A, column ~A" L C Ln Cn))

(define gather-whitespace
  R [X | Xs] -> (gather-whitespace [X | R] Xs) where (whitespace? X)
  R Xs       -> (@p [whitespace (reverse R)] Xs))

(define gather-string
  R [X | Xs] -> (@p [string (reverse R)] Xs) where (quote? X)
  R [X | Xs] -> (gather-string [X | R] Xs)
  _ _        -> (error "unexpected end of string"))

(define gather-line-comment
  R [CR LF | Xs] -> (@p [line-comment (reverse R)] [CR LF | Xs]) where (crlf? CR LF)
  R [LF    | Xs] -> (@p [line-comment (reverse R)] [LF | Xs]) where (lf? LF)
  R [X     | Xs] -> (gather-line-comment [X | R] Xs)
  R Xs           -> (@p [line-comment (reverse R)] Xs))

(define gather-block-comment
  R ["*" "\" | Xs] -> (@p [block-comment (reverse R)] Xs)
  R [X       | Xs] -> (gather-block-comment [X | R] Xs)
  R _              -> (error "unexpected end of block comment"))

(define gather-atom
  R [X     | Xs] -> (@p (reverse R) [X | Xs]) where (or (delimiter? X) (whitespace? X))
  R ["\" X | Xs] -> (@p (reverse R) ["\" X | Xs]) where (element? X ["\" "*"])
  R [X     | Xs] -> (gather-atom [X | R] Xs)
  R Xs           -> (@p (reverse R) Xs))

(define tokenize-atom
  Xs -> [number Xs] where (numeric-literal? Xs)
  Xs -> [symbol Xs])

(define tokenize-exploded
  M R [X | Xs] ->
    (error "input terminated at ~A" (location-str M)) where (input-terminator? X)
  M R [X Y | Xs] ->
    (let M+ (advance M [X Y])
      (tokenize-exploded (after M+) [[delimiter [X Y] M+] | R] Xs))
    where (delimiter2? X Y)
  M R [X | Xs] ->
    (let M+ (advance1 M X)
      (tokenize-exploded (after M+) [[delimiter [X] M+] | R] Xs))
    where (delimiter? X)
  M R [X | Xs] ->
    (let P  (gather-whitespace [X] Xs)
         M+ (advance-by-token M (fst P))
         T  (append (fst P) [M+])
      (tokenize-exploded (after M+) [T | R] (snd P)))
    where (whitespace? X)
  M R [X | Xs] ->
    (let P  (gather-string [] Xs)
         M+ (advance-by-token M (fst P))
         T  (append (fst P) [M+])
      (tokenize-exploded (after M+) [T | R] (snd P)))
    where (quote? X)
  M R ["\" "\" | Xs] ->
    (let P  (gather-line-comment [] Xs)
         M+ (advance-by-token M (fst P))
         T  (append (fst P) [M+])
      (tokenize-exploded (after M+) [T | R] (snd P)))
  M R ["\" "*" | Xs] ->
    (let P  (gather-block-comment [] Xs)
         M+ (advance-by-token M (fst P))
         T  (append (fst P) [M+])
      (tokenize-exploded (after M+) [T | R] (snd P)))
  M R [X | Xs] ->
    (let P  (gather-atom [X] Xs)
         M+ (advance M (fst P))
         T  (append (tokenize-atom (fst P)) [M+])
      (tokenize-exploded (after M+) [T | R] (snd P)))
  M R _ ->
    (reverse R))

(define implode-tokens
  R []             -> (reverse R)
  R [[A X M] | Xs] -> (implode-tokens [[A (implode X) M] | R] Xs))

(define string->tokens
  S -> (implode-tokens [] (tokenize-exploded [1 1 1 1] [] (explode S))))

\*****************************************
 * Token Print Functions                 *
 *                                       *
 * Re-render token sequence as a string. *
 *****************************************\

(define escape-char
  X -> (@s "c" "#" (str (string->n X)) ";"))

(define escape-string-literal
  S -> (implode (map (/. X (if (quote? X) (escape-char X) X)) (explode S))))

(define token->string
  [string        X     | _] -> (@s "c#34;" (escape-string-literal X) "c#34;")
  [line-comment  X     | _] -> (@s "\\" X)
  [block-comment X     | _] -> (@s "\*" X "*\")
  [form          Xs    | _] -> (@s "(" (tokens->string Xs) ")")
  [list          Xs [] | _] -> (@s "[" (tokens->string Xs) "]")
  [list          Xs Ys | _] -> (@s "[" (tokens->string Xs) "|" (tokens->string Ys) "]")
  [A                 X | _] -> X
  X -> (error "token->string: ~A" X))

(define tokens->string
  Xs -> (implode (map (function token->string) Xs)))

\*****************************************************
 * Inflation Functions                               *
 *                                                   *
 * Turns linear token sequence into a tree structure *
 * based on "(", ")", "[" and "]" tokens.            *
 *****************************************************\

(define reverse-gather-tail-onto
  Os N R [[whitespace    X | M] | Xs] -> (reverse-gather-tail-onto Os N [[whitespace    X | M] | R] Xs)
  Os N R [[line-comment  X | M] | Xs] -> (reverse-gather-tail-onto Os N [[line-comment  X | M] | R] Xs)
  Os N R [[block-comment X | M] | Xs] -> (reverse-gather-tail-onto Os N [[block-comment X | M] | R] Xs)
  Os 0 R [X                     | Xs] -> (reverse-gather-tail-onto Os 1 [X | R] Xs)
  _  1 R [[symbol "|"      | _] | Xs] -> [list (reverse Xs) R] where (any? (/. X (not (= whitespace (hd X)))) Xs)
  Os _ _ _                            -> [list (reverse Os) []])

(define gather-tail
  Xs -> (reverse-gather-tail-onto (reverse Xs) 0 [] (reverse Xs)))

(define inflate-list
  _ [[delimiter ")" | _] | _]  -> (error "mismatched )")
  R [[delimiter "]" | _] | Xs] -> (@p (gather-tail (tokens->trees (reverse R))) Xs)
  R [[delimiter "(" | _] | Xs] -> (let P (inflate-form [] Xs) (inflate-list [(fst P) | R] (snd P)))
  R [[delimiter "[" | _] | Xs] -> (let P (inflate-list [] Xs) (inflate-list [(fst P) | R] (snd P)))
  R [[delimiter X   | M] | Xs] -> (inflate-list [[symbol X | M] | R] Xs)
  R [X                   | Xs] -> (inflate-list [X | R] Xs)
  R _                          -> (error "unexpected end of list"))

(define inflate-form
  R [[delimiter ")" | _] | Xs] -> (@p [form (reverse R)] Xs)
  _ [[delimiter "]" | _] | _]  -> (error "mismatched ]")
  R [[delimiter "(" | _] | Xs] -> (let P (inflate-form [] Xs) (inflate-form [(fst P) | R] (snd P)))
  R [[delimiter "[" | _] | Xs] -> (let P (inflate-list [] Xs) (inflate-form [(fst P) | R] (snd P)))
  R [[delimiter X   | M] | Xs] -> (inflate-form [[symbol X | M] | R] Xs)
  R [X                   | Xs] -> (inflate-form [X | R] Xs)
  R _                          -> (error "unexpected end of form"))

(define inflate-tokens
  _ [[delimiter ")" | _] | _]  -> (error "mismatched )")
  _ [[delimiter "]" | _] | _]  -> (error "mismatched ]")
  R [[delimiter "(" | _] | Xs] -> (let P (inflate-form [] Xs) (inflate-tokens [(fst P) | R] (snd P)))
  R [[delimiter "[" | _] | Xs] -> (let P (inflate-list [] Xs) (inflate-tokens [(fst P) | R] (snd P)))
  R [[delimiter X   | M] | Xs] -> (inflate-tokens [[symbol X | M] | R] Xs)
  R [X                   | Xs] -> (inflate-tokens [X | R] Xs)
  R Xs                         -> (@p (reverse R) Xs))

(define tokens->trees
  Xs -> (fst (inflate-tokens [] Xs)))

\********************************************
 * Strip Functions                          *
 *                                          *
 * Remove all whitespace and comment tokens *
 * from an inflated token tree.             *
 ********************************************\

(define strip-whitespace-each
  R [[whitespace | _]  | Xs] -> (strip-whitespace-each R Xs)
  R [[form Ys    | Ms] | Xs] -> (strip-whitespace-each [[form (strip-whitespace Ys) | Ms] | R] Xs)
  R [[list Ys Zs | Ms] | Xs] -> (strip-whitespace-each [[list (strip-whitespace Ys) (strip-whitespace Zs) | Ms] | R] Xs)
  R [X                 | Xs] -> (strip-whitespace-each [X | R] Xs)
  R _                        -> (reverse R))

(define strip-comments-each
  R [[line-comment  | _]  | Xs] -> (strip-comments-each R Xs)
  R [[block-comment | _]  | Xs] -> (strip-comments-each R Xs)
  R [[form Ys       | Ms] | Xs] -> (strip-comments-each [[form (strip-comments Ys) | Ms] | R] Xs)
  R [[list Ys Zs    | Ms] | Xs] -> (strip-comments-each [[list (strip-comments Ys) (strip-comments Zs) | Ms] | R] Xs)
  R [X                    | Xs] -> (strip-comments-each [X | R] Xs)
  R _                           -> (reverse R))

(define strip-meta-each
  R [[form Ys    | _] | Xs] -> (strip-meta-each [[form (strip-meta Ys)] | R] Xs)
  R [[list Ys Zs | _] | Xs] -> (strip-meta-each [[list (strip-meta Ys) (strip-meta Zs)] | R] Xs)
  R [[A X        | _] | Xs] -> (strip-meta-each [[A X] | R] Xs)
  R _                       -> (reverse R))

(define strip-whitespace
  Xs -> (strip-whitespace-each [] Xs))

(define strip-comments
  Xs -> (strip-comments-each [] Xs))

(define strip-meta
  Xs -> (strip-meta-each [] Xs))

(define strip-trivia
  Xs -> (strip-meta (strip-comments (strip-whitespace Xs))))

\******************************************************
 * Pretty Printing                                    *
 *                                                    *
 * Render a token tree back to a string with modified *
 * whitespace to improve layout.                      *
 ******************************************************\

(define printed-length
  Xs -> (string-length (tokens->string Xs)))

(define space-out
  []                         -> []
  [X]                        -> [X]
  [[delimiter "(" | M] | Xs] -> [[delimiter "(" | M] | (space-out Xs)]
  [[delimiter "[" | M] | Xs] -> [[delimiter "[" | M] | (space-out Xs)]
  [[delimiter "|" | M] | Xs] -> [[whitespace " "] [delimiter "|" | M] [whitespace " "] | (space-out Xs)]
  [X                   | Xs] -> [X [whitespace " "] | (space-out Xs)])

(define collapse-clause
  (@p Patterns Action skip) ->
    (append
      (flat-map (function pretty-print-token) Patterns)
      [[symbol "->"]]
      (pretty-print-token Action))
  (@p Patterns Action Test) ->
    (append
      (flat-map (function pretty-print-token) Patterns)
      [[symbol "->"]]
      (pretty-print-token Action)
      [[symbol "where"]]
      (pretty-print-token Test)))

(define pretty-print-typed-define
  Name TypeSig Clauses ->
    (append
      [[delimiter "("] [symbol "define"] [whitespace " "] Name]
      (let Lead (if (> (printed-length TypeSig) 64) [whitespace "c#10;  "] [whitespace " "])
        (append [Lead [symbol "{"]] (space-out TypeSig) [[symbol "}"]]))
      (flat-map (/. C (append [[whitespace "c#10;  "]] (space-out (collapse-clause C)))) Clauses)
      [[delimiter ")"]]))

(define pretty-print-define
  Name Clauses ->
    (append
      [[delimiter "("] [symbol "define"] [whitespace " "] Name]
      (flat-map (/. C (append [[whitespace "c#10;  "]] (space-out (collapse-clause C)))) Clauses)
      [[delimiter ")"]]))

(define gather-type-signature
  R [[symbol "}" | _] | Xs] -> (@p (reverse R) Xs)
  R [X                | Xs] -> (gather-type-signature [X | R] Xs)
  R _                       -> (error "unexpected end of type signature"))

(define gather-clause
  R [[symbol "->" | _] Action [symbol "where" | _] Test | Xs] -> (@p (@p (reverse R) Action Test) Xs)
  R [[symbol "->" | _] Action                           | Xs] -> (@p (@p (reverse R) Action skip) Xs)
  R [X                                                  | Xs] -> (gather-clause [X | R] Xs)
  R _                                                         -> (reverse R))

(define gather-clauses
  R [] ->
    (reverse R)
  R Xs ->
    (let P (gather-clause [] Xs)
      (gather-clauses [(fst P) | R] (snd P))))

\\ TODO: need special format handling for:
\\ define, define{, defun, defmacro, defprolog, prolog?, datatype, let, if, trap-error, lambda
(define pretty-print-token
  [form [[symbol "define" | _] Name [symbol "{" | _] | Body] | _] ->
    (let P (gather-type-signature [] Body)
      (pretty-print-typed-define Name (fst P) (gather-clauses [] (snd P))))
  [form [[symbol "define" | _] Name | Body] | _] ->
    (pretty-print-define Name (gather-clauses [] Body))
  [form [[symbol "if" | M] Test True False] | _] ->
    (append
      [[delimiter "("]]
      (space-out [[symbol "if" | M] | (flat-map (function pretty-print-token) [Test True False])])
      [[delimiter ")"]])
  [form Xs | _] ->
    (append
      [[delimiter "("]]
      (space-out (flat-map (function pretty-print-token) Xs))
      [[delimiter ")"]])
  [list Xs [] | _] ->
    (append
      [[delimiter "["]]
      (space-out (flat-map (function pretty-print-token) Xs))
      [[delimiter "]"]])
  [list Xs Ys | _] ->
    (append
      [[delimiter "["]]
      (space-out (flat-map (function pretty-print-token) Xs))
      [[whitespace " "] [delimiter "|"] [whitespace " "]]
      (space-out (flat-map (function pretty-print-token) Ys))
      [[delimiter "]"]])
  X ->
    [X])

(define pretty
  S ->
    (reverse-join-lines
      ""
      (map
        (/. Xs (join-lines "" Xs))
        (list-join
          ["c#10;c#10;"]
          (reverse-map
            (/. X (map (function token->string) (pretty-print-token X)))
            (strip-meta (tokens->trees (strip-whitespace (string->tokens S)))))))))

\*******************************************
 * Shen AST Creation Functions             *
 *                                         *
 * Turns a trivia-stripped token tree into *
 * a Shen AST suitable for evaluation.     *
 *******************************************\

(define list-token->shen
  T [X | Xs] -> (list-token->shen [cons X T] Xs)
  T _        -> T)

(define list-tail->shen
  []       -> []
  [X | Xs] -> (list-token->shen X Xs))

(define tree->shen
  [symbol "<>" | _] -> [vector 0]
  [symbol "|"  | _] -> bar!
  [symbol X    | _] -> (intern X)
  [number X    | _] -> (hd (read-from-string X))
  [string X    | _] -> (shen.control-chars (explode X))
  [form   Xs   | _] -> (map (function tree->shen) Xs)
  [list   Xs T | _] ->
    (list-token->shen
      (list-tail->shen (map (function tree->shen) T))
      (reverse-map (function tree->shen) Xs)))

(define trees->shens
  Xs -> (map (function tree->shen) (strip-trivia Xs)))

(define string->shen
  S -> (trees->shens (tokens->trees (strip-trivia (string->tokens S)))))

\\ TODO: retain line, col info for (, ), [, |, ] delimiters in form, list tree tokens
\\ TODO: linting; auto-perform linting
