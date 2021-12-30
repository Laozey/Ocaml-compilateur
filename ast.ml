module Syntax = struct
  type value =
  | Vid
  | Int of int
  | Bol of bool
  | Str of string
  type expr =
  | Val of { value: value
           ; pos: Lexing.position }
end

module type Parameters = sig
  type value
end

module V1 = struct
  type value =
  | Vid
  | Bol of bool
  | Int of int
  | Str of string
end

module V2 = struct
  type value =
  | Vid
  | Bol of bool
  | Int of int
  | Dat of string
end

module IR (P : Parameters) = struct
  type ident = string
  type expr =
  | Val of P.value
end

module IR1 = IR(V1)
module IR2 = IR(V2)