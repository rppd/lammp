open Ast
open Printf

type env_entry = string * (typename list * typename) and
env = env_entry list;;

let standard_env:env = [
              ("square", ([T.Float], T.Bool));
              ("circle", ([T.Float], T.Bool));
              ("scale", ([T.Float], T.State));
              ("translate", ([T.Float ; T.Float], T.State));
              ("rotate", ([T.Float], T.State));
              ("x", ([], T.Float));
              ("y", ([], T.Float));
              ("t", ([], T.Float));
              ("cos", ([T.Float], T.Float))
              ];;


let rec print_param_types oc = function
  | [] -> fprintf oc ""
  | [ty] -> fprintf oc "%s" (typename_string ty)
  | t::q -> fprintf oc "%s,%a" (typename_string t) print_param_types q

let rec print_env oc = function
  | [] -> fprintf oc "\n"
  | (name,(param_types,ret))::q -> fprintf oc "%s(%a):%s\n%a" name print_param_types param_types (typename_string ret) print_env q

let type_ident ident (env:env) = match List.assoc_opt ident env with
  | Some(t) -> t
  | None -> failwith("Unbound identifier "^ident);;

let rec params_typecheck t lt exprs env = match (lt,exprs) with
  | [], [] -> t
  | ty::q1, e::q2 -> if (ty = type_expr e env) then params_typecheck t q1 q2 env else failwith "Incorrect parameter type"
  | [],_ | _,[] -> failwith("Incorrect parameter count")

and type_expr expr env:typename = match expr with
  | Float(_) -> T.Float
  | Bool(_) -> T.Bool
  | Vec2(_) -> T.Vec2
  | Vec3(_) -> T.Vec3
  | Vec4(_) -> T.Vec4
  | State(_) -> T.State
  | Ident(name) -> let lt,t = type_ident name env in if lt <> [] then failwith("Using a function as expression.") else t
  | App(name, exprs) -> let (lt, t) = type_ident name env in params_typecheck t lt exprs env
  | Monop(op,expr) -> let t = type_expr expr env in
    (match (op, t) with
    | "-",(T.Float|T.Vec2|T.Vec3|T.Vec4) -> t
    | "!",(T.Bool) -> t
    | _ -> failwith("Mono operator type error."))
  | Binop(op,e1,e2) -> let t1 = type_expr e1 env in
                    let t2 = type_expr e2 env in
                    match (op,(t1,t2)) with
                    | ("+"|"-"|"*"|"/"),(T.Float,T.Float|T.Vec2,T.Vec2|T.Vec3,T.Vec3|T.Vec4,T.Vec4) -> t1
                    | ("+"|"-"),(T.Bool,T.Bool) -> T.Bool
                    | "*",(T.Bool,(T.Float|T.Vec2|T.Vec3|T.Vec4)) -> t2
                    | "*",((T.Float|T.Vec2|T.Vec3|T.Vec4),T.Bool) -> t1
                    | ":",(T.State,t) -> t
                    | _ -> failwith("Binary operator type error.")

and program_env program env = match program with
  | [] -> env
  | t::q ->  (match t with
    | Assign(name,params,expr) -> let env' = (List.map (fun (id,t) -> id,([],t)) params) @ env in
                                  let env'' = (name,(List.map snd params,type_expr expr env'))::env' in program_env q env''
    | Return(expr) -> program_env q env
    );; 