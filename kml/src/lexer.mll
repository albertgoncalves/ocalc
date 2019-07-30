rule token = parse
    | '\n'              { Lexing.new_line lexbuf; token lexbuf }
    | "<Placemark>"     { Parser.START }
    | "</Placemark>"    { Parser.END }
    | "<name>"          { name (Buffer.create 100) lexbuf }
    | "<coordinates>"   { coordinates (Buffer.create 100) lexbuf }
    | eof               { Parser.EOF }
    | _                 { token lexbuf }

and name buffer = parse
    | "</name>"         { Parser.NAME (Buffer.contents buffer |> String.trim) }
    | _ as x            { Buffer.add_char buffer x; name buffer lexbuf }

and coordinates buffer = parse
    | "</coordinates>"  { Parser.COORDINATES
                            (Buffer.contents buffer |> String.trim)
                        }
    | _ as x            { Buffer.add_char buffer x; coordinates buffer lexbuf }
