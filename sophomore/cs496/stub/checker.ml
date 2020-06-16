open Ast

let from_some = function
  | None -> failwith "from_some: None"
  | Some v -> v

(*  ;;;;;;;;;;;;;;;; type environments ;;;;;;;;;;;;;;;; *)
    
type tenv =
  | EmptyTEnv
  | ExtendTEnv of string*texpr*tenv
                    
let empty_tenv () = EmptyTEnv

let extend_tenv id t tenv = ExtendTEnv(id,t,tenv)


let rec apply_tenv (tenv:tenv) (id:string):texpr option =
  match tenv with
  | EmptyTEnv -> None
  | ExtendTEnv (key,value,tenv1) ->
    if id=key
    then Some value
    else apply_tenv tenv1 id

  
let init_tenv () =
     extend_tenv "x"  IntType 
     @@ extend_tenv "v" IntType
     @@ extend_tenv "i"  IntType
     @@ empty_tenv ()

let rec  string_of_tenv  = function
  | EmptyTEnv -> ""
  | ExtendTEnv(id,v,env) -> "("^id^","^string_of_texpr v^")"^string_of_tenv env

let rec has_repeated_labels = function
  | [] -> false
  | (id,typ)::fs  -> List.mem_assoc id fs || has_repeated_labels fs


let rec type_of_prog = function
  | AProg e -> type_of_expr (init_tenv ()) e
and
  type_of_expr en = function 
  | Int n          -> IntType
  | Var id          ->
    (match apply_tenv en id with
    | None -> failwith @@ "Variable "^id^" undefined"
    | Some texp -> texp)
  | ITE(e1, e2, e3)    ->
    let t1 = type_of_expr en e1 
    in let t2 = type_of_expr en e2
    in let t3 = type_of_expr en e3 
    in if t1=BoolType && t2=t3 
    then t2
    else failwith "ITE: Type error"
  | Add(e1, e2) | Mul(e1,e2) | Sub(e1,e2) | Div(e1,e2)    ->
    let t1 = type_of_expr en e1 in
    let t2 = type_of_expr en e2  in
    if t1=IntType && t2=IntType
    then IntType
    else failwith "Add: arguments must be ints"
  | IsZero(e) ->
    let t1 = type_of_expr en e  in
    if t1=IntType
    then BoolType
    else failwith "Zero?: argument must be int"
  | Let(x, e1, e2) ->
    let t1 = type_of_expr en e1
    in type_of_expr (extend_tenv x t1 en) e2
  | Proc(x,ty,e)      ->
    let tc= type_of_expr (extend_tenv x ty en) e
    in FuncType(ty,tc)
  | App(e1,e2)     ->
    let t1 = type_of_expr en e1 
    in let t2 = type_of_expr en e2 
    in (match t1 with
    | FuncType(td,tcd) when td=t2 -> tcd 
    | FuncType(td,tcd) -> failwith "App: argument does not have correct type" 
    | _ -> failwith "App: LHS must be function type")
  | Letrec(tRes,id,param,tParam,body,e) ->
    let t=type_of_expr (extend_tenv param tParam
                          (extend_tenv id (FuncType(tParam,tRes)) en))
        body
    in if t=tRes 
    then type_of_expr (extend_tenv id (FuncType(tParam,tRes)) en) e
    else failwith
        "LetRec: Types of recursive function does not match declaration"
  | Set(id,e) ->
      failwith "EXPLICIT-REFS: Set not a valid operation"
  | BeginEnd(es) ->
    List.fold_left (fun v e -> type_of_expr en e) UnitType es
  | NewRef(e) ->
    let t=type_of_expr en e
    in RefType(t)
  | DeRef(e) ->
    let t1 = type_of_expr en e
    in (match t1 with
    | RefType(t) -> t
    | _ -> failwith "DeRef: Must deref a ref type")             
  | SetRef(e1,e2) ->
    let t1=type_of_expr en e1
    in let t2=type_of_expr en e2
    in (match t1 with
    | RefType tval when tval=t2 -> UnitType
    | _ -> failwith "SetRef: type of LHS and RHS do not match")
  | Record(fs) -> if not (has_repeated_labels fs)
      then RecordType (List.map (fun (id,e) -> (id, type_of_expr
                                                         en e)) fs)
          else failwith "Labels must be unique"
  | Proj(e,field_id) ->
    (match type_of_expr en e with
    | RecordType(fs) -> (match (List.assoc_opt field_id
                              fs) with
                        | Some ty -> ty
                        | None -> failwith "Field not declared")
                          
    | _ -> failwith "Argument of projection must be a field type")
    (* e must b have a
                                 * record type and include label
                                                  * field_id *)
  | Debug ->
    print_string "Environment:\n";
    print_string @@ string_of_tenv en;
    UnitType
           
    
      

        (* ;; \commentbox{\letrecrule}
         * (letrec-exp (p-result-type p-name b-var b-var-type p-body
         *               letrec-body)
         *   (let ((tenv-for-letrec-body
         *           (extend-tenv p-name
         *             (proc-type b-var-type p-result-type)
         *             tenv)))
         *     (let ((p-body-type 
         *             (type-of p-body
         *               (extend-tenv b-var b-var-type
         *                 tenv-for-letrec-body)))) 
         *       (check-equal-type!
         *         p-body-type p-result-type p-body)
         *       (type-of letrec-body tenv-for-letrec-body))))))) *)
    


let parse s =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast


(* Interpret an expression *)
let chk (e:string) : texpr =
  e |> parse |> type_of_prog 

let ex1 = "
let x = 7  
in let y = 2 
   in let y = let x = x-1 
              in x-y 
      in (x-8)- y"

let ex2 = "
   let g = 
      let counter = 0 
      in proc(d:int) {
         begin 
           set counter = counter+1; 
           counter
         end
         }
   in (g 11)-(g 22)"

let ex3 = "
  let g = 
     let counter = newref(0) 
     in proc (d:int) {
         begin
          setref(counter, deref(counter)+1);
          deref(counter)
         end
       }
  in (g 11) - (g 22)"

let ex4 = "
   let g = 
      let counter = 0 
      in proc(d:int) {
         begin 
           set counter = counter+1; 
           counter
         end
         }
   in (proc (x:int) { x + x }
(g 0))"
(* 3 in call-by-name *)
(* 2 in call-by-need *)

let ex5 = "
let a = 3
in let p = proc(x) { set x = 4 }
in begin 
         (p a); 
         a 
       end"

let ex6 = "let p = proc(x:int) { 5-x } in (p 3)"
(* 2 *)
  
let ex7 = "
let a = 3
in let f = proc(x:int) { proc(y:int) { set x = x-y }}
in begin
((f a) 2);
a
end"
(* 1 *)

let ex8 = "
let swap = proc (x:int) { proc (y:int) {
                      let temp = x
                      in begin 
                          set x = y;
                          set y = temp
                         end
                      } 
            }
         in let a = 33
         in let b = 44
         in begin
             ((swap a) b);
             a-b
            end"
(* 11 *)
  
let ex9 = "
letrec fact (x) = if zero?(x) then 1 else x*(fact (x-1)) 
in (fact 7)"
(* 5040 *)
  
let ex10 = "
letrec infiniteLoop (x) = (infiniteLoop (x+1)) 
in let f = proc (z) { 11 }
in (f (infiniteLoop 0))"

