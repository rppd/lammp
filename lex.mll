{
  open Parse ;;
  exception Eoi ;;

  exception LexError of (Lexing.position * Lexing.position) ;;
  let line_number = ref 0 ;;

  let incr_line_number lexbuf =
    let pos = lexbuf.Lexing.lex_curr_p in
    lexbuf.Lexing.lex_curr_p <- { pos with
      Lexing.pos_lnum = pos.Lexing.pos_lnum + 1 ;
      Lexing.pos_bol = pos.Lexing.pos_cnum }
}

let newline = ('\010' | '\013' | "\013\010")

rule lex = parse
    (' ' | '\t' )
      { lex lexbuf }     (* on passe les espaces *)
  | newline 
      { incr_line_number lexbuf; lex lexbuf }
  | ['0'-'9']+('.'['0'-'9']*)? as lxm
      { LFLOAT(float_of_string lxm) }
  | [ 'A'-'Z' 'a'-'z' ] [ 'A'-'Z' 'a'-'z' '_' '0'-'9']* as lxm
      { match lxm with
        | "return" -> RETURN
        | "float" -> FLOAT
        | "bool" -> BOOL
        | "vec2" -> VEC2
        | "vec3" -> VEC3
        | "vec4" -> VEC4
        | _ -> IDENT(lxm) }
  | "="   { EQUAL }
  | "=="  { EQUALEQUAL }
  | ">"   { GREATER} | "<"  { SMALLER }
  | "+"   { PLUS } | "-"   { MINUS } | "*" { MULT } | "/" { DIV }
  | ";"   { SEMICOLON }
  | ","   { COMMA }
  | ":"   { COLON }
  | '('   { LPAR }
  | ')'   { RPAR }
  | '['   { LBRACKET }
  | ']'   { RBRACKET }
  | "!"   { EXCLAM }
  | "//"  { in_cpp_comment lexbuf }
  | "/*"  { in_c_comment lexbuf }
  | eof   { EOF }
  | _  as c { Printf.eprintf "Invalid char `%c'\n%!" c ; lex lexbuf }

and in_cpp_comment = parse
    '\n' { lex lexbuf }
  | _    { in_cpp_comment lexbuf }
  | eof  { raise Eoi }

and in_c_comment = parse
    "*/" { lex lexbuf }
  | _    { in_c_comment lexbuf }
  | eof  { raise Eoi }

and skip_to_eol = parse
    newline { () }
  | _       { skip_to_eol lexbuf }
