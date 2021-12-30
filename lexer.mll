{
  (* open Lexing *)
  open Parser

  exception Error of char
  exception StrEndError
}

let alpha = ['a'-'z' 'A'-'Z']
let special = ('-' | '_')
let num = ['0'-'9']
let identifier = alpha (alpha | num | special)*

rule token = parse
| eof             { Lend }
| [ ' ' '\t' ]    { token lexbuf }
| '\n'            { Lexing.new_line lexbuf; token lexbuf }
| "void"          { Lvid }
| "true" as t     { Lbol (bool_of_string t) }
| "false" as f    { Lbol (bool_of_string f) }
| num+ as n       { Lint (int_of_string n) }
| '"'             { Lstr (String.of_seq (List.to_seq (charseq lexbuf))) }
| _ as c          { raise (Error c) }
and charseq = parse
| eof { raise (StrEndError) }
| '"' { [] } 
| "\\n" { '\n' :: (charseq lexbuf) } 
| "\\t" { '\t' :: (charseq lexbuf) }
| "\\\\" { '\\' :: (charseq lexbuf) } 
| _ as c { c :: (charseq lexbuf) }
