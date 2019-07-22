{
    open Parser
    exception Eof
}

rule token = parse
    | [' ' '\t']            { token lexbuf } (* skip blanks *)
    | ['\n']                { EOL }
    | ['0'-'9' '.']+ as lxm { FLOAT(float_of_string lxm) }
    | '+'                   { PLUS }
    | '-'                   { MINUS }
    | '*'                   { TIMES }
    | '/'                   { DIV }
    | '('                   { LPAREN }
    | ')'                   { RPAREN }
    | eof                   { raise Eof }
