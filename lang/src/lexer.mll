{
    module B = Buffer
    open Parser
    exception Eof
    exception Error
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let id = alpha (alpha|digit)*
let num = digit+

rule token = parse
    | [' ' '\t']            { token lexbuf }
    | '\n'                  { Lexing.new_line lexbuf; EOL }
    | '='                   { ASSIGN }
    | '"'                   { read_string (B.create 16) lexbuf }
    | num as x              { NUM x }
    | id as x               { ID x }
    | eof                   { raise Eof }
    | _                     { raise Error }

and read_string buf = parse
    | '\\' '\\'             { B.add_char buf '\\'; read_string buf lexbuf }
    | '\\' 'n'              { B.add_char buf '\n'; read_string buf lexbuf }
    | '\\' 'r'              { B.add_char buf '\r'; read_string buf lexbuf }
    | '\\' 't'              { B.add_char buf '\t'; read_string buf lexbuf }
    | '\\' '"'              { B.add_char buf '"'; read_string buf lexbuf }
    | [^ '"' '\\']+ as x    { B.add_string buf x; read_string buf lexbuf }
    | '"'                   { STR (B.contents buf) }
    | _                     { raise Error }
