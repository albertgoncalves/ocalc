{
    open Parser
    exception Error of string
    exception Eof
    let unexpected_char (lexbuf : Lexing.lexbuf) : Parser.token =
        let message =
            Printf.sprintf
                "Lexer Error: unexpected character\nline %d, offset %d"
                lexbuf.lex_curr_p.pos_lnum (Lexing.lexeme_start lexbuf) in
        raise (Error (message))
}

let digit = ['0'-'9']
let float = digit* '.'? digit+ | digit+ '.'? digit*

rule token = parse
    | [' ' '\t']                { token lexbuf }
    | '\n'                      { EOL }
    | float as i                { FLOAT (float_of_string i) }
    | '+'                       { PLUS }
    | '-'                       { MINUS }
    | '*'                       { TIMES }
    | '/'                       { DIV }
    | '('                       { LPAREN }
    | ')'                       { RPAREN }
    | eof                       { raise Eof }
    | _                         { unexpected_char lexbuf }
