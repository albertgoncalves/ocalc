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
        | Exceptions.LexError -> print_endline "Lex Error"; exit 1
        | Exceptions.ParseError -> print_endline "Parse Error"; exit 1
        | Exceptions.EndOfFile -> exit 0
