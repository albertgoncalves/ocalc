{
    module B = Buffer
    open Parser
    exception Error
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let var = alpha (alpha|digit)*
let num = digit+

rule token = parse
    | '\n'          { Lexing.new_line lexbuf; token lexbuf }
    | ".." [^'\n']* | [' ' '\t']
                    { token lexbuf }
    | '='           { ASSIGN }
    | '"'           { read_string (B.create 16) lexbuf }
    | "fn"          { FN }
    | '{'           { LC }
    | '}'           { RC }
    | num as x      { NUM x }
    | var as x      { VAR x }
    | eof           { EOF }
    | _             { raise Error }

and read_string buf = parse
    | '\\' '\\'     { B.add_char buf '\\'; read_string buf lexbuf }
    | '\\' 'n'      { B.add_char buf '\n'; read_string buf lexbuf }
    | '\\' 'r'      { B.add_char buf '\r'; read_string buf lexbuf }
    | '\\' 't'      { B.add_char buf '\t'; read_string buf lexbuf }
    | '\\' '"'      { B.add_char buf '"'; read_string buf lexbuf }
    | [^ '"' '\\']+ as x
                    { B.add_string buf x; read_string buf lexbuf }
    | '"'           { STR (B.contents buf) }
    | _             { raise Error }
