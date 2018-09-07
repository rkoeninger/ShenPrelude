\\ TODO: emit the calls to set-doc instead of running them in macro

(set *doc-index* [])

(defmacro define-with-doc-macro
  [define Name doc Doc | Rest] ->
    (do
      (set-doc Name Doc)
      [define Name | Rest]))

(defmacro set-with-doc-macro
  [set Name doc Doc | Rest] ->
    (do
      (set-doc Name Doc)
      [set Name | Rest]))

(define doc
  Name -> (trap-error (get Name doc) (/. _ "n/a")))

(define set-doc
  Name Content ->
    (do
      (set *doc-index* [[Name Content] | (value *doc-index*)])
      (put Name doc Content)))

(define doc-prefix?
  "" _ -> true
  (@s Ch Ss) (@s Ch Ts) -> (doc-prefix? Ss Ts)
  _ _ -> false)

(define doc-matches?
  _ "" -> false
  S T -> true where (doc-prefix? S T)
  S (@s _ T) -> (doc-matches? S T))

(define find-doc-matches
  _ [] -> []
  "" _ -> []
  S [[Name Content] | Rest] ->
    [Name | (find-doc-matches S Rest)]
    where (or (doc-matches? S (str Name)) (doc-matches? S Content))
  S [_ | Rest] -> (find-doc-matches S Rest))

(define search-doc
  S -> (find-doc-matches S (value *doc-index*)))

(define info
  Name ->
    (make-string "~%type: ~A~%doc:  ~A~%src:  ~A~%"
      (let TypeSig (shen.get-type Name)
        (if (= shen.skip TypeSig)
          "n/a"
          TypeSig))
      (doc Name)
      (trap-error (ps Name) (/. _ "n/a"))))

(declare doc [symbol --> string])
(declare set-doc [symbol --> [string --> string]])
(declare search-doc [string --> [list symbol]])
(declare info [symbol --> string])

