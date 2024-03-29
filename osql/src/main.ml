let print_error (lexbuf : Lexing.lexbuf) (handle : string) : unit =
    let position : Lexing.position = Lexing.lexeme_start_p lexbuf in
    Printf.eprintf
        "\027[1m%s error\027[0m: line %d, offset %d\n%!"
        handle
        position.Lexing.pos_lnum
        (position.Lexing.pos_cnum - position.Lexing.pos_bol)

let () : unit =
    let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
    try
        List.map Prelude.string_of_sql (Parser.main Lexer.token lexbuf)
        |> String.concat " "
        |> print_endline
    with
        | Lexer.Error -> print_error lexbuf "Lex"; exit 1
        | Parser.Error -> print_error lexbuf "Parse"; exit 1
