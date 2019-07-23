{
    open Parser
    exception Error of string
    let unexpected_char (x : int) : Parser.token =
        let message =
            Printf.sprintf "At offset %d: unexpected character.\n" x in
        raise (Error (message))
}

(* This rule looks for a single line, terminated with '\n' or eof.  It returns
   a pair of an optional string (the line that was found) and a Boolean flag
   (false if eof was reached). *)
rule line = parse
    | ([^'\n']* '\n') as line   { Some line, true } (* Normal case: one line, no eof. *)
    | eof                       { None, false }     (* Normal case: no data, eof. *)
    | ([^'\n']+ as line) eof    { Some (line ^ "\n"), false } (* Special case: some data but missing '\n', then eof.
                                                                 Consider this as the last line, and add the missing '\n'. *)

(* This rule analyzes a single line and turns it into a stream of tokens. *)
and token = parse
    | [' ' '\t']        { token lexbuf }
    | '\n'              { EOL }
    | ['0'-'9']+ as i   { INT (int_of_string i) }
    | '+'               { PLUS }
    | '-'               { MINUS }
    | '*'               { TIMES }
    | '/'               { DIV }
    | '('               { LPAREN }
    | ')'               { RPAREN }
    | _                 { unexpected_char @@ Lexing.lexeme_start lexbuf }