(do
  \\ require
  (set-doc *loaded* "List of scripts that have been loaded.")
  (set-doc reload "Loads script whether it has been loaded or not.")
  (set-doc reload-typed "Loads script with (tc +) whether it has been loaded or not.")
  (set-doc require "Loads script if it has not been loaded.")
  (set-doc require-typed "Loads script with (tc +) if it has not been loaded.")

  \\ docs
  (set-doc *doc-index* "Assoication list of symbol names to doc strings.")
  (set-doc doc "Returns doc string for symbol, or 'n/a' if there isn't one.")
  (set-doc set-doc "Sets doc string for symbol.")
  (set-doc search-doc "Searches for functions with doc strings similar to search string.")
  (set-doc info "Returns human readable string with type, doc string, source for symbol.")

  \\ kernel
  (set-doc absvector? "Returns true if argument is an absvector.")
  (set-doc adjoin "Prepends value to head of list if not already in list.")
  (set-doc and "Returns true if both arguments are true; doesn't evaluate second argument if first is false.")
  (set-doc app "Internal function used in output macro.")
  (set-doc append "Concat's two lists into one.")
  (set-doc arity "Returns arity of given function name or -1 if there is not such function.")
  (set-doc assoc "Returns pair in association list with given key value.")
  (set-doc boolean? "Returns true if argument is a boolean.")
  (set-doc bound? "Returns true if symbol is bound to a value.")
  (set-doc cd "Changes working directory.")
  (set-doc close "Closes stream, returns empty list.")
  (set-doc cn "Concat's two strings into one.")
  (set-doc compile "Takes yacc grammar and ")
  (set-doc cons? "Returns true if argument is a cons.")
  (set-doc destroy "Erases given function.")
  (set-doc difference "Returns list of values that are in first list but not second.")
  (set-doc do "Returns result of last expression, used to group side-effecting expressions.")
  (set-doc <e> "Empty parser that always succeeds, consuming none of the input, yielding empty list of results.")
  (set-doc <!> "Unconditional parser that always succeeds, consuming all of the input, yielding remaining input.")
  (set-doc element? "Returns true if value is in list.")
  (set-doc empty? "Returns true if argument is an empty list.")
  (set-doc enable-type-theory "Takes + or - to turn default type system on or off.")
  (set-doc external "Returns list of symbols exported from package.")
  (set-doc error-to-string "Returns exception's message.")
  (set-doc explode "Converts value to string and returns list of unit strings.")
  (set-doc fail "Returns the failure symbol.")
  (set-doc fail-if "Returns the fail symbol if the function returns true for the given symbol, returns symbol argument otherwise.")
  (set-doc fix "Repeatedly applies function until it returns the same value it was given.")
  (set-doc freeze "Returns a function that will evaluate expression.")
  (set-doc fst "Returns the first value in a 2-tuple.")
  (set-doc function "Returns function associated with symbol.")
  (set-doc gensym "Returns unique variable based on given symbol.")
  (set-doc <-vector "Gets element in vector at given 1-based index.")
  (set-doc vector-> "Sets element in vector at given 1-based index.")
  (set-doc vector "Creates new vector of given length.")
  (set-doc get-time "Returns the time, unix timestamp when passed 'unix, time since start when passed 'run.")
  (set-doc hash "Computes hash for given value, starting from given seed.")
  (set-doc head "Returns first value in list.")
  (set-doc hdv "Returns first value in vector.")
  (set-doc hdstr "Returns first unit string in string.")
  (set-doc if "Evaluates condition, evaluates and returns second expression if true, third expression if false.")
  (set-doc it "Returns expression that contains the call to (it).")
  (set-doc implementation "Returns name of language implementation/platform.")
  (set-doc include "Makes datatypes visible to the type checker.")
  (set-doc include-all-but "Makes all datatypes except the given visible to the type checker.")
  (set-doc inferences "Returns the number of type checking inferences that have been performed so far.")
  (set-doc integer? "Returns true if value is a number and an integer.")
  (set-doc internal "Gets the symbols internal to a package.")
  (set-doc intersection "Returns list containing only elements contained in both lists.")
  (set-doc kill "Terminates YACC parsing.")
  (set-doc language "Returns name of language this port is implemented in.")
  (set-doc length "Returns length of list.")
  (set-doc limit "Returns length of vector.")
  (set-doc load "Reads and evaluates code at path relative to *home-directory*.")
  (set-doc map "Applies function to each element in list, returning list of results.")
  (set-doc mapcan "Applies function to each element in list, concat'ing results into one long list.")
  (set-doc maxinferences "Sets the maximum number of inferences the type checker will attempt.")
  (set-doc n->string "Returns unit string for character code point.")
  (set-doc nl "Writes a number of new lines to the standard output stream.")
  (set-doc not "Takes true/false and returns false/true.")
  (set-doc nth "Returns the element in a list at given 1-based index.")
  (set-doc number? "Returns true if argument is a number.")
  (set-doc occurrences "Returns the number of times a value appears in a tree.")
  (set-doc occurs-check "Turns prolog occurs checking on/off with +/-.")
  (set-doc optimise "Turns Shen -> KL optimisation on/off with +/-.")
  (set-doc or "Returns true if either argument is true; doesn't evaluate second argument if first is true.")
  (set-doc os "Returns name of current running operating system.")
  (set-doc package? "Returns true if argument is the name of a defined package.")
  (set-doc port "Returns the version of this port of Shen.")
  (set-doc porters "Returns the name(s) of the author(s) of this port of Shen.")
  (set-doc pos "Returns the unit string at the given 0-based index in a string.")
  (set-doc pr "Writes string to output stream.")
  (set-doc print "Writes value to standard output stream.")
  (set-doc profile "Prepares verion of function given by name to include performance profiling logging.")
  (set-doc preclude "Hides datatypes from the type checker.")
  (set-doc preclude-all-but "Hides all datatypes except the given from the type checker.")
  (set-doc profile-results "Gets the run time of running the given function.")
  (set-doc protect "Used by parser to identify code that should not be interpreted. Passes through argument.")
  (set-doc prhush "Prints a string to an output stream if *hush* is false.")
  (set-doc ps "Returns the compiled KLambda code for the given function.")
  (set-doc read "Reads and parses an element of Shen code from given input stream.")
  (set-doc read-byte "Reads single byte from given input stream.")
  (set-doc read-file-as-bytelist "Reads contents of file relative to *home-directory* as list of bytes.")
  (set-doc read-file-as-string "Reads contents of file relative to *home-directory* as string.")
  (set-doc read-file "Reads all elements of Shen code from given file relative to *home-directory*.")
  (set-doc read-from-string "Reads all elements of Shen code from given string.")
  (set-doc release "Returns version of language implementation/platform.")
  (set-doc remove "Removes all occurances of value from list.")
  (set-doc reverse "Returns new list with same elements in reverse order.")
  (set-doc simple-error "Raises exception with given error message.")
  (set-doc snd "Returns the first value in a 2-tuple.")
  (set-doc specialise "Sets function as having specialised type.")
  (set-doc spy "Turns the type checker debugger on/off with +/-.")
  (set-doc step "Turns debugging on/off with +/-.")
  (set-doc stinput "Returns standard input stream.")
  (set-doc sterror "Returns standard error stream.")
  (set-doc stoutput "Returns standard output stream.")
  (set-doc string? "Returns true if argument is a string.")
  (set-doc str "Converts value to a string.")
  (set-doc string->n "Converts unit string to character code point.")
  (set-doc string->symbol "Returns a symbol named after string.")
  (set-doc sum "Adds all numbers in list, 0 for empty list.")
  (set-doc symbol? "Returns true if argument is a symbol.")
  (set-doc systemf "Declares function as a system function that cannot be overwritten.")
  (set-doc tail "Returns list containing all but the first element of a list.")
  (set-doc tlstr "Returns string containing all but the first unit string of string.")
  (set-doc tlv "Returns a vector containing all but the first element of input vector.")
  (set-doc tc "Turns type checking on/off with +/-.")
  (set-doc tc? "Returns true if type checking is enabled, false otherwise.")
  (set-doc thaw "Calls a zero-argument function, as created by freeze.")
  (set-doc track "Sets function as being tracked by debugger.")
  (set-doc trap-error "Evaluates first expression and if exception is raised, evaluates second argument and applies it to exception.")
  (set-doc tuple? "Returns true if argument is a tuple.")
  (set-doc undefmacro "Unregisters macro by name.")
  (set-doc union "Returns list that contains all the elements in both given lists, excluding duplicates.")
  (set-doc unprofile "Restores original version of function before it was profiled.")
  (set-doc untrack "Resets function as not being tracked by debugger.")
  (set-doc unspecialise "Resets type specialisation of function.")
  (set-doc variable? "Returns true if symbol could be a variable.")
  (set-doc vector? "Returns true if given value is a vector (not just an absvector).")
  (set-doc version "Returns version of Shen.")
  (set-doc write-to-file "Converts value to string and writes to file.")
  (set-doc write-byte "Writes a byte to a stream, returning the byte.")
  (set-doc y-or-n? "Shows yes or no prompt with given message and returns true if user answers yes.")
  (set-doc > "Returns true if first number is greater than the second.")
  (set-doc < "Returns true if first number is less than the second.")
  (set-doc >= "Returns true if first number is greater than or equal to the second.")
  (set-doc <= "Returns true if first number is less than or equal to the second.")
  (set-doc = "Returns true if two values are equal, which must be the same static type.")
  (set-doc + "Adds two numbers.")
  (set-doc / "Divides first number by second.")
  (set-doc - "Subtracts second number from first.")
  (set-doc * "Multiplies two numbers.")
  (set-doc == "Returns true if two values are equal, which can be different static types.")

  docs-written)