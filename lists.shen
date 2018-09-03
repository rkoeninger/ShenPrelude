(define any?
  {(A --> boolean) --> (list A) --> boolean}
  _ [] -> false
  F [X | Xs] -> (or (F X) (any? F Xs)))

(define all?
  {(A --> boolean) --> (list A) --> boolean}
  _ [] -> true
  F [X | Xs] -> (and (F X) (all? F Xs)))

(define take
  {number --> (list A) --> (list A)}
  0 _ -> []
  _ [] -> []
  N [X | Xs] -> [X | (take (- N 1) Xs)])

(define take-while
  {(A --> boolean) --> (list A) --> (list A)}
  F [X | Xs] -> [X | (take-while F Xs)] where (F X)
  _ _ -> [])

(define drop
  {number --> (list A) --> (list A)}
  0 Xs -> Xs
  _ [] -> []
  N [_ | Xs] -> (drop (- N 1) Xs))

(define drop-while
  {(A --> boolean) --> (list A) --> (list A)}
  F [X | Xs] -> (drop-while F Xs) where (F X)
  _ Xs -> Xs)

(define split-at
  {number --> (list A) --> ((list A) * (list A))}
  N Xs -> (@p (take N Xs) (drop N Xs)))

(define partition
  {number --> (list A) --> (list (list A))}
  N Xs ->
    (let S (split-at N Xs)
      [(fst S) | (if (= [] (snd S)) [] (partition N (snd S)))]))

(define suffix
  {A --> (list A) --> (list A)}
  X [] -> [X]
  X [Y | Ys] -> [Y | (suffix X Ys)])

(define filter
  {(A --> boolean) --> (list A) --> (list A)}
  F [X | Xs] -> [X | (filter F Xs)] where (F X)
  F [_ | Xs] -> (filter F Xs)
  _ _ -> [])

(define fold-left
  {(A --> B --> A) --> A --> (list B) --> A}
  F X [Y | Ys] -> (fold-left F (F X Y) Ys)
  _ X _ -> X)

(define fold-right
  {(B --> A --> A) --> A --> (list B) --> A}
  F X [Y | Ys] -> (F Y (fold-right F X Ys))
  _ X _ -> X)

(define contains?
  {A --> (list A) --> boolean}
  _ [] -> false
  X [X | _] -> true
  X [_ | Xs] -> (contains? X Xs))

(define distinct
  {(list A) --> (list A)}
  Xs -> (reverse (fold-left (/. Ds X (if (contains? X Ds) Ds [X | Ds])) [] Xs)))

(define repeat
  {number --> A --> (list A)}
  0 _ -> []
  N X -> [X | (repeat (- N 1) X)])

(define repeatedly
  {number --> (--> A) --> (list A)}
  0 _ -> []
  N F -> [(F) | (repeatedly (- N 1) F)])

(define unfold-onto
  {(list A) --> (lazy (list A)) --> (list A)}
  Xs F ->
    (let X (thaw F)
      (if (cons? X)
        (unfold-onto [(head X) | Xs] F)
        Xs)))

(define unfold
  {(lazy (list A)) --> (list A)}
  F -> (reverse (unfold-onto [] F)))

(define range
  {number --> (list number)}
  N ->
    (let Ref (@v 1 <>)
      (unfold
        (freeze
          (let X (<-vector Ref 1)
               _ (vector-> Ref 1 (+ X 1))
            (if (<= X N) [X] []))))))

(define max-compare-by
  {(A --> A --> boolean) --> (list A) --> A}
  F [X | Xs] -> (fold-left (/. M X (if (F M X) X M)) X Xs)
  _ _ -> (error "max-compare-by: empty list"))

(define max-by
  {(A --> number) --> (list A) --> A}
  F Xs -> (max-compare-by (/. X Y (< (F X) (F Y))) Xs))

(define max
  {(list number) --> number}
  Xs -> (max-compare-by #'< Xs))

(define flatten
  {(list (list A)) --> (list A)}
  [] -> []
  [Xs | Xss] -> (append Xs (flatten Xss)))

(define flat-map
  {(A --> (list B)) --> (list A) --> (list B)}
  F Xs -> (flatten (map F Xs)))

(define zip-with
  {(A --> B --> C) --> (list A) --> (list B) --> (list C)}
  _ [] _ -> []
  _ _ [] -> []
  F [X | Xs] [Y | Ys] -> [(F X Y) | (zip-with F Xs Ys)])

(define zip
  {(list A) --> (list B) --> (list (A * B))}
  Xs Ys -> (zip-with #'@p Xs Ys))

(define cross-join-with
  {(A --> B --> C) --> (list A) --> (list B) --> (list C)}
  F Xs Ys -> (flat-map (/. X (map (F X) Ys)) Xs))

(define cross-join
  {(list A) --> (list B) --> (list (A * B))}
  Xs Ys -> (cross-join-with #'@p Xs Ys))

(define interpose
  {A --> (list A) --> (list A)}
  Sep Xs -> (tail (fold-left (/. Ys X [Sep X | Ys]) [] Xs)))

(define prepend
  {A --> (list A) --> (list A)}
  X Xs -> [X | Xs])

(define separate
  {(A --> boolean) --> (list A) --> ((list A) * (list A))}
  F Xs ->
    (map-both
      #'reverse
      (fold-left
        (/. P X ((if (F X) #'map-fst #'map-snd) (prepend X) P))
        (@p [] [])
        Xs)))

(define vector->list
  {(vector A) --> (list A)}
  V -> (fold-left (/. Xs I [(<-vector V I) | Xs]) [] (range (limit V))))

(define list->vector
  {(list A) --> (vector A)}
  Xs ->
    (let V (vector (length Xs))
         _ (fold-left (/. I X (do (vector-> V I X) (+ 1 I))) 1 Xs)
      V))
