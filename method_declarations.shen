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
