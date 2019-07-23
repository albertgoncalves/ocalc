module M = MenhirLib.IncrementalEngine
module P = Parser.MenhirInterpreter

let succeed : float -> unit = Printf.printf "%f\n%!"

let fail (lexbuf : Lexing.lexbuf) (checkpoint : float P.checkpoint) : unit =
    (match checkpoint with
        | P.HandlingError env ->
            let s = P.current_state_number env in
            Messages.message s
            |> Printf.fprintf stderr "ln %d\n%s%!" lexbuf.lex_curr_p.pos_lnum
        | _ ->
            Printf.fprintf stderr
                "Parser Error: unhandled condition\nline %d, offset %d"
                lexbuf.lex_curr_p.pos_lnum (Lexing.lexeme_start lexbuf));
    exit 1

let loop (lexbuf : Lexing.lexbuf) (result : float P.checkpoint) : unit =
    let supplier : unit -> P.token * M.position * M.position =
        P.lexer_lexbuf_to_supplier Lexer.token lexbuf in
    P.loop_handle succeed (fail lexbuf) supplier result

let () =
    try
        let lexbuf : Lexing.lexbuf = Lexing.from_channel stdin in
        while true do
            loop lexbuf (Parser.Incremental.main lexbuf.lex_curr_p)
        done
    with
        | Lexer.Eof -> exit 0
        | Lexer.Error msg -> Printf.fprintf stderr "%s%!" msg; exit 1
