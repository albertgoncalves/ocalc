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
    | '='           { ASSIGN }
    | '{'           { LC }
    | '}'           { RC }
    | ";"           { END }
    | "fn"          { FN }
    | '"'           { read_string (B.create 16) lexbuf }
    | '\n'          { Lexing.new_line lexbuf; token lexbuf }
    | eof | "eof"   { EOF }
    | ".." [^'\n']* | [' ' '\t']
                    { token lexbuf }
    | num as x      { NUM x }
    | var as x      { VAR x }
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
