(defmacro define-with-doc-macro
  [define Name doc Doc | Rest] ->
    (do
      (write-doc Name Doc)
      [define Name | Rest]))

(defmacro set-with-doc-macro
  [set Name doc Doc | Rest] ->
    (do
      (write-doc Name Doc)
      [set Name | Rest]))

(define read-doc
  Name -> (trap-error (get Name doc) (/. E "n/a")))

(define write-doc
  Name Content -> (put Name doc Content))

(define info
  Name ->
    (make-string "~%type:   ~A~%doc:    ~A~%source: ~A~%"
      (let TypeSig (shen.get-type Name)
        (if (= shen.skip TypeSig)
          "n/a"
          TypeSig))
      (read-doc Name)
      (trap-error (ps Name) (/. E "n/a"))))

(declare read-doc [symbol --> string])
(declare write-doc [symbol --> [string --> string]])
(declare info [symbol --> string])

(do
  \\ require
  (write-doc *loaded* "List of scripts that have been loaded.")
  (write-doc reload "Loads script whether it has been loaded or not.")
  (write-doc reload-typed "Loads script with (tc +) whether it has been loaded or not.")
  (write-doc require "Loads script if it has not been loaded.")
  (write-doc require-typed "Loads script with (tc +) if it has not been loaded.")

  \\ docs
  (write-doc read-doc "Returns doc string for symbol, or 'n/a' if there isn't one.")
  (write-doc write-doc "Sets doc string for symbol.")
  (write-doc info "Returns human readable string with type, doc string, source for symbol.")

  \\ kernel
  (write-doc absvector? "Returns true if argument is an absvector.")
  (write-doc adjoin "Prepends value to head of list if not already in list.")
  (write-doc and "Returns true if both arguments are true.")
  (write-doc app "Internal function used in output macro.")
  (write-doc append "Concat's two lists into one.")
  (write-doc arity "Returns arity of given function name or -1 if there is not such function.")
  (write-doc assoc "Returns pair in association list with given key value.")
  (write-doc boolean? "Returns true if argument is a boolean.")
  (write-doc bound? "Returns true if symbol is bound to a value.")
  (write-doc cd "Changes working directory.")
  (write-doc close "Closes stream, returns empty list.")
  (write-doc cn "Concat's two strings into one.")
  (write-doc compile "Takes yacc grammar and ")
  (write-doc cons? "Returns true if argument is a cons.")
  (write-doc destroy "Erases given function.")
  (write-doc difference "Returns list of values that are in first list but not second.")
  (write-doc do "Returns result of last expression, used to group side-effecting expressions.")
  \\ TODO: <e> [[list A] ==> [list B]]
  \\ TODO: <!> [[list A] ==> [list A]]
  (write-doc element? "Returns true if value is in list.")
  (write-doc empty? "Returns true if argument is an empty list.")
  (write-doc enable-type-theory "Takes + or - to turn default type system on or off.")
  (write-doc external "Returns list of symbols exported from package.")
  (write-doc error-to-string "Returns exception's message.")
  (write-doc explode "Converts value to string and returns list of unit strings.")
  (write-doc fail "Returns the failure symbol.")
  \\ TODO: fail-if [[symbol --> boolean] --> [symbol --> symbol]]
  (write-doc fix "Repeatedly applies function until it returns the same value it was given.")
  (write-doc freeze "Returns a function that will evaluate expression.")
  (write-doc fst "Returns the first value in a 2-tuple.")
  (write-doc function "Returns function associated with symbol.")
  (write-doc gensym "Returns unique variable based on given symbol.")
  (write-doc <-vector "Gets element in vector at given 1-based index.")
  (write-doc vector-> "Sets element in vector at given 1-based index.")
  (write-doc vector "Creates new vector of given length.")
  (write-doc get-time "Returns the time, unix timestamp when passed 'unix, time since start when passed 'run.")
  (write-doc hash "Computes hash for given value, starting from given seed.")
  (write-doc head "Returns first value in list.")
  (write-doc hdv "Returns first value in vector.")
  (write-doc hdstr "Returns first unit string in string.")
  (write-doc if "Evaluates condition, evaluates and returns second expression if true, third expression if false.")
  (write-doc it "Returns expression that contains the call to (it).")
  (write-doc implementation "Returns name of language implementation/platform.")
  \\ TODO: more here
  (write-doc release "Returns version of language implementation/platform.")
  (write-doc remove "Removes all occurances of value from list.")
  (write-doc reverse "Returns new list with same elements in reverse order.")
  (write-doc simple-error "Raises exception with given error message.")
  (write-doc snd "Returns the first value in a 2-tuple.")
  \\ TODO: more here
  (write-doc variable? "Returns true if symbol could be a variable.")
  (write-doc vector? "Returns true if given value is a vector (not just an absvector).")
  (write-doc version "Returns version of Shen.")
  (write-doc write-to-file "Converts value to string and writes to file.")
  (write-doc write-byte "Writes a byte to a stream, returning the byte.")
  (write-doc y-or-n? "Shows yes or no prompt with given message and returns true if user answers yes.")
  (write-doc > "Returns true if first number is greater than the second.")
  (write-doc < "Returns true if first number is less than the second.")
  (write-doc >= "Returns true if first number is greater than or equal to the second.")
  (write-doc <= "Returns true if first number is less than or equal to the second.")
  (write-doc = "Returns true if two values are equal, which must be the same static type.")
  (write-doc + "Adds two numbers.")
  (write-doc / "Divides first number by second.")
  (write-doc - "Subtracts second number from first.")
  (write-doc * "Multiplies two numbers.")
  (write-doc == "Returns true if two values are equal, which can be different static types.")

  docs-written)
