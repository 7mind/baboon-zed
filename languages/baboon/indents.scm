; Definitions that create indented blocks
(data_def) @indent
(adt_def) @indent
(enum_def) @indent
(contract_def) @indent
(foreign_def) @indent
(service_def) @indent
(namespace_def) @indent
(method_def) @indent
(method_inline_def) @indent

; Closing braces outdent
"}" @outdent
")" @outdent
"]" @outdent
