(define node
  doc "Creates a binary tree node from a value, left branch and right branch."
  X L R -> (@p X L R))

(define here
  doc "Gets the value of a binary tree node."
  (@p X _ _) -> X)

(define left
  doc "Gets the left branch of a binary tree node."
  (@p _ L _) -> L)

(define right
  doc "Gets the right branch of a binary tree node."
  (@p _ _ R) -> R)

(declare node [A --> [[binary-tree A] --> [[binary-tree A] --> [binary-tree A]]]])
(declare here [[binary-tree A] --> A])
(declare left [[binary-tree A] --> [binary-tree A]])
(declare right [[binary-tree A] --> [binary-tree A]])
