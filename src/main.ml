let print_error (lexbuf : Lexing.lexbuf) (handle : string) : unit =
    Printf.fprintf
        stderr
        "Line %d, offset %d: %s error\n%!"
        lexbuf.lex_start_p.pos_lnum
        (lexbuf.lex_start_p.pos_cnum - lexbuf.lex_start_p.pos_bol)
        handle;
    exit 1

let () =
    try
        let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
        while true do
            try
                Printf.printf "%f\n%!" (Parser.main Lexer.token lexbuf)
            with
                | Lexer.Error -> print_error lexbuf "Lexer"
                | Parser.Error -> print_error lexbuf "Parser"
        done
    with Lexer.Eof -> exit 0
