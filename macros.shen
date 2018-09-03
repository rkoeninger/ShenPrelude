(defmacro function-syntax-macro
  S -> [function (intern (substring-from 2 (str S)))]
    where (and (symbol? S) (prefix? "#'" (str S))))

(defmacro value-syntax-macro
  S -> [value (intern (substring-from 2 (str S)))]
    where (and (symbol? S) (prefix? "&'" (str S))))
