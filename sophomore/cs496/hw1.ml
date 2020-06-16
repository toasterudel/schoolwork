(* 1.1.seven:  that given any value returns 7. *)
	
	(* seven: 'a -> int *)
	let seven x = 7;;
	

(* 1.2.sign:  that given an integer returns 1 if it is positive, -1 if it is negative and 0 if it is zero. *)
	
	(* sign: int-> int*)
	let sign x = if x > 0 then 1
	else if x < 0 then -1
	else 0;;
		

(* 1.3.absolute:  the absolute value function. *)

	(* absolute: int -> int*)
	let abs x = if x > 0 then x
	else if x < 0 then x* -1
	else 0;;		(* when doing negatives you have to do: abs (-number) *)


(* 1.4.andp,orp,notp,xorp:  the standard, two argument (except fornotpwhich is unary),boolean connectives (you must resort to if-then-else or amatchstatement). *)

	(* andp: bool -> bool -> bool *)	
	let andp x y = if x=false || y=false then false
	else true;;

	(* orp: bool -> bool -> bool *)
	let orp x y = if x=true || y=true then true
	else false;;

	(* notp: bool -> bool -> bool *)	
	let notp x = if x=true then false
	else true;;

	(* xorp: bool -> bool -> bool *)
	let xorp x y = if x=y then false
	else true;;

	

(* 1.5.dividesBy:  that given two numbers determines if the first is divisible by the second(use remainder). *)

	(* dividesBy: int -> int -> bool*)
	let dividesBy x y = 
	if x mod y == 0 then true
	else false;;


(* 1.6.issingleton:  a predicate that, given a list, returns a boolean indicating whether ithas exactly one element.  Provide your solution using thematchconstruct for patternmatching.  Your solution should NOT depend on computing the length of the list. *)

	(* isSingleton: 'a list-> bool*)
	let isSingleton a = 
	match a with
	|[] -> false
	|[a] -> true
	|h::t -> false;;


(* 1.7.swap:  a  function  that,  given  a  pair,  returns  the  same  pair  except  that  its  first  andsecond components are interchanged. *)

	(* swap: 'a * 'b -> 'b * 'a *)	
	let swap (x,y) = (y,x);; (*NOTE: Only works with the tuple format *)


(* 1.8.app:  a function that, given two arguments, applies the first argument to the secondone. *)

	(* app: ('a -> 'b) -> 'a -> 'b *)
	let app x y = x y;;

(* 1.9.twice:   a  function  that,  given  two  arguments,  applies  the  first  one  to  the  secondargument and then again to the result. *)

	(* twice: ('a -> 'a) -> 'a -> 'a *)
	let twice x y = x (x y);;


(* 1.10.compose:  a function that, given three arguments, applies the second to the third andthen the first to its result. *)

	(* compose: ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b *) 
	let compose x y z = x (y z);;


(* 2.1.  Define the binary operations of union and intersection and the belongsTo predicate, forsets of type a when such sets are represented as:(a)  Extensionally (i.e.  as a list of elements of type a).(b)  Characteristic function (i.e.  as a predicate of type’a -> bool).This should yield six functions: union_ext, union_char, intersection_ext, intersection_char,belongsTo_ext, belongsTo_char. *)

	(* union_ext: 'a list -> 'a list -> 'a list *)	
	let union_ext a b = a @ b;;
	
	(* union_char: 'a -> 'a -> 'a list *)
	let union_char a b = [a; b;];;

	(* intersection_ext: 'a list -> 'a list -> 'a list *)
	let rec intersection_ext xs ys =
	match xs with
	| [] -> []
	| h::t ->
	if List.mem h ys
	then h::(intersection_ext t ys)
	else intersection_ext t ys;;
	
	(* intersection_char:  'a -> 'a -> 'a list *)
	let intersection_char a b = 
	if a == b then [a; b;] else [];;

	(* belongsTo_ext: 'a list -> 'a list -> bool*) (*To be honest I don't know if i did this right, but belongsTo_ext [1;2;3;4;] [1;2;3;4;5;6;] = true *)
	let rec belongsTo_ext a b = 
	match a with
	[] -> true
	| h::t -> if (List.mem h b) then belongsTo_ext t b
	else false;;

	(* 'a -> 'a -> bool *)
	let belongsTo_char a b = a==b;;

	
(*	2.2.	remAdjDups that removes adjacent duplicates from a list. Eg.remAdjDups [1;1;2;3;3;1;4;4;4] should return [1;2;3;1;4]. *)

	(* remAdjDups: 'a list -> 'a list *)
	let rec remAdjDups xs = 
	match xs with
	[] -> []
	|_::[] -> failwith "I messed up"
	| h::s::t -> if h==s then s::(remAdjDups t)
	else h::s::(remAdjDups t);;

(* 2.3		sublists that computes all the sublists of a list, in any order. Eg.sublists [1;2;3]should produce[[]; [1];[2];[1;2];[3];[1;3];[2;3];[1;2;3]]. Note that, a sublist resultsfrom a list by dropping any number of its elements (without rearranging them). *)

	(* sublists: 'a list -> 'a list list *)
	let rec sublists l =
	match l with
	[] -> [[]]
	| x::xs -> let ls = sublists xs in 
				List.map(fun l->x::l) ls @ls;;


(*		Exercise 3, this is given: *)
type calcExp = 
| Const of int
| Add of (calcExp*calcExp)
| Sub of (calcExp*calcExp)
| Mult of (calcExp*calcExp)
| Div of (calcExp*calcExp);;

(* 3.1  Define mapC, a map for calculator expressions. Eg.mapC (fun x -> x + 1) e2 should return Add(Sub(Const(3), Const(4)), Const(5)). *)

	(* mapC: (int->int) -> calcExp -> calcExp *)
	let rec mapC f l =  
	match l with 
	| Const(single) -> Const(f single)
	| Add(left, right) -> Add(mapC f left, mapC f right)
	| Sub(left, right) -> Sub(mapC f left, mapC f right)
	| Mult(left, right) -> Mult(mapC f left, mapC f right)
	| Div(left, right) -> Div(mapC f left, mapC f right);;

(* 3.2 Define foldC, a fold for calculator expressions *)

	(* foldC: 'a -> (calcExp -> 'a -> 'a -> 'a) -> calcExp -> 'a *)
	let rec foldC f l a = 
	match a with
	| Const(single) -> l a f f
	| Add(left, right) -> l a(foldC f l left) (foldC f l right)
	| Sub(left, right) -> l a(foldC f l left) (foldC f l right)
	| Mult(left, right) -> l a(foldC f l left) (foldC f l right)
	| Div(left, right) -> l a(foldC f l left) (foldC f l right);;

(* 3.3 Using foldC, define a function numAdd that returns how many occurrences of Add there are in a given calculator expression. *)

	(* numAdd: calcExp -> int*)
	let numAdd exp = 
	let add calc a b = 
	match calc with
	| Add(l,r) -> 1 + a + b
	| _-> a+b
	in 
	foldC 0 add exp;;

(* 3.4 Using foldC, define a function replaceAddWithMult that replaces all Add by Mult in a calculator expression *)

	(* numAdd : calcExp -> calcExp 	Ah man i didnt see that we had to use foldc, below this is the right way to do it
	let rec replaceAddWithMult exp = 
	match exp with
	| Const(single) -> Const(single)
	| Add(left, right) -> Mult(replaceAddWithMult left, replaceAddWithMult right)
	| Sub(left, right) -> Sub(replaceAddWithMult left, replaceAddWithMult right)
	| Mult(left, right) -> Mult(replaceAddWithMult left, replaceAddWithMult right)
	| Div(left, right) -> Div(replaceAddWithMult left, replaceAddWithMult right);;
	*)
	let rec replaceAddWithMult exp = 
	let replace exp a b = 
	match exp with
	|Const(single) -> Const(single)
	|Add(left, right) -> Mult(replaceAddWithMult left,replaceAddWithMult right)
	|Sub(left, right) -> Sub(replaceAddWithMult left, replaceAddWithMult right)
	|Mult(left, right) -> Mult(replaceAddWithMult left, replaceAddWithMult right)
	|Div(left, right) -> Div(replaceAddWithMult left, replaceAddWithMult right)
	in
	foldC (Const(0)) (replace) (exp);;


(* 3.5 Define evalC, an evaluator for calculator expressions without using foldC. Eg. evalC e2 should return 3 *)

	(* evalC calcExp -> int *)
	let rec evalC exp = 
	match exp with 
	|Const(single) -> single
	|Add(left, right) -> (evalC left) + (evalC right)
	|Sub(left, right) -> (evalC left) - (evalC right)
	|Mult(left, right) -> (evalC left) * (evalC right)
	|Div(left, right) -> (evalC left) / (evalC right);;
(* so uh this doesn't check for divide by zero but I am lazy to code this in *)


(*3.6 Define evalCf, an evaluator for calculator expressions using foldC. *)

	(* evalCf calcExp -> int *)
	let rec evalCf exp = 
	let replace exp a b = 
	match exp with 
	|Const(single) -> single
	|Add(left, right) -> (evalC left) + (evalC right)
	|Sub(left, right) -> (evalC left) - (evalC right)
	|Mult(left, right) -> (evalC left) * (evalC right)
	|Div(left, right) -> (evalC left) / (evalC right)
	in
	foldC 0 (replace) (exp);;



(*4.1 Explain what this function does: *)
let f xs = 
let g = fun x r -> if x mod 2 = 0 then (+) r 1 else r
in List.fold_right g xs 0;;
(* f: int list -> int *)
(* this function takes in a list of ints and returns how many numbers in the list are even*)

(* This function returns 2: *)
f [1;2;3;4;];;

(* This function returns 0: *)
f [1;3;5;7;9;];;

(* This function returns 6: *)
f [2;2;2;2;2;2;];;

(*4.2 Complete the function *)
	let concat xss =
	let g = fun xs h -> 
	match xs with 
	|[] -> h
	|head::t -> head::t@ h
	in List.fold_right g xss [];;








