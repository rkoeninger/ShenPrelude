# Shen Prelude API Docs

### `*` : `number → number → number`

Multiplies two numbers.

### `*doc-index*`

Association list of symbol names to doc strings.

### `*loaded*`

List of scripts that have been loaded.

### `*seed*`

The seed from which the next random value is derived.

### `*tc-stack*`

Stack of `tc` `+`/`-` values that have been pushed by `push-tc`.

### `+` : `number → number → number`

Adds two numbers.

### `-` : `number → number → number`

Subtracts second number from first.

### `/` : `number → number → number`

Divides first number by second.

### `<` : `number → number → boolean`

Returns true if first number is less than the second.

### `<!>` : `(list A) ⇨ (list A)`

Unconditional parser that always succeeds, consuming all of the input, yielding remaining input.

### `<-vector` : `(vector A) → number → A`

Gets element in vector at given 1-based index.

### `<=` : `number → number → boolean`

Returns true if first number is less than or equal to the second.

### `<e>` : `(list A) ⇨ (list B)`

Empty parser that always succeeds, consuming none of the input, yielding empty list of results.

### `=` : `A → A → boolean`

Returns true if two values are equal, which must be the same static type.

### `==` : `A → B → boolean`

Returns true if two values are equal, which can be different static types.

### `>` : `number → number → boolean`

Returns true if first number is greater than the second.

### `>=` : `number → number → boolean`

Returns true if first number is greater than or equal to the second.

### `@d`

Macro that allows declaration of dict literals. Requires even number of args, alternating key-value.

### `abs` : `number → number`

Returns the absolute value of given number.

### `absvector?` : `A → boolean`

Returns true if argument is an absvector.

### `adjoin` : `A → (list A) → (list A)`

Prepends value to head of list if not already in list.

### `all?` : `(A → boolean) → (list A) → boolean`

Returns true if predicate returns true for all elements in list.

### `and` : `boolean → boolean → boolean`

Returns true if both arguments are true; doesn't evaluate second argument if first is false.

### `any?` : `(A → boolean) → (list A) → boolean`

Returns true if predicate returns true for any elements in list.

### `append` : `(list A) → (list A) → (list A)`

Concat's two lists into one.

### `apply`

Applies function to list of arguments.

### `arity` : `A → number`

Returns arity of given function name or -1 if there is not such function.

### `assoc` : `A → (list (list A)) → (list A)`

Returns pair in association list with given key value.

### `binary-tree->list` : `symbol → (binary-tree A) → (list A)`

Collects values in binary tree into a list in given traversal.

### `boolean?` : `A → boolean`

Returns true if argument is a boolean.

### `bound?` : `symbol → boolean`

Returns true if symbol is bound to a value.

### `bubble-sort` : `(A → A → boolean) → number → number → (vector A) → (vector A)`

Bubble-sorts a slice of a vector.

### `but-first` : `(list A) → (list A)`

Returns list with all the same elements but the first.

### `but-last` : `(list A) → (list A)`

Returns list with all the same elements but the last.

### `cd` : `string → string`

Changes working directory.

### `ceil` : `number → number`

Rounds up to nearest integer.

### `close` : `(stream A) → (list B)`

Closes stream, returns empty list.

### `cn` : `string → string → string`

Concat's two strings into one.

### `compile` : `(A ⇨ B) → A → (A → B) → B`

Takes yacc grammar and 

### `complement` : `(A → boolean) → A → boolean`

Returns new version of function with inverse result of given function.

### `cons?` : `A → boolean`

Returns true if argument is a cons.

### `const` : `A → B → A`

Returns a function that ignores its argument and always returns the given value.

### `contains-substring?` : `string → string → boolean`

Returns true if substring is contained by string.

### `contains?` : `A → (list A) → boolean`

Returns true if any elements in list are equal to given key value.

### `cross-join` : `(list A) → (list B) → (list (A * B))`

