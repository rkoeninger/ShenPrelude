# Shen Prelude API Docs

### `sort-list` : `(A → (A → boolean)) → ((list A) → (list A))`

Sorts the elements of a list and returns a new list in sorted order.

### `sort-vector` : `(A → (A → boolean)) → ((vector A) → (vector A))`

Sorts the elements of a vector in place.

### `merge-sort` : `(A → (A → boolean)) → (number → (number → ((vector A) → (vector A))))`

Merge-sorts a slice of a vector.

### `list->vector` : `(list A) → (vector A)`

Makes a new vector out of a list.

### `vector->list` : `(vector A) → (list A)`

Makes a new list out of a vector.

### `interpose` : `A → ((list A) → (list A))`

Inserts value between each value in list.

### `cross-join` : `(list A) → ((list B) → (list (A * B)))`

Builds list of every combination of values in two lists as tuples.

### `cross-join-with` : `(A → (B → C)) → ((list A) → ((list B) → (list C)))`

Builds list of every combination of values in two lists using given function.

### `zip` : `(list A) → ((list B) → (list (A * B)))`

Lines up two lists and combines each pair of values into tuple in resulting list.

### `zip-with` : `(A → (B → C)) → ((list A) → ((list B) → (list C)))`

Lines up two lists and combines each pair of values into value in resulting list using given function.

### `flat-map` : `(A → (list B)) → ((list A) → (list B))`

Applies function to each value in list and concat's results into one long list.

### `flatten` : `(list (list A)) → (list A)`

Converts a list of lists into one long list.

### `max` : `(list number) → number`

Returns maximum number in list.

### `max-by` : `(A → number) → ((list A) → A)`

Returns value in list for which given function returns maximum value.

### `max-compare-by` : `(A → (A → boolean)) → ((list A) → A)`

Returns maximum value in list comparing using given function.

### `range` : `number → (list number)`

Returns list of numbers from 1 up to and including the given number.

### `unfold` : `(lazy (list A)) → (list A)`

Builds list by repeatedly calling the given function until it returns an empty list.

### `unfold-onto` : `(list A) → ((lazy (list A)) → (list A))`

Repeatedly calls given function until it returns empty list, prepending results onto given list.

### `repeatedly` : `number → ((→ A) → (list A))`

Builds list by invoking the same function N times.

### `repeat` : `number → (A → (list A))`

Builds list by repeating the same value N times.

### `distinct` : `(list A) → (list A)`

Returns copy of list with duplicates removed.

### `contains?` : `A → ((list A) → boolean)`

Returns true if any elements in list are equal to given key value.

### `separate` : `(A → boolean) → ((list A) → ((list A) * (list A)))`

Splits list into two separate lists based on whether predicate returns true or false.

### `fold-right` : `(B → (A → A)) → (A → ((list B) → A))`

Combines values in list from right to left using given function.

### `fold-left` : `(A → (B → A)) → (A → ((list B) → A))`

Combines values in list from left to right using given function.

### `filter` : `(A → boolean) → ((list A) → (list A))`

Returns copy of list with only elements for which predicate returns true.

### `suffix` : `A → ((list A) → (list A))`

Adds value to end of list.

### `prepend` : `A → ((list A) → (list A))`

Adds value to beginning of list.

### `partition` : `number → ((list A) → (list (list A)))`

Splits list into list of sublists, each no longer than given length.

### `split-at` : `number → ((list A) → ((list A) * (list A)))`

Splits list into two sublists at given index.

### `drop-while` : `(A → boolean) → ((list A) → (list A))`

Returns list remaining elements after dropping consecutive leading elements so long as given predicate returns true for them.

### `drop` : `number → ((list A) → (list A))`

Returns all but the first n elements in list.

### `take-while` : `(A → boolean) → ((list A) → (list A))`

Returns list of consecutive leading elements so long as given predicate returns true for them.

### `take-while-onto` : `(A → boolean) → ((list A) → ((list A) → (list A)))`

Copies elements from list onto other list so long as given predicate returns true for them.

### `take` : `number → ((list A) → (list A))`

Returns first n elements in list.

### `take-onto` : `number → ((list A) → ((list A) → (list A)))`

Copies first n elements from list onto other list.

### `all?` : `(A → boolean) → ((list A) → boolean)`

Returns true if predicate returns true for all elements in list.

### `any?` : `(A → boolean) → ((list A) → boolean)`

Returns true if predicate returns true for any elements in list.

### `complement` : `(A → boolean) → (A → boolean)`

Returns new version of function with inverse result of given function.

### `uncurry` : `(A → (B → C)) → ((A * B) → C)`

Converts function that takes arguments individually to function that takes tuple.

### `curry` : `((A * B) → C) → (A → (B → C))`

Converts function that takes tuple to function that takes arguments individually.

