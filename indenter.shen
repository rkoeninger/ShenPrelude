(define identer.track-state
  {number --> boolean --> string --> (number * boolean)}
  D Q "" -> (@p D Q)
  D Q (@s "c#34;" S) -> (identer.track-state D (not Q) S)
  D false (@s "(" S) -> (identer.track-state (+ D 1) false S)
  D false (@s ")" S) -> (identer.track-state (- D 1) false S)
  D Q (@s _ S) -> (identer.track-state D Q S))

(define identer.indent-lines
  {number --> boolean --> (list string) --> (list string)}
  _ _ [] -> []
  Depth Quote [Line | Lines] ->
    (let Pair (identer.track-state Depth Quote Line)
         Depth' (fst Pair)
         Quote' (snd Pair)
         Line' (if Quote
                 (if Quote' Line (trim-end Line))
                 (cn
                   (if (= "" (trim Line)) "" (spaces (* 2 Depth)))
                   (if Quote' (trim-start Line) (trim Line))))
      [Line' | (identer.indent-lines Depth' Quote' Lines)]))

(define write-file-as-string
  doc "Writes string as ASCII sequence to file at given path."
  {string --> string --> unit}
  Path String ->
    (let Stream (open Path out)
      (do
        (for-each (/. B (write-byte B Stream)) (string->bytes String))
        (close Stream)
        (void))))

(define indent-file
  doc "Reads file at In path and overrites file at Out path with lines properly indented."
  {symbol --> string --> string --> unit}
  Ending In Out ->
    (->> In
      read-file-as-string
      (split-lines Ending)
      (map #'trim)
      (identer.indent-lines 0 false)
      (join-lines Ending)
      (write-file-as-string Out)))
