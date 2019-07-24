{
    open Parser
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
    | '('           { LPAREN }
    | ')'           { RPAREN }
    | eof           { raise Prelude.Eof }
    | _             { Prelude.unexpected_char lexbuf }