### `function?` : `A → boolean`

Returns true if argument is a function.

### `map-both` : `(A → B) → ((A * A) → (B * B))`

Uses given function to transform both values in a 2-tuple.

### `map-snd` : `(B → C) → ((A * B) → (A * C))`

Uses given function to transform the second value in a 2-tuple.

### `map-fst` : `(A → C) → ((A * B) → (C * B))`

Uses given function to transform the first value in a 2-tuple.

### `shuffle-list` : `(list A) → (list A)`

Randomizes elements in cons list, returning a new list.

### `shuffle-vector` : `(vector A) → (vector A)`

Randomizes elements in vector in place.

### `vector-swap` : `(vector A) → number → number → (vector A)`

Swaps two elements in given vector at following indicies.

### `next-random-between` : `number → number → number`

Returns the next random value within the given range.

### `next-random` : `→ number`

Returns the next random value based on the current value of *seed*.

### `upper-case` : `string → string`

Returns copy of string with all characters converted to upper-case.

### `lower-case` : `string → string`

Returns copy of string with all characters converted to lower-case.

### `upper-case-1` : `string → string`

Returns upper-case of given unit string.

### `lower-case-1` : `string → string`

Returns lower-case of given unit string.

### `string-length` : `string → number`

Returns length of string.

### `string-length-onto` : `number → (string → number)`

Adds string length onto given amount and returns.

### `substring` : `number → (number → (string → string))`

Extracts between starting and ending 0-based indicies.

### `substring-to` : `number → (string → string)`

Extracts substring up to 0-based index.

### `substring-from` : `number → (string → string)`

Extracts substring from starting 0-based index.

### `suffix?` : `string → (string → boolean)`

Checks if second argument ends with the first.

### `prefix?` : `string → (string → boolean)`

Checks if second argument starts with the first.

### `join-strings` : `string → ((list string) → string)`

Concatenates a list of strings interspersing a separator string.

### `==` : `A → (B → boolean)`

Returns true if two values are equal, which can be different static types.

### `*` : `number → (number → number)`

Multiplies two numbers.

### `-` : `number → (number → number)`

Subtracts second number from first.

### `/` : `number → (number → number)`

Divides first number by second.

### `+` : `number → (number → number)`

Adds two numbers.

### `=` : `A → (A → boolean)`

Returns true if two values are equal, which must be the same static type.

### `<=` : `number → (number → boolean)`

Returns true if first number is less than or equal to the second.

### `>=` : `number → (number → boolean)`

Returns true if first number is greater than or equal to the second.

### `<` : `number → (number → boolean)`

Returns true if first number is less than the second.

### `>` : `number → (number → boolean)`

Returns true if first number is greater than the second.

### `y-or-n?` : `string → boolean`

Shows yes or no prompt with given message and returns true if user answers yes.

### `write-byte` : `number → ((stream out) → number)`

Writes a byte to a stream, returning the byte.

### `write-to-file` : `string → (A → A)`

Converts value to string and writes to file.

### `version` : `→ string`

Returns version of Shen.

### `vector?` : `A → boolean`

Returns true if given value is a vector (not just an absvector).

### `variable?` : `A → boolean`

Returns true if symbol could be a variable.

### `unspecialise` : `symbol → symbol`

Resets type specialisation of function.

### `untrack` : `symbol → symbol`

Resets function as not being tracked by debugger.

### `unprofile` : `(A → B) → (A → B)`

Restores original version of function before it was profiled.

### `union` : `(list A) → ((list A) → (list A))`

Returns list that contains all the elements in both given lists, excluding duplicates.

### `undefmacro` : `symbol → symbol`

Unregisters macro by name.

### `tuple?` : `A → boolean`

Returns true if argument is a tuple.

### `trap-error` : `A → ((exception → A) → A)`

Evaluates first expression and if exception is raised, evaluates second argument and applies it to exception.

### `track` : `symbol → symbol`

Sets function as being tracked by debugger.

### `thaw` : `(lazy A) → A`

Calls a zero-argument function, as created by freeze.

### `tc?` : `→ boolean`

Returns true if type checking is enabled, false otherwise.

### `tc` : `symbol → boolean`

Turns type checking on/off with +/-.

### `tlv` : `(vector A) → (vector A)`

Returns a vector containing all but the first element of input vector.

### `tlstr` : `string → string`

Returns string containing all but the first unit string of string.

### `tail` : `(list A) → (list A)`

Returns list containing all but the first element of a list.

### `systemf` : `symbol → symbol`

Declares function as a system function that cannot be overwritten.

### `symbol?` : `A → boolean`

Returns true if argument is a symbol.

### `sum` : `(list number) → number`

Adds all numbers in list, 0 for empty list.

### `string->symbol` : `string → symbol`

