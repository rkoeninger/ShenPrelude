(datatype binary-tree
  ______________________
  tip : (binary-tree A);

  X : A;
  L : (binary-tree A);
  R : (binary-tree A);
  _____________________________
  (@p X L R) : (binary-tree A);)

(define traverse-pre-order
  doc "Folds values in binary tree in a pre-order traversal."
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (traverse-pre-order F (traverse-pre-order F (F (here T) B) (left T)) (right T)))

(define traverse-post-order
  doc "Folds values in binary tree in a post-order traversal."
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (F (here T) (traverse-post-order F (traverse-post-order F B (left T)) (right T))))

(define traverse-in-order
  doc "Folds values in binary tree in an in-order traversal."
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (traverse-in-order F (F (here T) (traverse-in-order F B (left T))) (right T)))

(define traverse-out-order
  doc "Folds values in binary tree in an out-order traversal."
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (traverse-out-order F (F (here T) (traverse-out-order F B (right T))) (left T)))

(define traverse-level-order
  doc "Folds values in binary tree in a level-order traversal."
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (internal.traverse-level-order-loop F B (queue-of T)))

(define internal.traverse-level-order-loop
  {(A --> B --> B) --> B --> (queue (binary-tree A)) --> B}
  _ B Q -> B where (queue-empty? Q)
  F B Q ->
    (let T (queue-pop Q)
         L (left T)
         R (right T)
      (do
        (if (= tip L) Q (queue-push Q L))
        (if (= tip R) Q (queue-push Q R))
        (internal.traverse-level-order-loop F (F (here T) B) Q))))

(define traverse
  doc "Folds values in binary tree in given traversal."
  {symbol --> (A --> B --> B) --> B --> (binary-tree A) --> B}
  pre   F B T -> (traverse-pre-order   F B T)
  post  F B T -> (traverse-post-order  F B T)
  in    F B T -> (traverse-in-order    F B T)
  out   F B T -> (traverse-out-order   F B T)
  level F B T -> (traverse-level-order F B T)
  _     _ _ _ -> (error "traverse expects 1st argument to be one of [pre post in out level]"))

(define binary-tree->list
  doc "Collects values in binary tree into a list in given traversal."
  {symbol --> (binary-tree A) --> (list A)}
  Mode Tree -> (reverse (traverse Mode #'cons [] Tree)))

\*
      0
   /     \
  1      5
 /\    /   \
2 3   6    8
   \  \   /
    4  7 9
(set t
  (node 0
    (node 1
      (node 2
        tip
        tip)
      (node 3
        tip
        (node 4
          tip
          tip)))
    (node 5
      (node 6
        tip
        (node 7
          tip
          tip))
      (node 8
        (node 9
          tip
          tip)
        tip))))
(datatype tree234234 __ (value t) : (binary-tree number);)
(reverse (traverse-pre-order #'cons [] &'t))
*\
