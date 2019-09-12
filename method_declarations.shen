(defmulti size
  doc "Generic size method."
  {A --> number})

(defmethod size nil    (const 0))
(defmethod size number #'id)
(defmethod size string #'string-length)
(defmethod size symbol (/. X (string-length (str X))))
(defmethod size cons   #'length)
(defmethod size vector #'limit)
(defmethod size stack  #'stack-size)
(defmethod size queue  #'queue-size)

(defmulti pop
  doc "Generic pop method. Destructively removes next item from sequence. Raises error on empty."
  {(K A) --> A})

(defmethod pop stack #'stack-pop)
(defmethod pop queue #'queue-pop)

(defmulti peek
  doc "Generic peek method. Returns next item from sequence without modifiying container. Raises error on empty."
  {(K A) --> A})

(defmethod peek stack #'stack-peek)
(defmethod peek queue #'queue-peek)

(defmulti push
  doc "Generic push method. Adds item to mutable container."
  {(K A) --> A --> (K A)})

(defmethod push stack #'stack-push)
(defmethod push queue #'queue-push)
