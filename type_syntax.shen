(datatype lazy-seq-type

  X : (lazy (list A));
  ___________________
  X : (lazy-seq A);

  _________________
  [] : (lazy-seq A);

  X : A; Y : (lazy-seq A);
  _______________________
  (freeze (cons X Y)) : (lazy-seq A);

  X : (lazy-seq A);
  ________________
  (thaw X) : (thawed-seq A);

  X : (thawed-seq A);
  __________________
  (head X) : A;

  X : (thawed-seq A);
  __________________
  (tail X) : (lazy-seq A);

  X : (lazy-seq A);
  ________________
  (= (thaw X) []) : boolean;)

(deftype lazy-seq
  (if
    (or
      (= X [])
      (: X (lazy (list A))))
    (: X (lazy-seq A)))
  (if
    (and
      (: X A)
      (: Y (lazy-seq A)))
    (: (freeze (cons X Y)) (lazy-seq A)))
  (if
    (: X (lazy-seq A))
    (and
      (: (thaw X) (thawed-seq A))
      (: (= (thaw X) []) boolean)))
  (if
    (: X (thawed-seq A))
    (and
      (: (head X) A)
      (: (tail X) (lazy-seq A)))))





(defmacro deftype-macro
  [deftype Name | Rules] ->
    [datatype (intern (@s (str Name) "-type")) | (mapcan #'sequent Rules)])

(define sequent
  [if [and | Ps] Q] -> (append (mapcan #'label Ps) [__] (label Q))
  [if [or  | Ps] Q] -> (mapcan (/. P (sequent [if P Q])) Ps)
  [if P [and | Qs]] -> (mapcan (/. Q (sequent [if P Q])) Qs)
  [if P [or  | Qs]] -> (append (label P) [__] (mapcan #'label Qs))
  [if P Q] -> (append (label P) [__] (label Q))
  Q -> (append [__] (label Q)))

(define label
  [: X T] -> [X : T ;]
  X -> [X ;])
