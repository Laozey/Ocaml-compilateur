open Ast.IR
open Mips

module Env = Map.Make(String)

(* rec *)
let compile_expr e =
  match e with
  | Int n  -> [ Li (V0, n) ]

let compile ir =
  { text = Baselib.builtins @ compile_expr ir
  ; data = [] }
