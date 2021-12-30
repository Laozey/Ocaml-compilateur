%{
  open Ast.Syntax
%}

%token <int> Lint
%token <bool> Lbol
%token <string> Lstr
%token Lvid
%token Lend

%start prog

%type <Ast.Syntax.expr> prog

%%

prog:
| e = expr; Lend { e }
;

expr:
| v = value {
  Val { value = v ; pos = $startpos(v) }
}
;

value:
| n = Lint {
  Int n
}
| b = Lbol {
  Bol b
}
| Lvid {
  Vid
}
| s = Lstr {
  Str s
}