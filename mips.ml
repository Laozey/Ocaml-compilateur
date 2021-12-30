type reg =
  | V0
  | A0

type label = string

type loc =
  | Lbl of label

type instr =
  | Li of reg * int
  | La of reg * loc
  | Move of reg * reg

type directive =
  | Asciiz of string

type decl = label * directive

type asm = { text: instr list ; data: decl list }

let ps = Printf.sprintf (* alias raccourci *)

let fmt_reg = function
  | V0   -> "$v0"
  | A0   -> "$a0"

let fmt_loc = function
  | Lbl l    -> l
  
let fmt_instr = function
  | Li (r, i) -> ps "  li %s, %d" (fmt_reg r) i
  | La (r, a) -> ps "  la %s, %s" (fmt_reg r) (fmt_loc a)
  | Move (rd, rs)    -> ps "  move %s, %s" (fmt_reg rd) (fmt_reg rs)

let fmt_dir = function
  | Asciiz (s) -> ps ".asciiz \"%s\"" s

let emit oc asm =
  Printf.fprintf oc ".text\n.globl main\nmain:\n" ;
  List.iter (fun i -> Printf.fprintf oc "%s\n" (fmt_instr i)) asm.text ;
  Printf.fprintf oc "  syscall\n  jr $ra\n" ;
  Printf.fprintf oc "\n.data\n" ;
  List.iter (fun (l, d) -> Printf.fprintf oc "%s: %s\n" l (fmt_dir d)) asm.data
