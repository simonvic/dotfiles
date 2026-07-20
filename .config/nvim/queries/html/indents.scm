; inherits: html

; extends

(comment) @indent.auto

(element
  (start_tag
    (tag_name) @_tagname
    (#eq? @_tagname "html"))) @indent.dedent

(element
  (start_tag
    (tag_name) @_pre
    (#eq? @_pre "pre"))
  (text) @indent.zero)

(element
  (start_tag
    (tag_name) @_pre
    (#eq? @_pre "pre"))
  (element
    (start_tag
      (tag_name) @_code
      (#eq? @_code "code"))
    _+ @indent.auto))
