let print_tuple : (string * string) option -> unit = function
    | Some (x, y) -> Printf.printf "%s,%s\n" x y
    | None -> ()

let print_error (lexbuf : Lexing.lexbuf) : unit =
    let position : Lexing.position = Lexing.lexeme_start_p lexbuf in
    Printf.eprintf
        "\027[1mError\027[0m: line %d, offset %d\n%!"
        position.Lexing.pos_lnum
        (position.Lexing.pos_cnum - position.Lexing.pos_bol)

let () : unit =
    let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
    try
        let _ = List.map print_tuple (Parser.main Lexer.token lexbuf) in
        flush stdout
    with
        | Parser.Error -> print_error lexbuf; exit 1
