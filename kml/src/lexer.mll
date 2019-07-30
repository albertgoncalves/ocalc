{
    let contents (buffer : Buffer.t) = Buffer.contents buffer |> String.trim
}

rule token = parse
    | '\n'                              { Lexing.new_line lexbuf;
                                          token lexbuf
                                        }
    | "<Placemark>" | "</Placemark>"    { Parser.MARK }
    | "<name>" | "<coordinates>"        { capture (Buffer.create 100) lexbuf }
    | eof                               { Parser.EOF }
    | _                                 { token lexbuf }

and capture buffer = parse
    | "</"                              { Parser.TEXT (contents buffer) }
    | _ as x                            { Buffer.add_char buffer x;
                                          capture buffer lexbuf
                                        }
