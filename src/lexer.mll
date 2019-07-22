{
    open Parser
}

let digit = ['0'-'9']
let float = digit* '.'? digit+ | digit+ '.'? digit*

rule token = parse
    | [' ' '\t']    { token lexbuf } (* skip blanks *)
    | ['\n']        { EOL }
    | float as x    { FLOAT (float_of_string x) }
    | '+'           { PLUS }
    | '-'           { MINUS }
    | '*'           { TIMES }
    | '/'           { DIV }
    | '('           { LEFTPAREN }
    | ')'           { RIGHTPAREN }
    | eof           { raise Exceptions.EndOfFile }
    | _             { raise Exceptions.LexError }