Returns a symbol named after string.

### `string->n` : `string → number`

Converts unit string to character code point.

### `str` : `A → string`

Converts value to a string.

### `string?` : `A → boolean`

Returns true if argument is a string.

### `stoutput` : `→ (stream out)`

Returns standard output stream.

### `sterror` : `→ (stream out)`

Returns standard error stream.

### `stinput` : `→ (stream in)`

Returns standard input stream.

### `step` : `symbol → boolean`

Turns debugging on/off with +/-.

### `spy` : `symbol → boolean`

Turns the type checker debugger on/off with +/-.

### `specialise` : `symbol → symbol`

Sets function as having specialised type.

### `snd` : `(A * B) → B`

Returns the first value in a 2-tuple.

### `simple-error` : `string → A`

Raises exception with given error message.

### `reverse` : `(list A) → (list A)`

Returns new list with same elements in reverse order.

### `remove` : `A → ((list A) → (list A))`

Removes all occurances of value from list.

### `release` : `→ string`

Returns version of language implementation/platform.

### `read-from-string` : `string → (list unit)`

Reads all elements of Shen code from given string.

### `read-file` : `string → (list unit)`

Reads all elements of Shen code from given file relative to *home-directory*.

### `read-file-as-string` : `string → string`

Reads contents of file relative to *home-directory* as string.

### `read-file-as-bytelist` : `string → (list number)`

Reads contents of file relative to *home-directory* as list of bytes.

### `read-byte` : `(stream in) → number`

Reads single byte from given input stream.

### `read` : `(stream in) → unit`

Reads and parses an element of Shen code from given input stream.

### `ps` : `symbol → (list unit)`

Returns the compiled KLambda code for the given function.

### `prhush`

Prints a string to an output stream if *hush* is false.

### `protect` : `symbol → symbol`

Used by parser to identify code that should not be interpreted. Passes through argument.

### `profile-results` : `(A → B) → ((A → B) * number)`

Gets the run time of running the given function.

### `preclude-all-but` : `(list symbol) → (list symbol)`

Hides all datatypes except the given from the type checker.

### `preclude` : `(list symbol) → (list symbol)`

Hides datatypes from the type checker.

### `profile` : `(A → B) → (A → B)`

Prepares verion of function given by name to include performance profiling logging.

### `print` : `A → A`

Writes value to standard output stream.

### `pr` : `string → ((stream out) → string)`

Writes string to output stream.

### `pos` : `string → (number → string)`

Returns the unit string at the given 0-based index in a string.

### `porters` : `→ string`

Returns the name(s) of the author(s) of this port of Shen.

### `port` : `→ string`

Returns the version of this port of Shen.

### `package?` : `symbol → boolean`

Returns true if argument is the name of a defined package.

### `os` : `→ string`

Returns name of current running operating system.

### `or` : `boolean → (boolean → boolean)`

Returns true if either argument is true; doesn't evaluate second argument if first is true.

### `optimise` : `symbol → boolean`

Turns Shen -> KL optimisation on/off with +/-.

### `occurs-check` : `symbol → boolean`

Turns prolog occurs checking on/off with +/-.

### `occurrences` : `A → (B → number)`

Returns the number of times a value appears in a tree.

### `number?` : `A → boolean`

Returns true if argument is a number.

### `nth` : `number → ((list A) → A)`

Returns the element in a list at given 1-based index.

### `not` : `boolean → boolean`

Takes true/false and returns false/true.

### `nl` : `number → number`

Writes a number of new lines to the standard output stream.

### `n->string` : `number → string`

Returns unit string for character code point.

### `maxinferences` : `number → number`

Sets the maximum number of inferences the type checker will attempt.

### `mapcan` : `(A → (list B)) → ((list A) → (list B))`

Applies function to each element in list, concat'ing results into one long list.

### `map` : `(A → B) → ((list A) → (list B))`

Applies function to each element in list, returning list of results.

### `load` : `string → symbol`

Reads and evaluates code at path relative to *home-directory*.

### `limit` : `(vector A) → number`

Returns length of vector.

### `length` : `(list A) → number`

Returns length of list.

### `language` : `→ string`

Returns name of language this port is implemented in.

### `kill` : `→ A`

Terminates YACC parsing.

### `intersection` : `(list A) → ((list A) → (list A))`

Returns list containing only elements contained in both lists.

### `internal` : `symbol → (list symbol)`

Gets the symbols internal to a package.

### `integer?` : `A → boolean`

Returns true if value is a number and an integer.

### `inferences` : `→ number`

Returns the number of type checking inferences that have been performed so far.

### `include-all-but` : `(list symbol) → (list symbol)`

Makes all datatypes except the given visible to the type checker.

### `include` : `(list symbol) → (list symbol)`

Makes datatypes visible to the type checker.

