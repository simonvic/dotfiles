; inherits: java

; extends

(string_literal
  "\"\"\""
  _+ @injection.content
  (#set! injection.language "textblock")
  "\"\"\"")

(method_invocation
  name: (_) @_name
  (#any-of? @_name "visit" "visitExpression")
  arguments: (argument_list
    (string_literal
      "\"\"\""
      _+ @injection.content
      (#set! injection.language "giovi")
      "\"\"\"")))