Builds list of every combination of values in two lists as tuples.

### `cross-join-with` : `(A → B → C) → (list A) → (list B) → (list C)`

Builds list of every combination of values in two lists using given function.

### `curry` : `((A * B) → C) → A → B → C`

Converts function that takes tuple to function that takes arguments individually.

### `decrement` : `number → number`

Subtracts 1 from number.

### `defgeneric` : `symbol → T → symbol`

Declares a new generic method with the given type.

### `defkind`

Defines a specific implementation of `kind-of` with the given predicate and symbol.

### `defmethod` : `symbol → symbol → (A → B) → symbol`

Adds implementation for multi-method for kind.

### `defmulti` : `symbol → T → symbol`

Declares a new multi-method with given type.

### `defspecific` : `symbol → (A → boolean) → (A → B) → symbol`

Declares a case-specific implementation of a generic method. New implementations supercede old ones.

### `destroy` : `(A → B) → symbol`

Erases given function.

### `difference` : `(list A) → (list A) → (list A)`

Returns list of values that are in first list but not second.

### `distinct` : `(list A) → (list A)`

Returns copy of list with duplicates removed.

### `do` : `A → B → B`

Returns result of last expression, used to group side-effecting expressions.

### `doc` : `symbol → string`

Returns doc string for symbol, or 'n/a' if there isn't one.

### `drop` : `number → (list A) → (list A)`

Returns all but the first n elements in list.

### `drop-while` : `(A → boolean) → (list A) → (list A)`

Returns list remaining elements after dropping consecutive leading elements so long as given predicate returns true for them.

### `each` : `(list A) → (A → B) → unit`

For each item in list, applies function.

### `element?` : `A → (list A) → boolean`

Returns true if value is in list.

### `empty?` : `A → boolean`

Returns true if argument is an empty list.

### `enable-type-theory` : `symbol → boolean`

Takes + or - to turn default type system on or off.

### `error-like?` : `exception → string → boolean`

Determines if error has a message like the given string.

### `error-to-string` : `exception → string`

Returns exception's message.

### `explode` : `A → (list string)`

Converts value to string and returns list of unit strings.

### `external` : `symbol → (list symbol)`

Returns list of symbols exported from package.

### `fail` : `→ symbol`

Returns the failure symbol.

### `fail-if` : `(symbol → boolean) → symbol → symbol`

Returns the fail symbol if the function returns true for the given symbol, returns symbol argument otherwise.

### `fail?` : `A → boolean`

Returns true if argument is the fail symbol.

### `filter` : `(A → boolean) → (list A) → (list A)`

Returns copy of list with only elements for which predicate returns true.

### `first` : `(list A) → A`

Returns the first element of a list, error if emtpy.

### `fix` : `(A → A) → A → A`

Repeatedly applies function until it returns the same value it was given.

### `flat-map` : `(A → (list B)) → (list A) → (list B)`

Applies function to each value in list and concat's results into one long list.

### `flatten` : `(list (list A)) → (list A)`

Converts a list of lists into one long list.

### `floor` : `number → number`

Rounds down to nearest integer.

### `fold` : `symbol → (A → B → B) → B → (list A) → B`

Combines values in list in given order.

### `fold-left` : `(A → B → B) → B → (list A) → B`

Combines values in list from left to right using given function. Tail recursive.

### `fold-right` : `(A → B → B) → B → (list A) → B`

Combines values in list from right to left using given function. Not tail recursive.

### `for-each` : `(A → B) → (list A) → unit`

Applies function to each item in list.

### `freeze` : `A → (lazy A)`

Returns a function that will evaluate expression.

### `fst` : `(A * B) → A`

Returns the first value in a 2-tuple.

### `function` : `(A → B) → A → B`

Returns function associated with symbol.

### `function?` : `A → boolean`

Returns true if argument is a function.

### `gensym` : `symbol → symbol`

