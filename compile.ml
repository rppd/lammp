exception Unbound_identifier of string ;;

(* �valuation d'une expression. La m�moire est implicite puisque globale. *)
let rec compile_expr rho = function
  | Ast.Int i -> [ VmBytecode.VMI_Loadi i ]
  | Ast.Bool b -> [ VmBytecode.VMI_Loadb b ]
  | Ast.String s -> [ VmBytecode.VMI_Loads s ]
  | Ast.Ident id ->
      let pos =
        (try find_pos id rho with Not_found -> raise (Unbound_identifier id)) in
      [VmBytecode.VMI_Read pos]
  | Ast.ArrayRead (id, e_index) ->
      (* R�up�rer la position du pointeur dans l'environnement. *)
      let pos =
        (try find_pos id rho with Not_found -> raise (Unbound_identifier id)) in
      (* R�cup�rer la valeur du pointeur (i.e. adresse de base du tableau) dans
         le registre et la mettre sur la pile. *)
      let array_base_code =
        [(VmBytecode.VMI_Read pos) ; VmBytecode.VMI_Push ] in
      let e_index_code = compile_expr rho e_index in
      (* L'indice o� aller lire est dans le registre. *)
      array_base_code @ e_index_code @ [VmBytecode.VMI_Indxread]
  | Ast.App (f_name, args) -> compile_app rho f_name args
  | Ast.Monop (o_name, e) -> (
      match o_name with
      | "-" ->
          (* Translate to 0 - e. *)
          let translation = Ast.Binop ("-", (Ast.Int 0), e) in
          compile_expr rho translation
      | _ -> raise (Failure "Unknown monop")
     )
  | Ast.Binop (o_name, e1, e2) ->
      (* Get the virtual machine instruction depending on the operator. *)
      let binop_instr =
        (match o_name with
        | "+" -> VmBytecode.VMI_Plus
        | "-" -> VmBytecode.VMI_Sub
        | "*" -> VmBytecode.VMI_Mult
        | "/" -> VmBytecode.VMI_Div
        | "==" -> VmBytecode.VMI_Equal
        | "<" -> VmBytecode.VMI_Lt
        | "<=" -> VmBytecode.VMI_Le
        | ">" -> VmBytecode.VMI_Gt
        | ">=" -> VmBytecode.VMI_Ge
        | _ -> raise (Failure "Unknown binop")) in
      let e1_code = compile_expr rho e1 in
      let e2_code = compile_expr rho e2 in
        (e1_code @ [VmBytecode.VMI_Push] @ e2_code @ [binop_instr])


and compile_app_args rho = function
  | [] -> []
  | h :: q ->
      (* Cr�e le bloc pour le param�tre. *)
      let mk_block_code =
        [VmBytecode.VMI_Loadi 1 ; VmBytecode.VMI_Mkblock ;
         VmBytecode.VMI_Envext] in
      (* Compile l'argument effectif. Le fait d'avoir mis le bloc correspondant
         � l'argument effectif dans l'environnement fait que l'on d�cale d'1
         les indices des variables locales de la fonction courante. Si la
         compilation des arguments a besoin d'acc�der � un identificateur, il
         faut corriger �a. On va donc rajouter dans notre environement de
         compilation une liaison factice. C'est �a ou l'on doit conserver un
         compteur de d�calage que l'on va se trimbaler � chaque appel �
         compil_*. *)
      let adjusted_rho = ("" :: rho) in
      let arg_code = compile_expr adjusted_rho h in
      (* Affecte la valeur de l'argument effectif dans le bloc. Le bloc est
         forc�ment le num�ro 0 puisque c'est celui que l'on vient de cr�er. *)
      let assign_code = [VmBytecode.VMI_Assign 0] in
       mk_block_code @ arg_code @ assign_code @
      (compile_app_args adjusted_rho q)


and compile_app rho f_name args =
  (* Compile les arguments effectifs. *)
  let args_code = compile_app_args rho args in
  (* VMI_Call va sauvegarder le code restant � ex�cuter sur la pile et va
     le remplacer par celui de la fonction appel�e. *)
  [VmBytecode.VMI_Pushenv] @ args_code @
  [VmBytecode.VMI_Call f_name ; VmBytecode.VMI_Popenv]


and compile_instr rho = function
  | Ast.While (e, i) ->
      let e_code = compile_expr rho e in
      let i_code = compile_instr rho i in
      e_code @ [VmBytecode.VMI_Loop (e_code, i_code)]
  | Ast.If (e, i1, i2) ->
      let e_code = compile_expr rho e in
      let i1_code = compile_instr rho i1 in
      let i2_code = compile_instr rho i2 in
       e_code @ [VmBytecode.VMI_Branch (i1_code, i2_code)]
  | Ast.Assign (id, e) ->
      (* Compilation valeur � stocker -> registre *)
      let e_code = compile_expr rho e in
      let pos =
        (try find_pos id rho with Not_found -> raise (Unbound_identifier id)) in
      e_code @ [VmBytecode.VMI_Assign pos]
  | Ast.Seq (i1, i2) ->
      let i1_code = compile_instr rho i1 in
      let i2_code = compile_instr rho i2 in
      i1_code @ i2_code
  | Ast.Return e_opt ->
      let e_code =
        (match e_opt with None -> [] | Some e -> compile_expr rho e) in
      e_code @ [VmBytecode.VMI_Return]
  | Ast.Iapp (f_name, args) -> compile_app rho f_name args
  | Ast.Print args ->
      (*
        L'utilisation de List.fold_right est �quivalente � �crire la fonction
        r�cusrive suivante et � l'appliquer � args.
        8< ------------------------------------------------- >8
             let rec compile_print_args rho args =
               match args with
               | [] -> []
               | arg :: rem ->
                   let code = compile_expr rho arg in
                   let rem_code = compile_print_args rho rem in
                   code @ [VmBytecode.VMI_Print] @ rem_code
        8< ------------------------------------------------- >8
      *)
      List.fold_right
        (fun e accu -> (compile_expr rho e) @ [ VmBytecode.VMI_Print] @ accu)
        args []
  | Ast.ArrayWrite (id, e1, e2) ->
       (* R�cup�rer la valeur du pointeur (i.e. adresse de base du tableau)
          dans le registre et la mettre sur la pile. *)
      let pos =
        (try find_pos id rho with Not_found -> raise (Unbound_identifier id)) in
      let array_base_code =
        [(VmBytecode.VMI_Read pos) ; VmBytecode.VMI_Push] in
      (* Compiler la valeur � stocker et la mettre sur la pile. *)
      let e2_code = (compile_expr rho e2) @ [VmBytecode.VMI_Push] in
      (* Compiler l'indice o� aller �crire -> registre *)
      let e1_code = compile_expr rho e1 in
      (* La valeur de l'index se trouve dans l'accumulateur. La valeur �
         affecter est au sommet de la pile, l'adresse o� �crire juste en
       dessous. *)
      array_base_code @ e2_code @ e1_code @ [VmBytecode.VMI_Indxwrite]


and compile_var_decls rho = function
  | [] -> (rho, [])
  | (v_name, decl) :: q ->
      let decl_code =
        (match decl with
        | Ast.Scalar ->
            (* Pas la peine de sauvegarder le registre car les d�clarations de
               variables se font au toplevel ou en d�but de fonction, donc sans
               calculs en suspens. *)
            [VmBytecode.VMI_Loadi 1; VmBytecode.VMI_Mkblock;
             VmBytecode.VMI_Envext]
        | Ast.Array e ->
            (* Compilation de la taille. Comme on n'a pas encore �tendu
               l'environnement d'ex�cution avec le pointeur allou� pour le
               tableau (il est allou� juste apr�s le calcul de la taille du
               tableau), on n'a pas besoin d'ins�rer de liaison factice dans
               l'environnement de compilation. *)
            let e_code = compile_expr rho e in
            (* Allocation de la variable pointeur (pas encore de la zone
               m�moire). Il faut sauvegarder la taille � allouer car on va
               �craser le registre. *)
            let ptr_code =
              [VmBytecode.VMI_Push ; VmBytecode.VMI_Loadi 1 ;
               VmBytecode.VMI_Mkblock; VmBytecode.VMI_Envext] in
            (* Allocation de la zone m�moire du tableau. Il faut r�cup�rer la
               taille et la mettre dans le registre. *)
            let alloc_code = [VmBytecode.VMI_Pop ; VmBytecode.VMI_Mkblock] in
            (* Il faut affecter le pointeur pr�c�demment allou� avec l'adresse
               de la zone que l'on vient d'allouer. Ce pointeur est la derni�re
               variable cr��e, donc d'indice 0 dans l'environnement. *)
            e_code @ ptr_code @ alloc_code @ [VmBytecode.VMI_Assign 0]) in
      let (rho', q_code) = compile_var_decls (v_name :: rho) q in
      (rho', (decl_code @ q_code))
;;


type object_code = {
  (* D�finitions globales toplevel � ex�cuter au tout d�but du programme. *)
  global : VmBytecode.vm_code ;
  (* Code de chacune des fonctions. *)
  funs : (string * VmBytecode.vm_code) list
} ;;


(* Nature du bytecode g�n�r�. Le code provenant de d�clarations de variables
   globales est regroup� en d�but de bytecode. *)
type toplevel_code =
  | TC_Global of VmBytecode.vm_code
  | TC_Fun of (string * VmBytecode.vm_code)
;;


let compile_toplevel rho = function
  | Ast.Vardecl v_decl ->
      let (rho', var_code) =  compile_var_decls rho [v_decl] in
       (rho', (TC_Global var_code))
  | Ast.Fundef f_def ->
      (* Penser � inverser la list des param�tres car on les empile dans
         l'environnement. *)
      let rho' = (List.rev f_def.Ast.params) @ rho in
      let (rho'', vars_code) = compile_var_decls rho' f_def.Ast.vars in
      (* Compilation du corps de la fonction. *)
      let body_code = compile_instr rho'' f_def.Ast.body in
      (* On joint le code des d�clarations de variables locales et celui du
         corps de la fonction. *)
      let all_code = vars_code @ body_code in
      (* L'environnement reste inchang� au final car les fonctions ne sont pas
         li�es dans l'environnement. *)
      (rho, (TC_Fun (f_def.Ast.f_name, all_code)))
;;


let rec compile_program rho = function
  | [] -> { global = [] ; funs = [] }
  | h :: q -> (
      let (rho', code) = compile_toplevel rho h in
      let rem_code = compile_program rho' q in
      match code with
      | TC_Global c -> { global = c @ rem_code.global ; funs = rem_code.funs }
      | TC_Fun c -> { global = rem_code.global ; funs = c :: rem_code.funs }
     )
;;