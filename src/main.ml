let print_error (lexbuf : Lexing.lexbuf) (handle : string) : unit =
    Printf.eprintf
        "\027[1m%s error\027[0m: Line %d, offset %d\n%!"
        handle
        lexbuf.lex_start_p.pos_lnum
        (lexbuf.lex_start_p.pos_cnum - lexbuf.lex_start_p.pos_bol)

let () =
    let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
    try
        while true do
            match (Parser.main Lexer.token lexbuf) with
                | Prelude.Value x -> Printf.printf "%f\n%!" x
                | Prelude.Empty -> ()
        done
    with
        | Lexer.Eof -> exit 0
        | Lexer.Error -> print_error lexbuf "Lexer"; exit 1
        | Parser.Error -> print_error lexbuf "Parser"; exit 1
