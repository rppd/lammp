# 1 "lib/lex.mll"
 
  open Parse ;;
  exception Eoi ;;

  exception LexError of (Lexing.position * Lexing.position) ;;
  let line_number = ref 0 ;;

  let incr_line_number lexbuf =
    let pos = lexbuf.Lexing.lex_curr_p in
    lexbuf.Lexing.lex_curr_p <- { pos with
      Lexing.pos_lnum = pos.Lexing.pos_lnum + 1 ;
      Lexing.pos_bol = pos.Lexing.pos_cnum }

# 16 "lib/lex.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\233\255\234\255\237\255\238\255\239\255\240\255\241\255\
    \242\255\243\255\081\000\245\255\246\255\247\255\248\255\249\255\
    \002\000\081\000\158\000\001\000\254\255\255\255\168\000\250\255\
    \235\255\236\255\002\000\253\255\254\255\255\255\004\000\253\255\
    \254\255\017\000\255\255\005\000\254\255\004\000\255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\011\000\255\255\255\255\255\255\255\255\255\255\
    \004\000\003\000\002\000\001\000\255\255\255\255\002\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\001\000\255\255\255\255\255\255\000\000\255\255";
  Lexing.lex_default =
   "\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\255\255\000\000\000\000\000\000\000\000\000\000\
    \255\255\255\255\255\255\255\255\000\000\000\000\255\255\000\000\
    \000\000\000\000\028\000\000\000\000\000\000\000\032\000\000\000\
    \000\000\255\255\000\000\036\000\000\000\255\255\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\021\000\020\000\020\000\029\000\019\000\038\000\038\000\
    \000\000\000\000\037\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \021\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \006\000\005\000\011\000\013\000\008\000\012\000\033\000\010\000\
    \018\000\018\000\018\000\018\000\018\000\018\000\018\000\018\000\
    \018\000\018\000\007\000\009\000\014\000\016\000\015\000\023\000\
    \034\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\004\000\000\000\003\000\000\000\000\000\
    \000\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\024\000\000\000\000\000\000\000\000\000\
    \025\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\000\000\000\000\000\000\000\000\
    \017\000\000\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\022\000\000\000\018\000\018\000\
    \018\000\018\000\018\000\018\000\018\000\018\000\018\000\018\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\027\000\000\000\031\000\255\255\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\019\000\026\000\000\000\037\000\035\000\
    \255\255\255\255\035\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\030\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\
    \033\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\000\000\255\255\255\255\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\010\000\255\255\255\255\255\255\255\255\
    \010\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\255\255\255\255\255\255\255\255\
    \017\000\255\255\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\018\000\255\255\018\000\018\000\
    \018\000\018\000\018\000\018\000\018\000\018\000\018\000\018\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\026\000\255\255\030\000\035\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec lex lexbuf =
   __ocaml_lex_lex_rec lexbuf 0
and __ocaml_lex_lex_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 19 "lib/lex.mll"
      ( lex lexbuf )
# 167 "lib/lex.ml"

  | 1 ->
# 21 "lib/lex.mll"
      ( incr_line_number lexbuf; lex lexbuf )
# 172 "lib/lex.ml"

  | 2 ->
let
# 22 "lib/lex.mll"
                                  lxm
# 178 "lib/lex.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 23 "lib/lex.mll"
      ( LFLOAT(float_of_string lxm) )
# 182 "lib/lex.ml"

  | 3 ->
let
# 24 "lib/lex.mll"
                                                           lxm
# 188 "lib/lex.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 25 "lib/lex.mll"
      ( match lxm with
        | "return" -> RETURN
        | "float" -> FLOAT
        | "bool" -> BOOL
        | "vec2" -> VEC2
        | "vec3" -> VEC3
        | "vec4" -> VEC4
        | _ -> IDENT(lxm) )
# 199 "lib/lex.ml"

  | 4 ->
# 33 "lib/lex.mll"
          ( EQUAL )
# 204 "lib/lex.ml"

  | 5 ->
# 34 "lib/lex.mll"
          ( EQUALEQUAL )
# 209 "lib/lex.ml"

  | 6 ->
# 35 "lib/lex.mll"
          ( GREATER)
# 214 "lib/lex.ml"

  | 7 ->
# 35 "lib/lex.mll"
                            ( SMALLER )
# 219 "lib/lex.ml"

  | 8 ->
# 36 "lib/lex.mll"
          ( PLUS )
# 224 "lib/lex.ml"

  | 9 ->
# 36 "lib/lex.mll"
                           ( MINUS )
# 229 "lib/lex.ml"

  | 10 ->
# 36 "lib/lex.mll"
                                           ( MULT )
# 234 "lib/lex.ml"

  | 11 ->
# 36 "lib/lex.mll"
                                                          ( DIV )
# 239 "lib/lex.ml"

  | 12 ->
# 37 "lib/lex.mll"
          ( SEMICOLON )
# 244 "lib/lex.ml"

  | 13 ->
# 38 "lib/lex.mll"
          ( COMMA )
# 249 "lib/lex.ml"

  | 14 ->
# 39 "lib/lex.mll"
          ( COLON )
# 254 "lib/lex.ml"

  | 15 ->
# 40 "lib/lex.mll"
          ( LPAR )
# 259 "lib/lex.ml"

  | 16 ->
# 41 "lib/lex.mll"
          ( RPAR )
# 264 "lib/lex.ml"

  | 17 ->
# 42 "lib/lex.mll"
          ( LBRACKET )
# 269 "lib/lex.ml"

  | 18 ->
# 43 "lib/lex.mll"
          ( RBRACKET )
# 274 "lib/lex.ml"

  | 19 ->
# 44 "lib/lex.mll"
          ( in_cpp_comment lexbuf )
# 279 "lib/lex.ml"

  | 20 ->
# 45 "lib/lex.mll"
          ( in_c_comment lexbuf )
# 284 "lib/lex.ml"

  | 21 ->
# 46 "lib/lex.mll"
          ( EOF )
# 289 "lib/lex.ml"

  | 22 ->
let
# 47 "lib/lex.mll"
          c
# 295 "lib/lex.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 47 "lib/lex.mll"
            ( Printf.eprintf "Invalid char `%c'\n%!" c ; lex lexbuf )
# 299 "lib/lex.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_lex_rec lexbuf __ocaml_lex_state

and in_cpp_comment lexbuf =
   __ocaml_lex_in_cpp_comment_rec lexbuf 26
and __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 50 "lib/lex.mll"
         ( lex lexbuf )
# 311 "lib/lex.ml"

  | 1 ->
# 51 "lib/lex.mll"
         ( in_cpp_comment lexbuf )
# 316 "lib/lex.ml"

  | 2 ->
# 52 "lib/lex.mll"
         ( raise Eoi )
# 321 "lib/lex.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state

and in_c_comment lexbuf =
   __ocaml_lex_in_c_comment_rec lexbuf 30
and __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 55 "lib/lex.mll"
         ( lex lexbuf )
# 333 "lib/lex.ml"

  | 1 ->
# 56 "lib/lex.mll"
         ( in_c_comment lexbuf )
# 338 "lib/lex.ml"

  | 2 ->
# 57 "lib/lex.mll"
         ( raise Eoi )
# 343 "lib/lex.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state

and skip_to_eol lexbuf =
   __ocaml_lex_skip_to_eol_rec lexbuf 35
and __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 60 "lib/lex.mll"
            ( () )
# 355 "lib/lex.ml"

  | 1 ->
# 61 "lib/lex.mll"
            ( skip_to_eol lexbuf )
# 360 "lib/lex.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state

;;