Returns unique variable based on given symbol.

### `get-time` : `symbol → number`

Returns the time, unix timestamp when passed 'unix, time since start when passed 'run.

### `hash` : `A → number → number`

Computes hash for given value, starting from given seed.

### `hdstr` : `string → string`

Returns first unit string in string.

### `hdv` : `(vector A) → A`

Returns first value in vector.

### `head` : `(list A) → A`

Returns first value in list.

### `here` : `(binary-tree A) → A`

Gets the value of a binary tree node.

### `id` : `A → A`

Returns the same value given.

### `if` : `boolean → A → A → A`

Evaluates condition, evaluates and returns second expression if true, third expression if false.

### `implementation` : `→ string`

Returns name of language implementation/platform.

### `include` : `(list symbol) → (list symbol)`

Makes datatypes visible to the type checker.

### `include-all-but` : `(list symbol) → (list symbol)`

Makes all datatypes except the given visible to the type checker.

### `indent-file` : `symbol → string → string → unit`

Reads file at In path and overrites file at Out path with lines properly indented.

### `index-of` : `string → string → number`

Finds 0-based index of first occurrence of substring in string, -1 if not found.

### `inferences` : `→ number`

Returns the number of type checking inferences that have been performed so far.

### `info` : `symbol → string`

Returns human readable string with type, doc string, source for symbol.

### `int?` : `number → boolean`

Checks if number is an integer.

### `integer?` : `A → boolean`

Returns true if value is a number and an integer.

### `internal` : `symbol → (list symbol)`

Gets the symbols internal to a package.

### `interpose` : `A → (list A) → (list A)`

Inserts value between each value in list.

### `intersection` : `(list A) → (list A) → (list A)`

Returns list containing only elements contained in both lists.

### `it` : `→ string`

Returns expression that contains the call to (it).

### `join-lines` : `symbol → (list string) → string`

Joins lines with either `lf` or `crlf` endings.

### `join-strings` : `string → (list string) → string`

Concatenates a list of strings interspersing a separator.

### `kill` : `→ A`

Terminates YACC parsing.

### `kind-of` : `A → symbol`

Returns a symbol identifying the type family of given value.

### `language` : `→ string`

Returns name of language this port is implemented in.

### `last` : `(list A) → A`

Returns the last element of a list, error if empty.

### `left` : `(binary-tree A) → (binary-tree A)`

Gets the left branch of a binary tree node.

### `length` : `(list A) → number`

Returns length of list.

### `limit` : `(vector A) → number`

Returns length of vector.

### `list->vector` : `(list A) → (vector A)`

Makes a new vector out of a list.

### `load` : `string → symbol`

Reads and evaluates code at path relative to `*home-directory*`.

### `loaded?` : `symbol → boolean`

Returns true if given module has been loaded.

### `lower-case` : `string → string`

Returns copy of string with all characters converted to lower-case.

### `lower-case-1` : `string → string`

Returns lower-case of given unit string.

### `map` : `(A → B) → (list A) → (list B)`

Applies function to each element in list, returning list of results.

### `map-both` : `(A → B) → (A * A) → (B * B)`

Uses given function to transform both values in a 2-tuple.

### `map-fst` : `(A → C) → (A * B) → (C * B)`

Uses given function to transform the first value in a 2-tuple.

### `map-snd` : `(B → C) → (A * B) → (A * C)`

Uses given function to transform the second value in a 2-tuple.

### `mapcan` : `(A → (list B)) → (list A) → (list B)`

Applies function to each element in list, concat'ing results into one long list.

### `max` : `(list number) → number`

Returns maximum number in list.

### `max-by` : `(A → number) → (list A) → A`

Returns value in list for which given function returns maximum value.

### `max-compare-by` : `(A → A → boolean) → (list A) → A`

Returns maximum value in list comparing using given function.

### `maxinferences` : `number → number`

Sets the maximum number of inferences the type checker will attempt.

