let print_error (lexbuf : Lexing.lexbuf) (handle : string) : unit =
    Printf.eprintf
        "Line %d, offset %d: %s error\n%!"
        lexbuf.lex_start_p.pos_lnum
        (lexbuf.lex_start_p.pos_cnum - lexbuf.lex_start_p.pos_bol)
        handle

let () =
    let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
    try
        while true do
            Printf.printf "%f\n%!" (Parser.main Lexer.token lexbuf)
        done
    with
        | Lexer.Eof -> exit 0
        | Lexer.Error -> print_error lexbuf "Lexer"; exit 1
        | Parser.Error -> print_error lexbuf "Parser"; exit 1
