open Ast
open Ast.IR
(* open Baselib *)

exception Error of string * Lexing.position

(* rec, env *)
let analyze_expr expr _ =
  match expr with
  | Syntax.Int n -> Int n.value

let analyze parsed =
  analyze_expr parsed Baselib._types_
