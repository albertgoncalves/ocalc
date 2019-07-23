module M = MenhirLib.IncrementalEngine
module I = Parser.MenhirInterpreter

let succeed : float -> unit = Printf.printf "%f\n%!"

let fail (lexbuf : Lexing.lexbuf) (checkpoint : float I.checkpoint) : unit =
    match checkpoint with
        | I.HandlingError env ->
            let s = I.current_state_number env in
            Messages.message s |> prerr_string;
            Printf.fprintf stderr "ln %d\n%!" lexbuf.lex_curr_p.pos_lnum
        | _ ->
            Printf.fprintf stderr
                "Line %d, offset %d: syntax error.\n%!"
                lexbuf.lex_curr_p.pos_lnum (Lexing.lexeme_start lexbuf)

let loop (lexbuf : Lexing.lexbuf) (result : float I.checkpoint) : unit =
    let supplier : unit -> I.token * M.position * M.position =
        I.lexer_lexbuf_to_supplier Lexer.token lexbuf in
    I.loop_handle succeed (fail lexbuf) supplier result

let process (line : string) : unit =
    let lexbuf : Lexing.lexbuf = Lexing.from_string line in
    try
        loop lexbuf (Parser.Incremental.main lexbuf.lex_curr_p)
    with
        | Lexer.Error msg ->
            Printf.fprintf stderr "%s%!" msg

let process : (string option -> unit) = function
    | None ->
        ()
    | Some line ->
        process line

let rec repeat (channel : Lexing.lexbuf) : unit =
    let optional_line, continue = Lexer.line channel in
    process optional_line;
    if continue then
        repeat channel

let () = repeat (Lexing.from_channel stdin)
