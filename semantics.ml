open Ast
(* open Baselib *)

exception Error of string * Lexing.position

let analyze_value value =
  match value with
  | Syntax.Vid -> V1.Vid
  | Syntax.Bol b -> V1.Bol b
  | Syntax.Int n -> V1.Int n
  | Syntax.Str s -> V1.Str s
let analyze_expr expr _ =
  match expr with
  | Syntax.Val v -> IR1.Val (analyze_value v.value)

let analyze parsed =
  analyze_expr parsed Baselib._types_
