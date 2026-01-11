; Comments
(comment) @comment
(block_comment) @comment

; Strings
(string_literal) @string
(escape_sequence) @string.escape

; Numbers
(integer) @number
(decimal_integer) @number
(hex_integer) @number

; Header keywords
"model" @keyword
"version" @keyword
"include" @keyword
"import" @keyword
"without" @keyword

; Definition keywords
"data" @keyword
"struct" @keyword
"contract" @keyword
"service" @keyword
"enum" @keyword
"choice" @keyword
"adt" @keyword
"foreign" @keyword
"ns" @keyword
"root" @keyword

; Member keywords
"derived" @keyword
"was" @keyword
"def" @keyword
"is" @keyword
"with" @keyword

; Method markers
"in" @keyword
"out" @keyword
"err" @keyword

; Built-in types
(builtin_type) @type.builtin

; Operators
"+" @operator
"-" @operator
"^" @operator
"=" @operator
":" @punctuation.delimiter

; Punctuation
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"(" @punctuation.bracket
")" @punctuation.bracket
"," @punctuation.delimiter
"." @punctuation.delimiter
"*" @operator

; Type definitions
(data_def
  name: (identifier) @type.definition)

(adt_def
  name: (identifier) @type.definition)

(enum_def
  name: (identifier) @type.definition)

(contract_def
  name: (identifier) @type.definition)

(foreign_def
  name: (identifier) @type.definition)

(service_def
  name: (identifier) @type.definition)

(namespace_def
  name: (identifier) @namespace)

; Enum members
(enum_member
  name: (identifier) @constant)

; Method definitions
(method_def
  name: (identifier) @function)

; Field definitions
(field_def
  name: (identifier) @property)

; Type references
(scoped_identifier) @type
(scoped_identifier
  (identifier) @type)

; Generic type names
(generic_type
  name: (scoped_identifier) @type)
(generic_type
  name: (builtin_type) @type.builtin)

; Foreign mapping targets
(foreign_mapping
  target: (identifier) @variable)

; Model name
(model_decl
  (scoped_identifier) @namespace)

; Derivation identifiers
(derived
  (identifier) @attribute)

(was
  (type_ref) @type)
