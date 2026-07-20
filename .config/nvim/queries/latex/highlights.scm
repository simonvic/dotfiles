; inherits: latex

; extends

((generic_command
  command: (command_name) @_name
  arg: (curly_group
    (_) @markup.underline))
  (#any-of? @_name "\\underline"))

((generic_command
  command: (command_name) @_name
  arg: (curly_group
    (_) @markup.raw))
  (#any-of? @_name "\\texttt"))

((generic_command
  command: (command_name) @_name
  arg: (curly_group
    (_) @markup.italic))
  (#any-of? @_name "\\mathcal"))

((generic_command
  command: (command_name) @_name
  arg: (curly_group
    (_) @markup.strong))
  (#any-of? @_name "\\mathbb"))

((text) @none
  (#set! priority 90))