### `maybe` : `boolean → A → (maybe A)`

Maybe.

### `maybe-map` : `(A → B) → (maybe A) → (maybe B)`

Apply function if something.

### `maybe?` : `A → boolean`

Maybe?

### `memo` : `(→ A) → (→ A)`

Memoizes a 0-parameter continuation.

### `mod` : `number → number → number`

Performs modulus operation.

### `n->string` : `number → string`

Returns unit string for character code point.

### `neg` : `number → number`

Returns negation of given number.

### `neg?` : `number → boolean`

Determines if number is negative.

### `next-random` : `→ number`

Returns the next random value based on the current value of `*seed*`.

### `next-random-between` : `number → number → number`

Returns the next random value within the given range.

### `next-random-boolean` : `→ boolean`

Returns the next random boolean based on the current value of `*seed*`.

### `nl` : `number → number`

Writes a number of new lines to the standard output stream.

### `node` : `A → (binary-tree A) → (binary-tree A) → (binary-tree A)`

Creates a binary tree node from a value, left branch and right branch.

### `none` : `→ (maybe A)`

Maybe nothing.

### `none?` : `A → boolean`

Maybe nothing?

### `not` : `boolean → boolean`

Takes true/false and returns false/true.

### `not=` : `A → A → boolean`

Equivalent to (not (= X Y)).

### `not==` : `A → B → boolean`

Equivalent to (not (== X Y)).

### `nth` : `number → (list A) → A`

Returns the element in a list at given 1-based index.

### `number?` : `A → boolean`

Returns true if argument is a number.

### `occurrences` : `A → B → number`

Returns the number of times a value appears in a tree.

### `occurs-check` : `symbol → boolean`

Turns prolog occurs checking on/off with +/-.

### `optimise` : `symbol → boolean`

Turns Shen -> KL optimisation on/off with +/-.

### `or` : `boolean → boolean → boolean`

Returns true if either argument is true; doesn't evaluate second argument if first is true.

### `or-else` : `A → (maybe A) → A`

Get the something or default value.

### `os` : `→ string`

Returns name of current running operating system.

### `package?` : `symbol → boolean`

Returns true if argument is the name of a defined package.

### `partition` : `number → (list A) → (list (list A))`

Splits list into list of sublists, each no longer than given length.

### `peek` : `(K A) → A`

Generic peek method. Returns next item from sequence without modifiying container. Raises error on empty.

### `pop` : `(K A) → A`

Generic pop method. Destructively removes next item from sequence. Raises error on empty.

### `pop-tc` : `→ symbol`

Pops `+`/`-` off of `*tc-stack*` and set `tc` to that mode.

### `port` : `→ string`

Returns the version of this port of Shen.

### `porters` : `→ string`

Returns the name(s) of the author(s) of this port of Shen.

### `pos` : `string → number → string`

Returns the unit string at the given 0-based index in a string.

### `pos?` : `number → boolean`

Determines if number is positive.

### `pr` : `string → (stream out) → string`

Writes string to output stream.

### `preclude` : `(list symbol) → (list symbol)`

Hides datatypes from the type checker.

### `preclude-all-but` : `(list symbol) → (list symbol)`

Hides all datatypes except the given from the type checker.

### `prefix?` : `string → string → boolean`

Checks if second argument starts with the first.

### `prepend` : `A → (list A) → (list A)`

Adds value to beginning of list.

### `print` : `A → A`

Writes value to standard output stream.

### `profile` : `(A → B) → A → B`

Prepares verion of function given by name to include performance profiling logging.

### `profile-results` : `(A → B) → ((A → B) * number)`

Gets the run time of running the given function.

### `protect` : `symbol → symbol`

Used by parser to identify code that should not be interpreted. Passes through argument.

### `ps` : `symbol → (list unit)`

Returns the compiled KLambda code for the given function.

### `push` : `(K A) → A → (K A)`

