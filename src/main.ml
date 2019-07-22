let () =
    try
        let user_input : Lexing.lexbuf = Lexing.from_channel stdin in
        while true do
            let result : float = Parser.main Lexer.token user_input in
            print_float result;
            print_newline ();
            flush stdout
        done
    with
        | Lexer.SyntaxError x -> print_endline x; exit 1
        | Lexer.EndOfFile -> exit 0
