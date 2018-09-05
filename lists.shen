(define complement
  doc "Returns new version of function with inverse result of given function."
  {(A --> boolean) --> A --> boolean}
  F -> (/. X (not (F X))))

(define any?
  doc "Returns true if predicate returns true for any elements in list."
  {(A --> boolean) --> (list A) --> boolean}
  _ [] -> false
  F [X | Xs] -> (or (F X) (any? F Xs)))

(define all?
  doc "Returns true if predicate returns true for all elements in list."
  {(A --> boolean) --> (list A) --> boolean}
  _ [] -> true
  F [X | Xs] -> (and (F X) (all? F Xs)))

(define take
  doc "Returns first n elements in list."
  {number --> (list A) --> (list A)}
  0 _ -> []
  _ [] -> []
  N [X | Xs] -> [X | (take (- N 1) Xs)])

(define take-while
  doc "Returns list of consecutive leading elements so long as given predicate returns true for them."
  {(A --> boolean) --> (list A) --> (list A)}
  F [X | Xs] -> [X | (take-while F Xs)] where (F X)
  _ _ -> [])

(define drop
  doc "Returns all but the first n elements in list."
  {number --> (list A) --> (list A)}
  0 Xs -> Xs
  _ [] -> []
  N [_ | Xs] -> (drop (- N 1) Xs))

(define drop-while
  doc "Returns list remaining elements after dropping consecutive leading elements so long as given predicate returns true for them."
  {(A --> boolean) --> (list A) --> (list A)}
  F [X | Xs] -> (drop-while F Xs) where (F X)
  _ Xs -> Xs)

(define split-at
  doc "Splits list into two sublists at given index."
  {number --> (list A) --> ((list A) * (list A))}
  N Xs -> (@p (take N Xs) (drop N Xs)))