Generic push method. Adds item to mutable container.

### `push-tc` : `symbol → symbol`

Pushes current `+`/`-` onto `*tc-stack*` and sets `tc` to given mode.

### `queue` : `→ (queue A)`

Creates a new queue.

### `queue-empty?` : `(queue A) → boolean`

Returns true if given queue is empty.

### `queue-peek` : `(queue A) → A`

Returns the head value of mutable queue, raises error if empty.

### `queue-pop` : `(queue A) → A`

Pops value off of mutable queue, raises error if empty.

### `queue-push` : `(queue A) → A → (queue A)`

Pushes a value onto queue, returns queue.

### `queue-size` : `(queue A) → number`

Returns size of queue.

### `queue?` : `A → boolean`

Returns true if argument is a queue.

### `range` : `number → (list number)`

Returns list of numbers from 1 up to and including the given number.

### `read` : `(stream in) → unit`

Reads and parses an element of Shen code from given input stream.

### `read-byte` : `(stream in) → number`

Reads single byte from given input stream.

### `read-file` : `string → (list unit)`

Reads all elements of Shen code from given file relative to `*home-directory*`.

### `read-file-as-bytelist` : `string → (list number)`

Reads contents of file relative to `*home-directory*` as list of bytes.

### `read-file-as-string` : `string → string`

Reads contents of file relative to `*home-directory*` as string.

### `read-from-string` : `string → (list unit)`

Reads all elements of Shen code from given string.

### `release` : `→ string`

Returns version of language implementation/platform.

### `reload` : `symbol → symbol`

Loads script whether it has been loaded or not.

### `reload-typed` : `symbol → symbol`

Loads script with `(tc +)` whether it has been loaded or not.

### `reload-untyped` : `symbol → symbol`

Loads script with `(tc -)` whether it has been loaded or not.

### `remove` : `A → (list A) → (list A)`

Removes all occurances of value from list.

### `repeat` : `number → A → (list A)`

Builds list by repeating the same value N times.

### `repeatedly` : `number → (→ A) → (list A)`

Builds list by invoking the same function N times.

### `require` : `symbol → symbol`

Loads script if it has not been loaded.

### `require-typed` : `symbol → symbol`

Loads script with `(tc +)` if it has not been loaded.

### `require-untyped` : `symbol → symbol`

Loads script with `(tc -)` if it has not been loaded.

### `reverse` : `(list A) → (list A)`

Returns new list with same elements in reverse order.

### `reverse-string` : `string → string`

Returns string with same characters in reverse order.

### `right` : `(binary-tree A) → (binary-tree A)`

Gets the right branch of a binary tree node.

### `search-doc` : `string → (list symbol)`

Searches for functions with doc strings similar to search string.

### `separate` : `(A → boolean) → (list A) → ((list A) * (list A))`

Splits list into two separate lists based on whether predicate returns true or false.

### `set-doc` : `symbol → string → string`

Sets doc string for symbol.

### `set-once` : `symbol → A → A`

Sets global symbol to value only if global symbol is not already bound.

### `shuffle-list` : `(list A) → (list A)`

Randomizes elements in cons list, returning a new list.

### `shuffle-vector` : `(vector A) → (vector A)`

Randomizes elements in vector in place.

### `signum` : `number → number`

Returns -1 for negative number, 1 for positive, 0 for 0.

### `simple-error` : `string → A`

Raises exception with given error message.

### `size` : `A → number`

Generic size method.

### `skip?` : `A → boolean`

Returns true if argument is the skip symbol.

### `snd` : `(A * B) → B`

Returns the first value in a 2-tuple.

### `some` : `A → (maybe A)`

Maybe something.

### `some?` : `A → boolean`

Maybe something?

### `sort-list` : `(A → A → boolean) → (list A) → (list A)`

Sorts the elements of a list and returns a new list in sorted order.

