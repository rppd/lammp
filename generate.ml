open Ast
open Printf

(* Module StateMap = Map.Make(String) *)

let to_ctype = function
  | T.Float -> "float"
  | T.Bool -> "bool"
  | T.Vec2 -> "vec2"
  | T.Vec3 -> "vec3"
  | T.Vec4 -> "vec4"
  | T.State -> "state";;

let standard_lib =
"/*{
	\"DESCRIPTION\": \"\",
	\"CREDIT\": \"\",
	\"ISFVSN\": \"2\",
	\"CATEGORIES\": [\"XXX\"],
	\"INPUTS\": []
}*/

struct state {
  float x;
  float y;
  float t;
};

float x(state s) { return s.x; }
float y(state s) { return s.x; }
float t(state s) { return s.t; }

state scale(state s, float factor) {
  s.x /= factor;
  s.y /= factor;
  return s;
}

state translate(state s, float tx, float ty) {
  s.x -= tx;
  s.y -= ty;
  return s;
}

state rotate(state s, float angle) {
  float sx = s.x;
  float sy = s.y;
  s.x = cos(angle)*sx - sin(angle)*sy;
  s.y = sin(angle)*sx + cos(angle)*sy;
  return s;
}

bool square(state s, float r) {
  return s.x*s.x < r*r && s.y*s.y < r*r;
}

float cos(state s, float x) {
  return cos(x);
}

//STANDARD LIB END
";;

let standard_main = "
//MAIN FUNCTION
void main() {
  state s = state(
    (gl_FragCoord.x - RENDERSIZE.x/2.)/RENDERSIZE.x,
    (gl_FragCoord.y - RENDERSIZE.y/2.)/RENDERSIZE.x,
    TIME
  );

  gl_FragColor = lammp(s);
}
";;

let default_value env expr = match Ast_typed.type_expr expr env with
  | T.Float -> "0."
  | T.Bool -> "false"
  | T.Vec2 -> "vec2(0.,0.)"
  | T.Vec3 -> "vec3(0.,0.,0.)"
  | T.Vec4 -> "vec4(0.,0.,0.,1.)"
  | T.State -> "s";;

(* 
let gen_state oc (env,pairs) = let map = fill_state_map Map.Make(String) pairs in
  |  *)

(* let rec fill_state_map map pairs = match pairs with
  | [] -> map
  | (key:expr)::q -> fill_state_map (StateMap.add key expr m) q
     *)

let rec gen_exprs oc (env,exprs) = match exprs with
  | [] -> fprintf oc ""
  | [expr] -> fprintf oc "%a" gen_expr (env,expr)
  | expr::q -> fprintf oc "%a,%a" gen_expr (env,expr) gen_exprs (env,q)

and gen_expr oc (env,expr)  = match expr with
  | Float(f) -> fprintf oc "%f" f
  | Bool(b) -> fprintf oc "%b" b
  | State(pairs) -> fprintf oc "Not implemented"
  | Ident(name) -> fprintf oc "%s(s)" name
  | App(fname,exprs) -> fprintf oc  "%s(s,%a)" fname gen_exprs (env,exprs)
  | Monop(op,expr) -> fprintf oc "%s%a" op gen_expr (env,expr)
  | Binop(op,expr1,expr2) -> fprintf oc "%a" gen_binop(env,op,expr1,expr2)
  | Vec2(e1,e2) -> fprintf oc "vec2(%a,%a)" gen_expr (env,e1) gen_expr (env,e2)
  | Vec3(e1,e2,e3) -> fprintf oc "vec3(%a,%a,%a)" gen_expr (env,e1) gen_expr (env,e2) gen_expr (env,e3)
  | Vec4(e1,e2,e3,e4) -> fprintf oc "vec4(%a,%a,%a,%a)" gen_expr (env,e1) gen_expr (env,e2) gen_expr (env,e3) gen_expr (env,e4)

and gen_binop oc (env,op,expr1,expr2) = 
  let t1 = Ast_typed.type_expr expr1 env in
  let t2 = Ast_typed.type_expr expr2 env in 
  match op with
    | "*" -> (match t1,t2 with
      | T.Bool, T.Bool -> fprintf oc "%a && %a" gen_expr (env,expr1) gen_expr (env,expr2)
      | T.Bool,_ -> fprintf oc "%a ? %a : %s" gen_expr (env,expr1) gen_expr (env,expr2) (default_value env expr2) (* expr1 ? expr2 : default_value(expr2) *)
      | _,T.Bool -> fprintf oc "%a ? %a : %s" gen_expr (env,expr2) gen_expr (env,expr1) (default_value env expr1) (* expr2 ? expr1 : default_value(expr1) *)
      | _,_ -> fprintf oc "%a*%a" gen_expr (env,expr1) gen_expr (env,expr2))
    | ":" -> (match expr2 with
      | App(fname,args) -> fprintf oc "%s(%a,%a)" fname gen_expr (env,expr1) join_args (env,args)
      | Ident(iname) -> fprintf oc "%s(%a)" iname gen_expr(env,expr1)
      | _ -> failwith("Incorrect use of ':' operator : right-hand expression must be a function call or identifier."))
    | "-" -> (match t1,t2 with
      | T.Bool, T.Bool -> fprintf oc "%a && !%a" gen_expr (env,expr1) gen_expr (env,expr2)
      | _,_ -> fprintf oc "%a - %a" gen_expr (env,expr1) gen_expr (env,expr2))
    | "+" -> (match t1,t2 with
      | T.Bool, T.Bool -> fprintf oc "%a || %a" gen_expr (env,expr1) gen_expr (env,expr2)
      | _,_ -> fprintf oc "%a + %a" gen_expr (env,expr1) gen_expr (env,expr2))
    | _ -> fprintf oc "%a %s %a" gen_expr (env,expr1) op gen_expr (env,expr2)

and join_args oc (env,args) = match args with
  | [] -> fprintf oc ""
  | [t] -> fprintf oc "%a" gen_expr (env,t)
  | t::q -> fprintf oc "%a,%a" gen_expr (env,t) join_args (env,q)

and gen_args oc args = match args with
  | [] -> fprintf oc "state s"
  | (name,typename)::q -> fprintf oc "%s %s, %a" (to_ctype typename) name gen_args q

and gen_assign_header oc (env,fname,args,expr) =
    fprintf oc "%s %s(%a)" (to_ctype (Ast_typed.type_expr expr env)) fname gen_args args;;

let gen_instr oc (env,instr) = match instr with 
  | Assign(fname,args,expr) -> fprintf oc "%a {\n return %a; \n}" gen_assign_header (env,fname,args,expr) gen_expr (env,expr)
  | Return(expr) -> fprintf oc "vec4 lammp(state s) {\n return %a; \n}" gen_expr (env,expr);;

let rec gen_prgm oc (env,instrs) = match instrs with
  | [] -> fprintf oc "%s" standard_main
  | instr::next -> fprintf oc "%a\n\n%a" gen_instr (env,instr) gen_prgm (env,next);;

let generate oc env instrs = fprintf oc "%s\n\n%a" standard_lib gen_prgm (env,instrs);;