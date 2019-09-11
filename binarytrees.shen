(datatype binary-tree
  ______________________
  tip : (binary-tree A);

  X : A;
  L : (binary-tree A);
  R : (binary-tree A);
  _____________________________
  (@p X L R) : (binary-tree A);)

(define traverse-pre-order
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (traverse-pre-order F (traverse-pre-order F (F (here T) B) (left T)) (right T)))

(define traverse-post-order
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (F (here T) (traverse-post-order F (traverse-post-order F B (left T)) (right T))))

(define traverse-in-order
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (traverse-in-order F (F (here T) (traverse-in-order F B (left T))) (right T)))

(define traverse-level-order
  {(A --> B --> B) --> B --> (binary-tree A) --> B}
  _ B tip -> B
  F B T -> (F (here T) B)) \\ TODO: implement this https://en.wikipedia.org/wiki/Tree_traversal#Breadth-first_search_2

(define traverse
  {symbol --> (A --> B --> B) --> B --> (binary-tree A) --> B}
  pre   F B T -> (traverse-pre-order   F B T)
  post  F B T -> (traverse-post-order  F B T)
  in    F B T -> (traverse-in-order    F B T)
  level F B T -> (traverse-level-order F B T))

(define binary-tree->list
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
(set *tree*
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
(datatype tree234234 __ (value *tree*) : (binary-tree number);)
(reverse (traverse-pre-order #'cons [] &'*tree*))
*\
