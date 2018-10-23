\\ https://github.com/clojure/clojure-clr/blob/master/Clojure/Clojure/Lib/PersistentVector.cs

\\ stops working when vector size above 1088

\\  (define range
\\    N N -> []
\\    N M -> [N | (range (+ 1 N) M)])
\\  (define test
\\    Xs -> (= Xs (pv-tolist (pv-fromlist Xs))))
\\  (define filter
\\    _ [] -> []
\\    F [X | Xs] -> [X | (filter F Xs)] where (F X)
\\    F [_ | Xs] -> (filter F Xs))
\\  (filter (/. N (not (test (range 0 N)))) (range 0 1110))

(define pv-mask
  X -> (lisp.logand X 31))

(define pv-revmask
  X -> (lisp.logand X (lisp.lognot 31)))

(define pv-shl
  X N -> (lisp.logand (lisp.ash X N) (- (lisp.ash 1 32) 1)))

(define pv-shr
  X N -> (lisp.logand (lisp.ash X (* -1 N)) (- (lisp.ash 1 32) 1)))

(define pv-fillarray
  Array N _ -> Array where (< N 0)
  Array 0 Value -> (address-> Array 0 Value)
  Array N Value -> (pv-fillarray (address-> Array N Value) (- N 1) Value))

(define pv-copyarray
  _ Dest -1 -> Dest
  Source Dest N ->
    (do
      (address-> Dest N (<-address Source N))
      (pv-copyarray Source Dest (- N 1))))

(define pv-clone
  Array -> (pv-copyarray Array (absvector 32) 31))

(define pv-newarray
  N -> (pv-fillarray (absvector N) (- N 1) ()))

(define pv-node
  Count Shift Root Tail TailCount -> [Count Shift Root Tail TailCount])

(define pv-empty
  -> (pv-node 0 5 (pv-newarray 32) (pv-newarray 0) 0))

(define pv-tailoff
  Count -> (if (< Count 32) 0 (pv-revmask (- Count 1))))

(define pv-nth
  N NotFound V ->
    (let Count (hd V)
      (if (and (>= N 0) (< N Count))
        (let ArrayFor (pv-arrayfor N V)
          (<-address ArrayFor (pv-mask N)))
        NotFound)))

(define pv-arrayfor-search
  _ Shift Array -> Array where (<= Shift 0)
  N Shift Array ->
    (let Index (pv-mask (pv-shr N Shift))
      (pv-arrayfor-search N (- Shift 5) (<-address Array Index))))

(define pv-arrayfor
  N [Count Shift Root Tail | _] ->
    (if (>= N (pv-tailoff Count))
      Tail
      (pv-arrayfor-search N Shift Root)))

(define pv-newpath
  0 Array -> Array
  Shift Array ->
    (address-> (pv-newarray 32) 0 (pv-newpath (- Shift 5) Array)))

(define pv-pushtail
  Count Shift Parent Tail ->
    (let
      SubIndex (pv-mask (pv-shr (- Count 1) Shift))
      Result (pv-clone Parent)
      ToInsert
        (if (= 5 Shift)
          Tail
          (let Child (<-address Parent SubIndex)
            (if (= () Child)
              (pv-pushtail Count (- Shift 5) Child Tail)
              (pv-newpath (- Shift 5) Tail))))
      (address-> Result SubIndex ToInsert)))

(define pv-cons
  Value [Count Shift Root Tail TailCount] ->
    (if (< (- Count (pv-tailoff Count)) 32)
      (let NewTail (pv-copyarray Tail (absvector (+ 1 TailCount)) TailCount)
        (pv-node (+ 1 Count) Shift Root (address-> NewTail TailCount Value) (+ 1 TailCount)))
      (let NewTail (address-> (absvector 1) 0 Value)
        (if (> (pv-shr Count 5) (pv-shl 1 Shift))
          (let NewRoot (pv-newarray 32)
            (do
              (address-> NewRoot 0 Root)
              (address-> NewRoot 1 (pv-newpath Shift Tail))
              (pv-node (+ 1 Count) (+ 5 Shift) NewRoot NewTail 1)))
          (pv-node (+ 1 Count) Shift (pv-pushtail Count Shift Root Tail) NewTail 1)))))

(define pv-doassoc
  N Value Shift Array ->
    (let NewArray (pv-clone Array)
      (if (= 0 Shift)
        (address-> NewArray (pv-mask N) Value)
        (let SubIndex (pv-mask (pv-shr N Shift))
          (address-> NewArray SubIndex (pv-doassoc N Value (- Shift 5) (<-address Array SubIndex)))))))

(define pv-assocn
  N Value [Count Shift Root Tail TailCount] ->
    (if (= N Count)
      (pv-cons Value [Count Shift Root Tail TailCount])
      (if (and (>= N 0) (< N Count))
        (if (>= N (pv-tailoff Count))
          (let NewTail (pv-clone Tail)
            (pv-node Count Shift Root (address-> NewTail (pv-mask N) Value) TailCount))
          (pv-node Count Shift (pv-doassoc N Value Shift Root) Tail TailCount))
        (error "index out of range"))))

(define pv-fromlist-h
  [] V -> V
  [X | Xs] V -> (pv-fromlist-h Xs (pv-cons X V)))

(define pv-fromlist
  Xs -> (pv-fromlist-h Xs (pv-empty)))

(define pv-tolist-h
  N N V -> []
  N M V -> [(pv-nth N error V) | (pv-tolist-h (+ N 1) M V)])

(define pv-tolist
  [Count | Rest] -> (pv-tolist-h 0 Count [Count | Rest]))
