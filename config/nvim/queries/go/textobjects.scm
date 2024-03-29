; extends

; map values
(
 (keyed_element
   (literal_element)
   (literal_element) @literal_value.inner) @_start
 . ","? @_end
 (#make-range! "literal_value.outer" @_start @_end)
)

; slice values

(literal_value
  "," @_start .
  (literal_element) @literal_value.inner
  (#make-range! "literal_value.outer" @_start @literal_value.inner))

(literal_value
  . (literal_element) @literal_value.inner
  . ","? @_end
  (#make-range! "literal_value.outer" @literal_value.inner @_end))

; right side of expression

right: (expression_list) @value.inner @value.outer
