%{
open Ast ;;
%}

%token EOF
%token <float> LFLOAT
%token <bool> LBOOL
%token <string> IDENT
%token COLON SEMICOLON COMMA

%token FLOAT BOOL VEC2 VEC3 VEC4 RETURN
%token EQUAL PLUS MINUS MULT DIV EQUALEQUAL GREATER SMALLER
%token LPAR RPAR LBRACKET RBRACKET

%right COLON
%left EQUALEQUAL GREATER SMALLER
%left PLUS MINUS
%left MULT DIV
%nonassoc UMINUS

%start program
%type <Ast.program> program

%%

program:
| EOF { [] }
| instr program { $1 :: $2 } 
;

instr:
| IDENT EQUAL expr SEMICOLON { Assign ($1, [], $3) }
| IDENT LPAR params RPAR EQUAL expr SEMICOLON { Assign ($1, $3, $6) }
| RETURN expr SEMICOLON { Return $2 }
;

expr:
| expr EQUALEQUAL expr           { Binop ("==", $1,$3) }
| expr GREATER expr              { Binop (">", $1, $3) }
| expr SMALLER expr              { Binop ("<", $1, $3) }
| expr PLUS expr                 { Binop ("+", $1, $3) }
| expr MINUS expr                { Binop ("-", $1, $3) }
| expr MULT expr                 { Binop ("*", $1, $3) }
| expr DIV expr                  { Binop ("/", $1, $3) }
| expr COLON expr                { Binop (":", $1, $3) }
| MINUS expr        %prec UMINUS { Monop ("-", $2) }
| IDENT LPAR exprs RPAR          { App ($1, $3) }
| atom                           { $1 }
;

exprs:
| { [] }
| expr  { [$1] }
| expr COMMA exprs         { $1 :: $3 }
;

atom:
| LFLOAT                         { Float ($1) }
| LBOOL                          { Bool  ($1) }
| IDENT                          { Ident ($1) }
| LPAR expr RPAR                 { $2 }
| LPAR expr COMMA expr RPAR      { Vec2($2,$4) }
| LPAR expr COMMA expr COMMA
    expr RPAR                    { Vec3($2,$4,$6) }
| LPAR expr COMMA expr COMMA
    expr COMMA expr RPAR         { Vec4($2,$4,$6,$8) }
| LBRACKET state_params RBRACKET { State($2) }
;

typename:
| FLOAT { "float" }
| BOOL  { "bool"  }
| VEC2  { "vec2"  }
| VEC3  { "vec3"  }
| VEC4  { "vec4"  }
;

params:
| IDENT COLON typename { [($1,$3)] }
| IDENT COLON typename COMMA params { ($1,$3) :: $5 }
;

state_params:
| IDENT EQUAL expr { [($1,$3)] }
| IDENT EQUAL expr COMMA state_params { ($1,$3) :: $5 }
;