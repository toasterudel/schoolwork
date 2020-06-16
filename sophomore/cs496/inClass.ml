(* succl :: int list -> int list *)

let rec succl xs =
  match xs with 
  | [] -> []
  | x::xs -> (x+1) :: succl xs;;


let rec upperl xs = 
	match xs with
	| [] -> []
	| x::xs -> (Char.uppercase x) :: upperl xs

let rec map f = function
	|[] -> []
	|y::ys -> f y :: map f ys

let succl' xs = map (fun x -> x+1) xs
let upperl' xs = map Char.uppercase xs


(* ALSO VALID: 
let rec succl xs =
	let f x = x+1
	in match xs with 
  	| [] -> []
  	| y::ys -> f y :: succl ys;;
*)



let rec gtzl xs = 
	match xs with 
	| [] -> []
	| x::xs ->
		if x> 0 then x::gtzl xs
		else gtzl xs

(* filter :: ( 'a->bool) -> 'a list -> 'a list *)
let rec filter p = function
	| [] -> []
	| x ::xs ->
		if p x
		then x:: filter p xs
		else filter p xs

let gtzl' xs = filter (fun x -> x>0) xs
let emptyl' xs = filter (fun x-> x!=[]) xs


