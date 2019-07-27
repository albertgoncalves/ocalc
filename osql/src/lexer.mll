{
    open Parser

    exception Error

    let keyword_table =
        let table = Hashtbl.create 3 in
        List.iter
            (fun (k, v) -> Hashtbl.add table k v)
            [
                ("select", SELECT);
                ("from", FROM);
                ("as", AS);
            ];
        table

    let lookup (x : string) : token =
        try Hashtbl.find keyword_table (String.lowercase_ascii x)
        with Not_found -> ID x
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z' '_' '*']
let id = alpha (alpha|digit)*
let int = digit+
let float = digit* '.' digit+ | digit+ '.' digit*
let until_newline = [^'\n']*

rule token = parse
    | ';'               { END }
    | ','               { COMMA }
    | '('               { LP }
    | ')'               { RP }
    | '\''              { read_string (Buffer.create 16) lexbuf }
    | '\n'              { Lexing.new_line lexbuf; token lexbuf }
    | eof | "eof"       { EOF }
    | "//" until_newline | "--" until_newline | [' ' '\t']
                        { token lexbuf }
    | float as x        { FLOAT x }
    | int as x          { INT x }
    | id as x           { lookup x }
    | _                 { raise Error }

and read_string buf = parse
    | [^ '\'']+ as x    { Buffer.add_string buf x; read_string buf lexbuf }
    | '\''              { STR (Buffer.contents buf) }