### `sort-vector` : `(A → A → boolean) → (vector A) → (vector A)`

Sorts the elements of a vector in place.

### `spaces` : `number → string`

Returns a string of `N` spaces

### `specialise` : `symbol → symbol`

Sets function as having specialised type.

### `split-at` : `number → (list A) → ((list A) * (list A))`

Splits list into two sublists at given index.

### `split-lines` : `symbol → string → (list string)`

Splits a string into a list of lines, consider LF and CRLF line endings.

### `split-string` : `string → string → (list string)`

Splits a string into a list of substrings on separator. Retains empty strings.

### `spy` : `symbol → boolean`

Turns the type checker debugger on/off with +/-.

### `stack` : `→ (stack A)`

Creates a new mutable stack.

### `stack-empty?` : `(stack A) → boolean`

Returns true if given stack is empty.

### `stack-peek` : `(stack A) → A`

Returns the top value of mutable stack, raises error if empty.

### `stack-pop` : `(stack A) → A`

Pops value off of mutable stack, raises error if empty.

### `stack-push` : `(stack A) → A → (stack A)`

Pushes a value onto mutable stack, returns stack.

### `stack-size` : `(stack A) → number`

Returns size of mutable stack.

### `stack?` : `A → boolean`

Returns true if argument is a mutable stack.

### `step` : `symbol → boolean`

Turns debugging on/off with +/-.

### `sterror` : `→ (stream out)`

Returns standard error stream.

### `stinput` : `→ (stream in)`

Returns standard input stream.

### `stoutput` : `→ (stream out)`

Returns standard output stream.

### `str` : `A → string`

Converts value to a string.

### `string->bytes` : `string → (list number)`

Converts a string to a list of code points.

### `string->n` : `string → number`

Converts unit string to character code point.

### `string->symbol` : `string → symbol`

Returns a symbol named after string.

### `string-compare` : `string → string → number`

Returns -1 if first string comes first, 1 if it comes later, 0 if they are equal.

### `string-length` : `string → number`

Returns length of string.

### `string-length-onto` : `number → string → number`

Adds string length onto given amount and returns.

### `string?` : `A → boolean`

Returns true if argument is a string.

### `substring` : `number → number → string → string`

Extracts between starting and ending 0-based indicies.

### `substring-from` : `number → string → string`

Extracts substring from starting 0-based index.

### `substring-to` : `number → string → string`

Extracts substring up to 0-based index.

### `suffix` : `A → (list A) → (list A)`

Adds value to end of list.

### `suffix?` : `string → string → boolean`

Checks if second argument ends with the first.

### `sum` : `(list number) → number`

Adds all numbers in list, 0 for empty list.

### `symbol?` : `A → boolean`

Returns true if argument is a symbol.

### `systemf` : `symbol → symbol`

Declares function as a system function that cannot be overwritten.

### `tail` : `(list A) → (list A)`

Returns list containing all but the first element of a list.

### `take` : `number → (list A) → (list A)`

Returns first n elements in list.

### `take-onto` : `number → (list A) → (list A) → (list A)`

Copies first n elements from list onto other list.

### `take-while` : `(A → boolean) → (list A) → (list A)`

Returns list of consecutive leading elements so long as given predicate returns true for them.

### `take-while-onto` : `(A → boolean) → (list A) → (list A) → (list A)`

Copies elements from list onto other list so long as given predicate returns true for them.

### `tc` : `symbol → boolean`

Turns type checking on/off with +/-.

### `tc?` : `→ boolean`

Returns true if type checking is enabled, false otherwise.

### `thaw` : `(lazy A) → A`

Calls a zero-argument function, as created by freeze.

### `tlstr` : `string → string`

Returns string containing all but the first unit string of string.

### `tlv` : `(vector A) → (vector A)`

Returns a vector containing all but the first element of input vector.

### `track` : `symbol → symbol`

Sets function as being tracked by debugger.

