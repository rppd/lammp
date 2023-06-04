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
  | LPAR
  | RPAR
  | LBRACKET
  | RBRACKET

open Parsing;;
let _ = parse_error;;
# 2 "lib/parse.mly"
open Ast ;;
# 33 "lib/parse.ml"
let yytransl_const = [|
    0 (* EOF *);
  260 (* COLON *);
  261 (* SEMICOLON *);
  262 (* COMMA *);
  263 (* FLOAT *);
  264 (* BOOL *);
  265 (* VEC2 *);
  266 (* VEC3 *);
  267 (* VEC4 *);
  268 (* RETURN *);
  269 (* EQUAL *);
  270 (* PLUS *);
  271 (* MINUS *);
  272 (* MULT *);
  273 (* DIV *);
  274 (* EQUALEQUAL *);
  275 (* GREATER *);
  276 (* SMALLER *);
  277 (* LPAR *);
  278 (* RPAR *);
  279 (* LBRACKET *);
  280 (* RBRACKET *);
    0|]

let yytransl_block = [|
  257 (* LFLOAT *);
  258 (* LBOOL *);
  259 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\005\000\005\000\005\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\008\000\008\000\008\000\008\000\008\000\
\004\000\004\000\007\000\007\000\000\000"

let yylen = "\002\000\
\001\000\002\000\004\000\007\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\002\000\004\000\001\000\
\000\000\001\000\003\000\001\000\001\000\001\000\003\000\005\000\
\007\000\009\000\003\000\001\000\001\000\001\000\001\000\001\000\
\003\000\005\000\003\000\005\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\000\000\000\000\037\000\000\000\000\000\
\000\000\020\000\021\000\000\000\000\000\000\000\000\000\000\000\
\016\000\002\000\000\000\000\000\000\000\000\000\014\000\000\000\
\000\000\000\000\000\000\005\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\003\000\000\000\000\000\000\000\000\000\
\000\000\023\000\000\000\027\000\000\000\000\000\000\000\011\000\
\012\000\000\000\000\000\000\000\028\000\029\000\030\000\031\000\
\032\000\000\000\000\000\000\000\015\000\000\000\000\000\000\000\
\000\000\019\000\000\000\024\000\000\000\034\000\004\000\000\000\
\036\000\000\000\025\000\000\000\026\000"

let yydgoto = "\002\000\
\006\000\007\000\039\000\021\000\040\000\017\000\026\000\058\000"

let yysindex = "\015\000\
\001\000\000\000\000\000\245\254\016\255\000\000\001\000\016\255\
\017\255\000\000\000\000\014\255\016\255\016\255\037\255\187\255\
\000\000\000\000\194\255\045\255\019\255\016\255\000\000\125\255\
\038\255\029\255\016\255\000\000\016\255\016\255\016\255\016\255\
\016\255\016\255\016\255\000\000\004\255\042\255\211\255\039\255\
\016\255\000\000\016\255\000\000\002\000\246\254\246\254\000\000\
\000\000\066\255\066\255\066\255\000\000\000\000\000\000\000\000\
\000\000\053\255\016\255\016\255\000\000\142\255\218\255\017\255\
\235\255\000\000\016\255\000\000\037\255\000\000\000\000\159\255\
\000\000\016\255\000\000\168\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\028\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\041\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\043\255\000\000\
\000\000\000\000\000\000\000\000\255\254\052\255\073\255\000\000\
\000\000\080\255\101\255\108\255\000\000\000\000\000\000\000\000\
\000\000\046\255\000\000\041\255\000\000\000\000\036\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\057\000\000\000\251\255\009\000\029\000\000\000\006\000\000\000"

let yytablesize = 278
let yytable = "\016\000\
\003\000\008\000\019\000\013\000\013\000\031\000\032\000\023\000\
\024\000\009\000\053\000\054\000\055\000\056\000\057\000\001\000\
\010\000\011\000\012\000\020\000\013\000\045\000\013\000\046\000\
\047\000\048\000\049\000\050\000\051\000\052\000\013\000\022\000\
\022\000\022\000\022\000\062\000\014\000\063\000\015\000\025\000\
\038\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
\037\000\022\000\043\000\022\000\044\000\065\000\059\000\009\000\
\009\000\009\000\064\000\035\000\061\000\072\000\017\000\018\000\
\018\000\009\000\009\000\033\000\076\000\009\000\009\000\009\000\
\070\000\009\000\073\000\009\000\010\000\010\000\010\000\029\000\
\030\000\031\000\032\000\006\000\006\000\006\000\010\000\010\000\
\066\000\000\000\010\000\010\000\010\000\000\000\010\000\000\000\
\010\000\006\000\006\000\006\000\000\000\006\000\000\000\006\000\
\007\000\007\000\007\000\000\000\000\000\000\000\000\000\008\000\
\008\000\008\000\000\000\000\000\000\000\000\000\007\000\007\000\
\007\000\000\000\007\000\000\000\007\000\008\000\008\000\008\000\
\027\000\008\000\041\000\008\000\000\000\000\000\000\000\000\000\
\000\000\000\000\029\000\030\000\031\000\032\000\033\000\034\000\
\035\000\027\000\042\000\067\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\029\000\030\000\031\000\032\000\033\000\
\034\000\035\000\027\000\068\000\074\000\000\000\000\000\000\000\
\000\000\000\000\000\000\027\000\029\000\030\000\031\000\032\000\
\033\000\034\000\035\000\000\000\075\000\029\000\030\000\031\000\
\032\000\033\000\034\000\035\000\000\000\077\000\027\000\028\000\
\000\000\000\000\000\000\000\000\000\000\027\000\036\000\000\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\029\000\
\030\000\031\000\032\000\033\000\034\000\035\000\027\000\000\000\
\060\000\000\000\000\000\000\000\000\000\027\000\000\000\069\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\029\000\
\030\000\031\000\032\000\033\000\034\000\035\000\027\000\071\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\000\000\
\000\000\000\000\000\000\004\000\000\000\027\000\000\000\000\000\
\000\000\000\000\000\000\000\000\005\000\000\000\000\000\029\000\
\030\000\031\000\032\000\033\000\034\000\035\000"

let yycheck = "\005\000\
\000\000\013\001\008\000\005\001\006\001\016\001\017\001\013\000\
\014\000\021\001\007\001\008\001\009\001\010\001\011\001\001\000\
\001\001\002\001\003\001\003\001\022\001\027\000\024\001\029\000\
\030\000\031\000\032\000\033\000\034\000\035\000\015\001\004\001\
\005\001\006\001\021\001\041\000\021\001\043\000\023\001\003\001\
\022\001\014\001\015\001\016\001\017\001\018\001\019\001\020\001\
\004\001\022\001\013\001\024\001\024\001\059\000\013\001\004\001\
\005\001\006\001\006\001\024\001\022\001\067\000\022\001\007\000\
\022\001\014\001\015\001\022\001\074\000\018\001\019\001\020\001\
\064\000\022\001\069\000\024\001\004\001\005\001\006\001\014\001\
\015\001\016\001\017\001\004\001\005\001\006\001\014\001\015\001\
\060\000\255\255\018\001\019\001\020\001\255\255\022\001\255\255\
\024\001\018\001\019\001\020\001\255\255\022\001\255\255\024\001\
\004\001\005\001\006\001\255\255\255\255\255\255\255\255\004\001\
\005\001\006\001\255\255\255\255\255\255\255\255\018\001\019\001\
\020\001\255\255\022\001\255\255\024\001\018\001\019\001\020\001\
\004\001\022\001\006\001\024\001\255\255\255\255\255\255\255\255\
\255\255\255\255\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\004\001\022\001\006\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\014\001\015\001\016\001\017\001\018\001\
\019\001\020\001\004\001\022\001\006\001\255\255\255\255\255\255\
\255\255\255\255\255\255\004\001\014\001\015\001\016\001\017\001\
\018\001\019\001\020\001\255\255\022\001\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\255\255\022\001\004\001\005\001\
\255\255\255\255\255\255\255\255\255\255\004\001\005\001\255\255\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\014\001\
\015\001\016\001\017\001\018\001\019\001\020\001\004\001\255\255\
\006\001\255\255\255\255\255\255\255\255\004\001\255\255\006\001\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\014\001\
\015\001\016\001\017\001\018\001\019\001\020\001\004\001\005\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\255\255\
\255\255\255\255\255\255\003\001\255\255\004\001\255\255\255\255\
\255\255\255\255\255\255\255\255\012\001\255\255\255\255\014\001\
\015\001\016\001\017\001\018\001\019\001\020\001"

let yynames_const = "\
  EOF\000\
  COLON\000\
  SEMICOLON\000\
  COMMA\000\
  FLOAT\000\
  BOOL\000\
  VEC2\000\
  VEC3\000\
  VEC4\000\
  RETURN\000\
  EQUAL\000\
  PLUS\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  EQUALEQUAL\000\
  GREATER\000\
  SMALLER\000\
  LPAR\000\
  RPAR\000\
  LBRACKET\000\
  RBRACKET\000\
  "

let yynames_block = "\
  LFLOAT\000\
  LBOOL\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 27 "lib/parse.mly"
      ( [] )
# 233 "lib/parse.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Ast.program) in
    Obj.repr(
# 28 "lib/parse.mly"
                ( _1 :: _2 )
# 241 "lib/parse.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 32 "lib/parse.mly"
                             ( Assign (_1, [], _3) )
# 249 "lib/parse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'params) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 33 "lib/parse.mly"
                                              ( Assign (_1, _3, _6) )
# 258 "lib/parse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 34 "lib/parse.mly"
                        ( Return _2 )
# 265 "lib/parse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "lib/parse.mly"
                                 ( Binop ("==", _1,_3) )
# 273 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "lib/parse.mly"
                                 ( Binop (">", _1, _3) )
# 281 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "lib/parse.mly"
                                 ( Binop ("<", _1, _3) )
# 289 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "lib/parse.mly"
                                 ( Binop ("+", _1, _3) )
# 297 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "lib/parse.mly"
                                 ( Binop ("-", _1, _3) )
# 305 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "lib/parse.mly"
                                 ( Binop ("*", _1, _3) )
# 313 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "lib/parse.mly"
                                 ( Binop ("/", _1, _3) )
# 321 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 45 "lib/parse.mly"
                                 ( Binop (":", _1, _3) )
# 329 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 46 "lib/parse.mly"
                                 ( Monop ("-", _2) )
# 336 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exprs) in
    Obj.repr(
# 47 "lib/parse.mly"
                                 ( App (_1, _3) )
# 344 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 48 "lib/parse.mly"
                                 ( _1 )
# 351 "lib/parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 52 "lib/parse.mly"
  ( [] )
# 357 "lib/parse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 53 "lib/parse.mly"
        ( [_1] )
# 364 "lib/parse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 54 "lib/parse.mly"
                           ( _1 :: _3 )
# 372 "lib/parse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 58 "lib/parse.mly"
                                 ( Float (_1) )
# 379 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 59 "lib/parse.mly"
                                 ( Bool  (_1) )
# 386 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 60 "lib/parse.mly"
                                 ( Ident (_1) )
# 393 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 61 "lib/parse.mly"
                                 ( _2 )
# 400 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 62 "lib/parse.mly"
                                 ( Vec2(_2,_4) )
# 408 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 64 "lib/parse.mly"
                                 ( Vec3(_2,_4,_6) )
# 417 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 7 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 66 "lib/parse.mly"
                                 ( Vec4(_2,_4,_6,_8) )
# 427 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'state_params) in
    Obj.repr(
# 67 "lib/parse.mly"
                                 ( State(_2) )
# 434 "lib/parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "lib/parse.mly"
        ( "float" )
# 440 "lib/parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "lib/parse.mly"
        ( "bool"  )
# 446 "lib/parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 73 "lib/parse.mly"
        ( "vec2"  )
# 452 "lib/parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "lib/parse.mly"
        ( "vec3"  )
# 458 "lib/parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "lib/parse.mly"
        ( "vec4"  )
# 464 "lib/parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'typename) in
    Obj.repr(
# 79 "lib/parse.mly"
                       ( [(_1,_3)] )
# 472 "lib/parse.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'typename) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 80 "lib/parse.mly"
                                    ( (_1,_3) :: _5 )
# 481 "lib/parse.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 84 "lib/parse.mly"
                   ( [(_1,_3)] )
# 489 "lib/parse.ml"
               : 'state_params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'state_params) in
    Obj.repr(
# 85 "lib/parse.mly"
                                      ( (_1,_3) :: _5 )
# 498 "lib/parse.ml"
               : 'state_params))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
