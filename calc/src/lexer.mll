{
    open Parser
    exception Eof
    exception Error
}

let digit = ['0'-'9']
let float = digit* '.'? digit+ | digit+ '.'? digit*

rule token = parse
    | [' ' '\t']    { token lexbuf }
    | '\n'          { Lexing.new_line lexbuf; EOL }
    | float as x    { FLOAT (float_of_string x) }
    | "**"          { POW }
    | "sq"          { SQRT }
    | '+'           { ADD }
    | '-'           { SUB }
    | '*'           { MUL }
    | '/'           { DIV }
    | '('           { LPAREN }
    | ')'           { RPAREN }
    | eof           { raise Eof }
    | _             { raise Error }
