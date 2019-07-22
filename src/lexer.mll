{
    open Parser
    exception SyntaxError of string
    exception EndOfFile

    let bad_float (x : string) : exn =
        SyntaxError
            (Printf.sprintf "SyntaxError: Malformed float '%s'" x)

    let bad_char (x : char) : exn =
        SyntaxError
            (Printf.sprintf "SyntaxError: Unable to parse character '%c'" x)
}

let digit = ['0'-'9']
let valid = digit* '.' digit*
let malformed = digit* '.'+

rule token = parse
    | [' ' '\t']      { token lexbuf } (* skip blanks *)
    | ['\n']          { EOL }
    | valid as x      { FLOAT (float_of_string x) }
    | malformed* as x { raise (bad_float x) }
    | '+'             { PLUS }
    | '-'             { MINUS }
    | '*'             { TIMES }
    | '/'             { DIV }
    | '('             { LPAREN }
    | ')'             { RPAREN }
    | eof             { raise EndOfFile }
    | _ as x          { raise (bad_char x) }
