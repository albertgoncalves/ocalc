type expr =
    | Id of string
    | Str of string
    | Num of string
    | Assign of expr * expr

let rec string_of_expr: (expr -> string) = function
    | Assign (x, y) ->
        Printf.sprintf "Assign(%s, %s)" (string_of_expr x) (string_of_expr y)
    | Id x -> Printf.sprintf "Id(%s)" x
    | Str x -> Printf.sprintf "Str(%s)" x
    | Num x -> Printf.sprintf "Num(%s)" x