### `trap-error` : `A → (exception → A) → A`

Evaluates first expression and if exception is raised, evaluates second argument and applies it to exception.

### `traverse` : `symbol → (A → B → B) → B → (binary-tree A) → B`

Folds values in binary tree in given traversal.

### `traverse-in-order` : `(A → B → B) → B → (binary-tree A) → B`

Folds values in binary tree in an in-order traversal.

### `traverse-level-order` : `(A → B → B) → B → (binary-tree A) → B`

Folds values in binary tree in a level-order traversal.

### `traverse-out-order` : `(A → B → B) → B → (binary-tree A) → B`

Folds values in binary tree in an out-order traversal.

### `traverse-post-order` : `(A → B → B) → B → (binary-tree A) → B`

Folds values in binary tree in a post-order traversal.

### `traverse-pre-order` : `(A → B → B) → B → (binary-tree A) → B`

Folds values in binary tree in a pre-order traversal.

### `trim` : `string → string`

Removes whitespace characters from beginning and end of string.

### `trim-end` : `string → string`

Removes whitespace characters from end of string.

### `trim-start` : `string → string`

Removes whitespace characters from beginning of string.

### `tuple?` : `A → boolean`

Returns true if argument is a tuple.

### `type-of` : `symbol → unit`

Returns type-signature of function or (fail).

### `uncurry` : `(A → B → C) → (A * B) → C`

Converts function that takes arguments individually to function that takes tuple.

### `undefmacro` : `symbol → symbol`

Unregisters macro by name.

### `unfold` : `(lazy (list A)) → (list A)`

Builds list by repeatedly calling the given function until it returns an empty list.

### `unfold-onto` : `(list A) → (lazy (list A)) → (list A)`

Repeatedly calls given function until it returns empty list, prepending results onto given list.

### `union` : `(list A) → (list A) → (list A)`

Returns list that contains all the elements in both given lists, excluding duplicates.

### `unprofile` : `(A → B) → A → B`

Restores original version of function before it was profiled.

### `unspecialise` : `symbol → symbol`

Resets type specialisation of function.

### `untrack` : `symbol → symbol`

Resets function as not being tracked by debugger.

### `unwrap` : `(maybe A) → A`

Get the something. Error if nothing.

### `upper-case` : `string → string`

Returns copy of string with all characters converted to upper-case.

### `upper-case-1` : `string → string`

Returns upper-case of given unit string.

### `variable?` : `A → boolean`

Returns true if symbol could be a variable.

### `vector` : `number → (vector A)`

Creates new vector of given length.

### `vector->` : `(vector A) → number → A → (vector A)`

Sets element in vector at given 1-based index.

### `vector->list` : `(vector A) → (list A)`

Makes a new list out of a vector.

### `vector-swap` : `(vector A) → number → number → (vector A)`

Swaps two elements in given vector at following indicies.

### `vector-update` : `(vector A) → number → (A → A) → (vector A)`

Transforms value at index by given function.

### `vector?` : `A → boolean`

Returns true if given value is a vector (not just an absvector).

### `version` : `→ string`

Returns version of Shen.

### `void` : `→ unit`

Returns an empty list as a unit value.

### `whitespace?` : `string → boolean`

Returns true if string is all whitespace.

### `write-byte` : `number → (stream out) → number`

Writes a byte to a stream, returning the byte.

### `write-file-as-string` : `string → string → unit`

Writes string as ASCII sequence to file at given path.

### `write-to-file` : `string → A → A`

Converts value to string and writes to file.

### `y-or-n?` : `string → boolean`

Shows yes or no prompt with given message and returns true if user answers yes.

### `zip` : `(list A) → (list B) → (list (A * B))`

Lines up two lists and combines each pair of values into tuple in resulting list.

### `zip-with` : `(A → B → C) → (list A) → (list B) → (list C)`

Lines up two lists and combines each pair of values into value in resulting list using given function.

