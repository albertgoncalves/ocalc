exception Error of string
exception Eof

let unexpected_char (lexbuf : Lexing.lexbuf) : Parser.token =
    let message =
        Printf.sprintf
            "Lexer Error: unexpected character\nline %d, offset %d"
            lexbuf.lex_start_p.pos_lnum
            lexbuf.lex_start_p.pos_cnum in
    raise (Error (message))
