module M = MenhirLib.IncrementalEngine
module I = Parser.MenhirInterpreter
module L = Lexing

let succeed : int -> unit = Printf.printf "%d\n%!"

let fail (lexbuf : L.lexbuf) (checkpoint : int I.checkpoint) : unit =
    match checkpoint with
        | I.HandlingError env ->
            let s = I.current_state_number env in
            Messages.message s |> print_endline
        | _ ->
            Printf.fprintf stderr
                "At offset %d: syntax error.\n%!"
                (L.lexeme_start lexbuf)

let loop (lexbuf : L.lexbuf) (result : int I.checkpoint) : unit =
    let supplier : unit -> I.token * M.position * M.position =
        I.lexer_lexbuf_to_supplier Lexer.token lexbuf in
    I.loop_handle succeed (fail lexbuf) supplier result

let process (line : string) : unit =
    let lexbuf : L.lexbuf = L.from_string line in
    try
        loop lexbuf (Parser.Incremental.main lexbuf.lex_curr_p)
    with
        | Lexer.Error msg ->
            Printf.fprintf stderr "%s%!" msg

let process (optional_line : string option) : unit =
    match optional_line with
        | None ->
            ()
        | Some line ->
            process line

let rec repeat (channel : L.lexbuf) : unit =
    let optional_line, continue = Lexer.line channel in
    process optional_line;
    if continue then
        repeat channel

let () = repeat (L.from_channel stdin)
