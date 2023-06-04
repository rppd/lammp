open Printf

type expr =
  | Float of float
  | Bool of bool
  | State of (string * expr) list
  | Ident of string
  | App of (string * (expr list))
  | Monop of (string * expr)
  | Binop of (string * expr * expr)
  | Vec2 of expr * expr
  | Vec3 of expr * expr * expr
  | Vec4 of expr * expr * expr * expr

and instr =
  | Assign of (string * ((string*string) list) * expr)
  | Return of (expr)

type program = instr list ;;

let rec print_state_def oc : ((string * expr) list -> unit) = function 
  | [] -> fprintf oc ""
  | [(name,expr)] -> fprintf oc "%s = %a" name print_expr expr
  | (name,expr)::q -> fprintf oc "%s = %a, %a" name print_expr expr print_state_def q

and print_typed_params oc: ((string*string) list -> unit) = function
  | [] -> fprintf oc ""
  | [(name,ty)] -> fprintf oc "%s:%s " name ty
  | (name,ty)::q -> fprintf oc "%s:%s, %a" name ty print_typed_params q

and print_params oc: (expr list -> unit) = function
  | [] -> fprintf oc ""
  | [expr] -> fprintf oc "%a" print_expr expr
  | expr::q -> fprintf oc "%a,%a" print_expr expr print_params q

and print_expr oc : (expr -> unit) = function
  | Float(f) -> fprintf oc "%g" f
  | Bool(b) -> fprintf oc "%b" b
  | State(map) -> fprintf oc "{%a}" print_state_def map
  | Ident(i) -> fprintf oc "%s" i
  | App(name,params) -> fprintf oc "%s(%a)" name print_params params
  | Monop(op,expr) -> fprintf oc "%s%a" op print_expr expr
  | Binop(op,expr1,expr2) -> fprintf oc "(%a%s%a)" print_expr expr1 op print_expr expr2
  | Vec2(expr1,expr2) -> fprintf oc "(%a,%a)" print_expr expr1 print_expr expr2
  | Vec3(expr1,expr2,expr3) -> fprintf oc "(%a,%a,%a)" print_expr expr1 print_expr expr2 print_expr expr3
  | Vec4(expr1,expr2,expr3,expr4) -> fprintf oc "(%a,%a,%a,%a)" print_expr expr1 print_expr expr2 print_expr expr3 print_expr expr4

and print_instr oc = function
  | Assign(v_name, params, expr) -> fprintf oc "Assign %s (%a) to %a\n" v_name print_typed_params params print_expr expr
  | Return(expr) -> fprintf oc "Return %a\n" print_expr expr
;;

let print_program oc prog = List.iter (print_instr oc) prog ;;