(define separate
  doc "Splits list into two separate lists based on whether predicate returns true or false."
  {(A --> boolean) --> (list A) --> ((list A) * (list A))}
  F Xs ->
    (map-both
      #'reverse
      (fold-left
        (/. P X ((if (F X) #'map-fst #'map-snd) (prepend X) P))
        (@p [] [])
        Xs)))

(define partition
  doc "Splits list into list of sublists, each no longer than given length."
  {number --> (list A) --> (list (list A))}
  N Xs ->
    (let S (split-at N Xs)
      [(fst S) | (if (= [] (snd S)) [] (partition N (snd S)))]))

(define prepend
  doc "Adds value to beginning of list."
  {A --> (list A) --> (list A)}
  X Xs -> [X | Xs])

(define suffix
  doc "Adds value to end of list."
  {A --> (list A) --> (list A)}
  X [] -> [X]
  X [Y | Ys] -> [Y | (suffix X Ys)])

(define filter
  doc "Returns copy of list with only elements for which predicate returns true."
  {(A --> boolean) --> (list A) --> (list A)}
  F [X | Xs] -> [X | (filter F Xs)] where (F X)
  F [_ | Xs] -> (filter F Xs)
  _ _ -> [])

(define fold-left
  doc "Combines values in list from left to right using given function."
  {(A --> B --> A) --> A --> (list B) --> A}
  F X [Y | Ys] -> (fold-left F (F X Y) Ys)
  _ X _ -> X)

(define fold-right
  doc "Combines values in list from right to left using given function."
  {(B --> A --> A) --> A --> (list B) --> A}
  F X [Y | Ys] -> (F Y (fold-right F X Ys))
  _ X _ -> X)

(define contains?
  doc "Returns true if any elements in list are equal to given key value."
  {A --> (list A) --> boolean}
  X Xs -> (any? (= X) Xs))

(define distinct
  doc "Returns copy of list with duplicates removed."
  {(list A) --> (list A)}
  Xs -> (reverse (fold-left (/. Ds X (if (contains? X Ds) Ds [X | Ds])) [] Xs)))

(define repeat
  doc "Builds list by repeating the same value N times."
  {number --> A --> (list A)}
  0 _ -> []
  N X -> [X | (repeat (- N 1) X)])

(define repeatedly
  doc "Builds list by invoking the same function N times."
  {number --> (--> A) --> (list A)}
  0 _ -> []
  N F -> [(F) | (repeatedly (- N 1) F)])

(define unfold-onto
  doc "Repeatedly calls given function until it returns empty list, prepending results onto given list."
  {(list A) --> (lazy (list A)) --> (list A)}
  Xs F ->
    (let X (thaw F)
      (if (cons? X)
        (unfold-onto [(head X) | Xs] F)
        Xs)))

(define unfold
  doc "Builds list by repeatedly calling the given function until it returns an empty list."
  {(lazy (list A)) --> (list A)}
  F -> (reverse (unfold-onto [] F)))

(define range
  doc "Returns list of numbers from 1 up to and including the given number."
  {number --> (list number)}
  N ->
    (let Ref (@v 1 <>)
      (unfold
        (freeze
          (let X (<-vector Ref 1)
               _ (vector-> Ref 1 (+ X 1))
            (if (<= X N) [X] []))))))

(define max-compare-by
  doc "Returns maximum value in list comparing using given function."
  {(A --> A --> boolean) --> (list A) --> A}
  F [X | Xs] -> (fold-left (/. M X (if (F M X) X M)) X Xs)
  _ _ -> (error "max-compare-by: empty list"))

(define max-by
  doc "Returns value in list for which given function returns maximum value."
  {(A --> number) --> (list A) --> A}
  F Xs -> (max-compare-by (/. X Y (< (F X) (F Y))) Xs))

(define max
  doc "Returns maximum number in list."
  {(list number) --> number}
  Xs -> (max-compare-by #'< Xs))

(define flatten
  doc "Converts a list of lists into one long list."
  {(list (list A)) --> (list A)}
  [] -> []
  [Xs | Xss] -> (append Xs (flatten Xss)))

(define flat-map
  doc "Applies function to each value in list and concat's results into one long list."
  {(A --> (list B)) --> (list A) --> (list B)}
  F Xs -> (flatten (map F Xs)))

(define zip-with
  doc "Lines up two lists and combines each pair of values into value in resulting list using given function."
  {(A --> B --> C) --> (list A) --> (list B) --> (list C)}
  _ [] _ -> []
  _ _ [] -> []
  F [X | Xs] [Y | Ys] -> [(F X Y) | (zip-with F Xs Ys)])

(define zip
  doc "Lines up two lists and combines each pair of values into tuple in resulting list."
  {(list A) --> (list B) --> (list (A * B))}
  Xs Ys -> (zip-with #'@p Xs Ys))

(define cross-join-with
  doc "Builds list of every combination of values in two lists using given function."
  {(A --> B --> C) --> (list A) --> (list B) --> (list C)}
  F Xs Ys -> (flat-map (/. X (map (F X) Ys)) Xs))

(define cross-join
  doc "Builds list of every combination of values in two lists as tuples."
  {(list A) --> (list B) --> (list (A * B))}
  Xs Ys -> (cross-join-with #'@p Xs Ys))

(define interpose
  doc "Inserts value between each value in list."
  {A --> (list A) --> (list A)}
  Sep Xs -> (tail (fold-left (/. Ys X [Sep X | Ys]) [] Xs)))

(define vector->list
  doc "Makes a new list out of a vector."
  {(vector A) --> (list A)}
  V -> (fold-left (/. Xs I [(<-vector V I) | Xs]) [] (range (limit V))))

(define list->vector
  doc "Makes a new vector out of a list."
  {(list A) --> (vector A)}
  Xs ->
    (let V (vector (length Xs))
         _ (fold-left (/. I X (do (vector-> V I X) (+ 1 I))) 1 Xs)
      V))
