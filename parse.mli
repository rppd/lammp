type token =
  | EOF
  | LFLOAT of (float)
  | LBOOL of (bool)
  | IDENT of (string)
  | COLON
  | SEMICOLON
  | COMMA
  | FLOAT
  | BOOL
  | VEC2
  | VEC3
  | VEC4
  | RETURN
  | EQUAL
  | PLUS
  | MINUS
  | MULT
  | DIV
  | EQUALEQUAL
  | GREATER
  | SMALLER
  | EXCLAM
  | LPAR
  | RPAR
  | LBRACKET
  | RBRACKET

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
