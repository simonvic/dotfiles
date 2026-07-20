; inherits: java

; extends

(record_declaration
  body: (class_body) @class.inner) @class.outer

(interface_declaration
  body: (interface_body) @class.inner) @class.outer
