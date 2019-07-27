let print_error (lexbuf : Lexing.lexbuf) (handle : string) : unit =
    Printf.eprintf
        "\027[1m%s error\027[0m: line %d, offset %d\n%!"
        handle
        lexbuf.lex_start_p.pos_lnum
        (lexbuf.lex_start_p.pos_cnum - lexbuf.lex_start_p.pos_bol)

let () =
    let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
    try
        List.map
            (Prelude.string_of_expr 17 (Prelude.indent " " "" 4) 1)
            (Parser.main Lexer.token lexbuf)
        |> List.iter (Printf.printf "%s\n");
        flush stdout
    with
        | Lexer.Error -> print_error lexbuf "Lex"; exit 1
        | Parser.Error -> print_error lexbuf "Parse"; exit 1
