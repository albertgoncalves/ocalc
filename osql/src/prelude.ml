type sql =
    | Id of string
    | As of sql * string
    | Str of string
    | Int of string
    | Float of string
    | Exprs of sql list
    | Select of sql
    | FromTable of string
    | FromExpr of sql
    | Inner of sql list

let rec string_of_sql : sql -> string = function
    | Id x | Int x | Float x -> x
    | As (x, y) -> Printf.sprintf "%s as %s" (string_of_sql x) y
    | Str x -> Printf.sprintf "\'%s\'" x
    | Select x -> Printf.sprintf "select %s" (string_of_sql x)
    | Exprs xs -> List.map string_of_sql xs |> String.concat ", "
    | FromTable x -> Printf.sprintf "from %s" x
    | FromExpr x -> string_of_sql x |> Printf.sprintf "from %s"
    | Inner xs ->
        List.map string_of_sql xs
        |> String.concat " "
        |> Printf.sprintf "(%s)"
