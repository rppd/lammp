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

open Parsing;;
let _ = parse_error;;
# 2 "parse.mly"
open Ast ;;
# 34 "parse.ml"
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
  277 (* EXCLAM *);
  278 (* LPAR *);
  279 (* RPAR *);
  280 (* LBRACKET *);
  281 (* RBRACKET *);
    0|]

let yytransl_block = [|
  257 (* LFLOAT *);
  258 (* LBOOL *);
  259 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\005\000\005\000\005\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\008\000\008\000\008\000\008\000\
\008\000\004\000\004\000\007\000\007\000\000\000"

let yylen = "\002\000\
\001\000\002\000\004\000\007\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\002\000\002\000\004\000\
\001\000\000\000\001\000\003\000\001\000\001\000\001\000\003\000\
\005\000\007\000\009\000\003\000\001\000\001\000\001\000\001\000\
\001\000\003\000\005\000\003\000\005\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\000\000\000\000\038\000\000\000\000\000\
\000\000\021\000\022\000\000\000\000\000\000\000\000\000\000\000\
\000\000\017\000\002\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\005\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\003\000\000\000\000\000\
\000\000\000\000\000\000\024\000\000\000\028\000\013\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\029\000\030\000\
\031\000\032\000\033\000\000\000\000\000\000\000\016\000\000\000\
\000\000\000\000\000\000\020\000\000\000\025\000\000\000\035\000\
\004\000\000\000\037\000\000\000\026\000\000\000\027\000"

let yydgoto = "\002\000\
\006\000\007\000\041\000\022\000\042\000\018\000\028\000\060\000"

let yysindex = "\005\000\
\001\000\000\000\000\000\245\254\020\255\000\000\001\000\020\255\
\004\255\000\000\000\000\246\254\020\255\020\255\020\255\010\255\
\000\255\000\000\000\000\011\000\021\255\011\255\020\255\032\255\
\032\255\194\255\024\255\014\255\020\255\000\000\020\255\020\255\
\020\255\020\255\020\255\020\255\020\255\000\000\044\255\030\255\
\018\000\027\255\020\255\000\000\020\255\000\000\000\000\029\255\
\029\255\032\255\032\255\140\255\140\255\140\255\000\000\000\000\
\000\000\000\000\000\000\059\255\020\255\020\255\000\000\212\255\
\035\000\004\255\042\000\000\000\020\255\000\000\010\255\000\000\
\000\000\230\255\000\000\020\255\000\000\247\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\043\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\049\255\064\255\
\080\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\050\255\000\000\000\000\000\000\000\000\000\000\000\000\128\255\
\144\255\096\255\112\255\155\255\165\255\176\255\000\000\000\000\
\000\000\000\000\000\000\051\255\000\000\049\255\000\000\000\000\
\042\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\068\000\000\000\251\255\010\000\015\000\000\000\017\000\000\000"

let yytablesize = 318
let yytable = "\017\000\
\003\000\008\000\020\000\029\000\030\000\001\000\021\000\024\000\
\025\000\026\000\009\000\023\000\027\000\031\000\032\000\033\000\
\034\000\035\000\036\000\037\000\010\000\011\000\012\000\047\000\
\039\000\048\000\049\000\050\000\051\000\052\000\053\000\054\000\
\029\000\040\000\013\000\029\000\045\000\064\000\046\000\065\000\
\014\000\015\000\061\000\016\000\033\000\034\000\023\000\023\000\
\023\000\063\000\055\000\056\000\057\000\058\000\059\000\067\000\
\023\000\023\000\023\000\023\000\023\000\023\000\023\000\074\000\
\066\000\023\000\036\000\023\000\014\000\014\000\078\000\018\000\
\019\000\034\000\019\000\072\000\068\000\014\000\014\000\014\000\
\014\000\014\000\014\000\014\000\015\000\015\000\014\000\075\000\
\014\000\000\000\000\000\000\000\000\000\015\000\015\000\015\000\
\015\000\015\000\015\000\015\000\011\000\011\000\015\000\000\000\
\015\000\000\000\000\000\000\000\000\000\011\000\011\000\011\000\
\011\000\011\000\011\000\011\000\012\000\012\000\011\000\000\000\
\011\000\000\000\000\000\000\000\000\000\012\000\012\000\012\000\
\012\000\012\000\012\000\012\000\009\000\009\000\012\000\000\000\
\012\000\000\000\000\000\000\000\000\000\009\000\009\000\029\000\
\000\000\009\000\009\000\009\000\010\000\010\000\009\000\000\000\
\009\000\031\000\032\000\033\000\034\000\010\000\010\000\006\000\
\006\000\010\000\010\000\010\000\000\000\000\000\010\000\000\000\
\010\000\007\000\007\000\000\000\006\000\006\000\006\000\000\000\
\000\000\006\000\000\000\006\000\008\000\008\000\007\000\007\000\
\007\000\000\000\000\000\007\000\000\000\007\000\000\000\000\000\
\000\000\008\000\008\000\008\000\000\000\029\000\008\000\043\000\
\008\000\000\000\000\000\000\000\000\000\000\000\000\000\031\000\
\032\000\033\000\034\000\035\000\036\000\037\000\000\000\029\000\
\044\000\069\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\031\000\032\000\033\000\034\000\035\000\036\000\037\000\
\000\000\029\000\070\000\076\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\031\000\032\000\033\000\034\000\035\000\
\036\000\037\000\029\000\000\000\077\000\000\000\000\000\000\000\
\000\000\000\000\000\000\004\000\031\000\032\000\033\000\034\000\
\035\000\036\000\037\000\000\000\005\000\079\000\029\000\038\000\
\000\000\000\000\000\000\000\000\000\000\029\000\000\000\062\000\
\031\000\032\000\033\000\034\000\035\000\036\000\037\000\031\000\
\032\000\033\000\034\000\035\000\036\000\037\000\029\000\000\000\
\071\000\000\000\000\000\000\000\000\000\029\000\073\000\000\000\
\031\000\032\000\033\000\034\000\035\000\036\000\037\000\031\000\
\032\000\033\000\034\000\035\000\036\000\037\000"

let yycheck = "\005\000\
\000\000\013\001\008\000\004\001\005\001\001\000\003\001\013\000\
\014\000\015\000\022\001\022\001\003\001\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\001\001\002\001\003\001\029\000\
\004\001\031\000\032\000\033\000\034\000\035\000\036\000\037\000\
\004\001\023\001\015\001\004\001\013\001\043\000\025\001\045\000\
\021\001\022\001\013\001\024\001\016\001\017\001\004\001\005\001\
\006\001\023\001\007\001\008\001\009\001\010\001\011\001\061\000\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\069\000\
\006\001\023\001\025\001\025\001\005\001\006\001\076\000\023\001\
\023\001\023\001\007\000\066\000\062\000\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\005\001\006\001\023\001\071\000\
\025\001\255\255\255\255\255\255\255\255\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\005\001\006\001\023\001\255\255\
\025\001\255\255\255\255\255\255\255\255\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\005\001\006\001\023\001\255\255\
\025\001\255\255\255\255\255\255\255\255\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\005\001\006\001\023\001\255\255\
\025\001\255\255\255\255\255\255\255\255\014\001\015\001\004\001\
\255\255\018\001\019\001\020\001\005\001\006\001\023\001\255\255\
\025\001\014\001\015\001\016\001\017\001\014\001\015\001\005\001\
\006\001\018\001\019\001\020\001\255\255\255\255\023\001\255\255\
\025\001\005\001\006\001\255\255\018\001\019\001\020\001\255\255\
\255\255\023\001\255\255\025\001\005\001\006\001\018\001\019\001\
\020\001\255\255\255\255\023\001\255\255\025\001\255\255\255\255\
\255\255\018\001\019\001\020\001\255\255\004\001\023\001\006\001\
\025\001\255\255\255\255\255\255\255\255\255\255\255\255\014\001\
\015\001\016\001\017\001\018\001\019\001\020\001\255\255\004\001\
\023\001\006\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\014\001\015\001\016\001\017\001\018\001\019\001\020\001\
\255\255\004\001\023\001\006\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\014\001\015\001\016\001\017\001\018\001\
\019\001\020\001\004\001\255\255\023\001\255\255\255\255\255\255\
\255\255\255\255\255\255\003\001\014\001\015\001\016\001\017\001\
\018\001\019\001\020\001\255\255\012\001\023\001\004\001\005\001\
\255\255\255\255\255\255\255\255\255\255\004\001\255\255\006\001\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\014\001\
\015\001\016\001\017\001\018\001\019\001\020\001\004\001\255\255\
\006\001\255\255\255\255\255\255\255\255\004\001\005\001\255\255\
\014\001\015\001\016\001\017\001\018\001\019\001\020\001\014\001\
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
  EXCLAM\000\
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
# 27 "parse.mly"
      ( [] )
# 246 "parse.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Ast.program) in
    Obj.repr(
# 28 "parse.mly"
                ( _1 :: _2 )
# 254 "parse.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 32 "parse.mly"
                             ( Assign (_1, [], _3) )
# 262 "parse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'params) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 33 "parse.mly"
                                              ( Assign (_1, _3, _6) )
# 271 "parse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 34 "parse.mly"
                        ( Return _2 )
# 278 "parse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parse.mly"
                                 ( Binop ("==", _1,_3) )
# 286 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parse.mly"
                                 ( Binop (">", _1, _3) )
# 294 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parse.mly"
                                 ( Binop ("<", _1, _3) )
# 302 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parse.mly"
                                 ( Binop ("+", _1, _3) )
# 310 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parse.mly"
                                 ( Binop ("-", _1, _3) )
# 318 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parse.mly"
                                 ( Binop ("*", _1, _3) )
# 326 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parse.mly"
                                 ( Binop ("/", _1, _3) )
# 334 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 45 "parse.mly"
                                 ( Binop (":", _1, _3) )
# 342 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 46 "parse.mly"
                                 ( Monop ("-", _2) )
# 349 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 47 "parse.mly"
                                 ( Monop ("!", _2) )
# 356 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'exprs) in
    Obj.repr(
# 48 "parse.mly"
                                 ( App (_1, _3) )
# 364 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 49 "parse.mly"
                                 ( _1 )
# 371 "parse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 53 "parse.mly"
  ( [] )
# 377 "parse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 54 "parse.mly"
        ( [_1] )
# 384 "parse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 55 "parse.mly"
                           ( _1 :: _3 )
# 392 "parse.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 59 "parse.mly"
                                 ( Float (_1) )
# 399 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 60 "parse.mly"
                                 ( Bool  (_1) )
# 406 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 61 "parse.mly"
                                 ( Ident (_1) )
# 413 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 62 "parse.mly"
                                 ( _2 )
# 420 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 63 "parse.mly"
                                 ( Vec2(_2,_4) )
# 428 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 65 "parse.mly"
                                 ( Vec3(_2,_4,_6) )
# 437 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 7 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 67 "parse.mly"
                                 ( Vec4(_2,_4,_6,_8) )
# 447 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'state_params) in
    Obj.repr(
# 68 "parse.mly"
                                 ( State(_2) )
# 454 "parse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "parse.mly"
        ( T.Float )
# 460 "parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 73 "parse.mly"
        ( T.Bool )
# 466 "parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "parse.mly"
        ( T.Vec2  )
# 472 "parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "parse.mly"
        ( T.Vec3  )
# 478 "parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    Obj.repr(
# 76 "parse.mly"
        ( T.Vec4  )
# 484 "parse.ml"
               : 'typename))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'typename) in
    Obj.repr(
# 80 "parse.mly"
                       ( [(_1,_3)] )
# 492 "parse.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'typename) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 81 "parse.mly"
                                    ( (_1,_3) :: _5 )
# 501 "parse.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 85 "parse.mly"
                   ( [(_1,_3)] )
# 509 "parse.ml"
               : 'state_params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'state_params) in
    Obj.repr(
# 86 "parse.mly"
                                      ( (_1,_3) :: _5 )
# 518 "parse.ml"
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
