\\ Simplified version of Clojure multi-methods (https://clojure.org/reference/multimethods)
\\ Only works for 1-arg functions.
\\ Uncomment example at bottom to test.

(define make-multi
  doc "Declares a new multi-method."
  {symbol --> (A --> K) --> unit}
  Name Selector ->
    (let Multi (@v Name Selector (shen.dict 32) <>)
      (put Name multi Multi)))

(define call-multi
  doc "Invokes a 1-parameter multi-method."
  {symbol --> A --> B}
  Name Arg ->
    (let Multi    (get Name multi)
         Selector (<-vector Multi 2)
         Methods  (<-vector Multi 3)
         Key      (Selector Arg)
         Body     (shen.<-dict Methods Key)
      (Body Arg)))

(define extend-multi
  doc "Adds implementation for multi-method for key."
  {symbol --> K --> A --> B}
  Name Key Body ->
    (let Multi   (get Name multi)
         Methods (<-vector Multi 3)
      (do
        (shen.dict-> Methods Key Body)
        Body)))

(defmacro defmulti-macro
  [defmulti Name Selector] ->
    [do
      [make-multi Name Selector]
      [define Name ~'Arg -> [call-multi Name ~'Arg]]]
  [defmulti Name Type Selector] ->
    [do
      [make-multi Name Selector]
      [define Name Type ~'Arg -> [call-multi Name ~'Arg]]])

(defmacro defmethod-macro
  [defmethod Name Key Body] ->
    [extend-multi Name Key Body])

\*
\\ Define prerequisite math function:
(define sign   0 -> 0   X -> 1 where (> X 0)   _ -> -1)

\\ Define a multimethod with a name and a selector function:
(defmulti show-sign (function sign))

\\ Define implementations by specifying a key value and a body:
(defmethod show-sign  0 (/. _ "zero"))
(defmethod show-sign  1 (/. _ "positive"))
(defmethod show-sign -1 (/. _ "negative"))

\\ The key value is the value returned by the selector function
\\ for a set of arguments.

\\ The code above defines a function called `show-sign` which takes
\\ a number and returns "positive" if the number is positive, returns
\\ "negative" if the number is negative and returns "zero" if the
\\ number is zero.

\\ A multimethod can use any function as a selector. Typically,
\\ a selector will be a classifier that returns relatively few values
\\ so that an implementation can be provided for all keys.

\\ If a multimethod is applied to an argument that has no
\\ implementation defined for it, or the selector itself raises an
\\ error, that error will propogate to the caller.
*\
