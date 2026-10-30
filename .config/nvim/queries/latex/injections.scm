; inherits: latex

; extends

(minted_environment
  begin: (_
    language: (_
      text: (_) @_language
      (#match? @_language ".*(giovi.py:GioviLexer|giovilexer)")))
  code: _ @injection.content
  (#set! injection.language "giovi"))

(minted_environment
  begin: (_
    language: (_
      text: (_) @_language
      (#eq? @_language "antlr")))
  code: _ @injection.content
  (#set! injection.language "antlr4"))
