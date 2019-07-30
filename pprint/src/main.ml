type expr =
    | Id of string
    | Str of string
    | Num of string
    | Fn of string * string list * expr list
    | Assign of expr * expr

let rec indent (margin : string) (x : string) : (int -> string) = function
    | 0 -> x
    | offset -> indent margin (Printf.sprintf "%s%s" margin x) (offset - 1)

let string_of_header : (string -> string -> string) =
    Printf.sprintf "fn %s (%s) {"

let rec string_of_expr (limit : int) (margin : string) (offset : int)
    : (expr -> string) = function
    | Assign (x, y) ->
        Printf.sprintf "%s = %s;"
            (string_of_expr limit margin offset x)
            (string_of_expr limit margin offset y)
    | Id x -> Printf.sprintf "%s" x
    | Str x -> Printf.sprintf "\"%s\"" x
    | Num x -> Printf.sprintf "%s" x
    | Fn (x, xs, ys) ->
        let block : string =
            List.map (string_of_expr limit margin (offset + 1)) ys
            |> String.concat
                (indent margin "" offset |> Printf.sprintf "\n%s") in
        let args : string = String.concat ", " xs in
        let header: string =
            let header : string = string_of_header x args in
            if (String.length header) + (4 * (offset - 1)) < limit then
                header
            else
                let args : string list =
                    List.map (fun xs -> indent margin xs offset) xs in
                Printf.sprintf
                    "\n%s\n%s"
                    (String.concat ",\n" args)
                    (indent margin "" (offset - 1))
                |> string_of_header x in
        Printf.sprintf "%s\n%s\n%s"
            header
            (indent margin block offset)
            (indent margin "}" (offset - 1))

let () : unit =
    let margin : string = indent " " "" 4 in
    let inner : expr = Fn ("g", ["y"], [Assign (Id "zz", Id "z"); Id "zz"]) in
    Fn ("f", ["a"; "b"; "c"], [inner; inner])
    |> string_of_expr 17 margin 1
    |> Printf.printf "%s";
    flush stdout
