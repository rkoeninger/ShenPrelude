(define track-state
  D Q "" -> (@p D Q)
  D Q (@s "c#34;" S) -> (track-state D (not Q) S)
  D false (@s "(" S) -> (track-state (+ D 1) false S)
  D false (@s ")" S) -> (track-state (- D 1) false S)
  D Q (@s _ S) -> (track-state D Q S))

(define indent-lines-h
  _ _ [] -> []
  Depth Quote [Line | Lines] ->
    (let Pair (track-state Depth Quote Line)
         Depth' (fst Pair)
         Quote' (snd Pair)
         Line' (if Quote
                 (if Quote' Line (trim-end Line))
                 (cn
                   (if (= "" (trim Line)) "" (spaces (* 2 Depth)))
                   (if Quote' (trim-start Line) (trim Line))))
      [Line' | (indent-lines-h Depth' Quote' Lines)]))

(define indent-lines
  Lines -> (indent-lines-h 0 false Lines))

(define split-lines-h
  Line Lines "" -> (reverse [Line | Lines])
  Line Lines (@s "c#10;" S) -> (split-lines-h "" [Line | Lines] S)
  Line Lines (@s "c#13;" S) -> (split-lines-h Line Lines S)
  Line Lines (@s Ch S) -> (split-lines-h (cn Line Ch) Lines S))

(define split-lines
  S -> (split-lines-h "" [] S))

(define read-file-as-lines
  Path -> (split-lines (read-file-as-string Path)))

(define write-file-as-string
  Path String ->
    (let Stream (open Path out)
         _ (shen.for-each (/. B (write-byte B Stream)) (shen.string->bytes String))
         (close Stream)))

(write-file-as-string
  "unmangled.shen"
  (join-strings "c#13;c#10;"
    (indent-lines
      (split-lines
        (read-file-as-string "mangled.shen")))))
