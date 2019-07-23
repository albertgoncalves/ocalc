module M = MenhirLib.IncrementalEngine
module P = Parser.MenhirInterpreter

let succeed : float -> unit = Printf.printf "%f\n%!"

let fail (lexbuf : Lexing.lexbuf) (checkpoint : float P.checkpoint) : unit =
    match checkpoint with
        | P.HandlingError env ->
            let s = P.current_state_number env in
            Messages.message s |> prerr_string;
            Printf.fprintf stderr "ln %d\n%!" lexbuf.lex_curr_p.pos_lnum
        | _ ->
            Printf.fprintf stderr
                "Line %d, offset %d: syntax error.\n%!"
                lexbuf.lex_curr_p.pos_lnum (Lexing.lexeme_start lexbuf)

let loop (lexbuf : Lexing.lexbuf) (result : float P.checkpoint) : unit =
    let supplier : unit -> P.token * M.position * M.position =
        P.lexer_lexbuf_to_supplier Lexer.token lexbuf in
    P.loop_handle succeed (fail lexbuf) supplier result

let process : (string option -> unit) = function
    | None ->
        ()
    | Some line ->
        let lexbuf : Lexing.lexbuf = Lexing.from_string line in
        try
            loop lexbuf (Parser.Incremental.main lexbuf.lex_curr_p)
        with Lexer.Error msg ->
            Printf.fprintf stderr "%s%!" msg

let rec repeat (channel : Lexing.lexbuf) : unit =
    let (optional_line, continue) = Lexer.line channel in
    process optional_line;
    if continue then
        repeat channel

let () = repeat (Lexing.from_channel stdin)
