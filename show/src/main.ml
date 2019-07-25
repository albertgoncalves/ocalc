let print_error (lexbuf : Lexing.lexbuf) (handle : string) : unit =
    Printf.eprintf
        "\027[1m%s error\027[0m: line %d, offset %d\n%!"
        handle
        lexbuf.lex_start_p.pos_lnum
        (lexbuf.lex_start_p.pos_cnum - lexbuf.lex_start_p.pos_bol)

let () =
    let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
    try
        while true do
            match (Parser.main Lexer.token lexbuf) with
                | Some x -> x |> Prelude.print_expr |> print_endline
                | None -> ()
        done
    with
        | Lexer.Eof -> exit 0
        | Lexer.Error -> print_error lexbuf "Lex"; exit 1
        | Parser.Error -> print_error lexbuf "Parse"; exit 1