### `implementation` : `→ string`

Returns name of language implementation/platform.

### `it` : `→ string`

Returns expression that contains the call to (it).

### `if` : `boolean → (A → (A → A))`

Evaluates condition, evaluates and returns second expression if true, third expression if false.

### `hdstr` : `string → string`

Returns first unit string in string.

### `hdv` : `(vector A) → A`

Returns first value in vector.

### `head` : `(list A) → A`

Returns first value in list.

### `hash` : `A → (number → number)`

Computes hash for given value, starting from given seed.

### `get-time` : `symbol → number`

Returns the time, unix timestamp when passed 'unix, time since start when passed 'run.

### `vector` : `number → (vector A)`

Creates new vector of given length.

### `vector->` : `(vector A) → (number → (A → (vector A)))`

Sets element in vector at given 1-based index.

### `<-vector` : `(vector A) → (number → A)`

Gets element in vector at given 1-based index.

### `gensym` : `symbol → symbol`

Returns unique variable based on given symbol.

### `function` : `(A → B) → (A → B)`

Returns function associated with symbol.

### `fst` : `(A * B) → A`

Returns the first value in a 2-tuple.

### `freeze` : `A → (lazy A)`

Returns a function that will evaluate expression.

### `fix` : `(A → A) → (A → A)`

Repeatedly applies function until it returns the same value it was given.

### `fail-if` : `(symbol → boolean) → (symbol → symbol)`

Returns the fail symbol if the function returns true for the given symbol, returns symbol argument otherwise.

### `fail` : `→ symbol`

Returns the failure symbol.

### `explode` : `A → (list string)`

Converts value to string and returns list of unit strings.

### `error-to-string` : `exception → string`

Returns exception's message.

### `external` : `symbol → (list symbol)`

Returns list of symbols exported from package.

### `enable-type-theory` : `symbol → boolean`

Takes + or - to turn default type system on or off.

### `empty?` : `A → boolean`

Returns true if argument is an empty list.

### `element?` : `A → ((list A) → boolean)`

Returns true if value is in list.

### `<!>` : `(list A) shen.==> (list A)`

Unconditional parser that always succeeds, consuming all of the input, yielding remaining input.

### `<e>` : `(list A) shen.==> (list B)`

Empty parser that always succeeds, consuming none of the input, yielding empty list of results.

### `do` : `A → (B → B)`

Returns result of last expression, used to group side-effecting expressions.

### `difference` : `(list A) → ((list A) → (list A))`

Returns list of values that are in first list but not second.

### `destroy` : `(A → B) → symbol`

Erases given function.

### `cons?` : `A → boolean`

Returns true if argument is a cons.

### `compile` : `(A shen.==> B) → (A → ((A → B) → B))`

Takes yacc grammar and 

### `cn` : `string → (string → string)`

Concat's two strings into one.

### `close` : `(stream A) → (list B)`

Closes stream, returns empty list.

### `cd` : `string → string`

Changes working directory.

### `bound?` : `symbol → boolean`

Returns true if symbol is bound to a value.

### `boolean?` : `A → boolean`

Returns true if argument is a boolean.

### `assoc` : `A → ((list (list A)) → (list A))`

Returns pair in association list with given key value.

### `arity` : `A → number`

Returns arity of given function name or -1 if there is not such function.

### `append` : `(list A) → ((list A) → (list A))`

Concat's two lists into one.

### `app`

Internal function used in output macro.

### `and` : `boolean → (boolean → boolean)`

Returns true if both arguments are true; doesn't evaluate second argument if first is false.

### `adjoin` : `A → ((list A) → (list A))`

Prepends value to head of list if not already in list.

### `absvector?` : `A → boolean`

Returns true if argument is an absvector.

### `info` : `symbol → string`

Returns human readable string with type, doc string, source for symbol.

### `fail?` : `A → boolean`

Returns true if argument is the (fail) symbol.

### `not=` : `A → B → boolean`

Equivalent to (not (= X Y)).

### `type-of` : `symbol → unit`

Returns type-signature of function or (fail).

### `search-doc` : `string → (list symbol)`

Searches for functions with doc strings similar to search string.

### `set-doc` : `symbol → (string → string)`

Sets doc string for symbol.

### `doc` : `symbol → string`

Returns doc string for symbol, or 'n/a' if there isn't one.

### `*doc-index*`

Association list of symbol names to doc strings.

### `require-typed` : `symbol → symbol`

Loads script with (tc +) if it has not been loaded.

### `require` : `symbol → symbol`

Loads script if it has not been loaded.

### `reload-typed` : `symbol → symbol`

Loads script with (tc +) whether it has been loaded or not.

### `reload` : `symbol → symbol`

Loads script whether it has been loaded or not.

### `*loaded*`

List of scripts that have been loaded.

