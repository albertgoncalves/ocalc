type expr =
    | Var of string
    | Str of string
    | Num of string
    | Fn of string * string list * expr list
    | Assign of expr * expr

let rec string_of_expr: (expr -> string) = function
    | Assign (x, y) ->
        Printf.sprintf "Assign(%s,%s)" (string_of_expr x) (string_of_expr y)
    | Var x -> Printf.sprintf "Var(%s)" x
    | Str x -> Printf.sprintf "Str(%s)" x
    | Num x -> Printf.sprintf "Num(%s)" x
    | Fn (x, xs, ys) ->
        Printf.sprintf "Fn(%s)(%s)(%s)"
            x
            (String.concat "," xs)
            (List.map string_of_expr ys |> String.concat ",")
