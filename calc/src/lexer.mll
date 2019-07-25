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
    | float as i    { FLOAT (float_of_string i) }
    | '+'           { PLUS }
    | '-'           { MINUS }
    | '*'           { TIMES }
    | '/'           { DIV }
    | "**"          { POWER }
    | "sq"          { SQRT }
    | '('           { LPAREN }
    | ')'           { RPAREN }
    | eof           { raise Eof }
    | _             { raise Error }
