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
        while true do
            match (Parser.main Lexer.token lexbuf) with
                | Some x -> Printf.printf "%f\n%!" x
                | None -> ()
        done
    with
        | Lexer.Eof -> exit 0
        | Lexer.Error -> print_error lexbuf "Lex"; exit 1
        | Parser.Error -> print_error lexbuf "Parse"; exit 1
