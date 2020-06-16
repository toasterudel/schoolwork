(*
*	Christopher Rudel
*	CS 496B
* 	HW2
*	I pledge my honor that I have abided by the Stevens Honor System
*
*)

(* #1. Define dTree, an algebraic type in OCaml which encodes binary decision trees as depicted 
	in Fig 1. The names of the two constructors should be Leaf and Node*)
type dTree = Leaf of int | Node of char*dTree*dTree;;


(* #2 Define two expressions, tLeft and tRight, of type dTree that represent each of the two
	trees in Fig. 1. *)

let tLeft = Node('w', Node('x', Leaf(2), Leaf(5)), Leaf(8));;
let tRight = Node('w', Node('x', Leaf(2), Leaf(5)), Node('y', Leaf(7), Leaf(5)));;

(* #3 *)
(* (a) dTree_height: that given a dTree returns its height. *)

(* dTree_height: dTree -> int *)
let rec dTree_height tree = 
match tree with
Leaf(x) -> 0
|Node(ch, left, right) -> 1 + max(dTree_height left) (dTree_height right);;

(* (b) dTree_size: that given a dTree returns its size. The size of a dTree consists of the
	number of nodes and leaves. *)

(* dTree_size: dTree -> int *)
let rec dTree_size tree = 
match tree with 
Leaf(x) -> 1
|Node(ch, left, right) -> 1+ dTree_size left + dTree_size right;;

(* (c) dTree_paths: that given a dTree returns a list with all the paths to its leaves. A
	path is a list of digits in the set {0, 1} such that if we follow it on the tree, it
	leads to a leaf. The order in which the paths are listed is irrelevant *)
let appLeft xs = 
[0]@xs;;

let appRight xs = 
[1]@xs;;

let rec dTree_paths tree = 
match tree with
Leaf(x) -> [[]]
|Node(ch, left, right) -> List.map (appLeft) (dTree_paths left)@ List.map (appRight) (dTree_paths right);;


(* (d) dTree_is_perfect: that determines whether a dTree is perfect. A dTree is said to be
	perfect if all leaves have the same depth. *)

(* dTree_is_perfect: dTree-> bool *)
let rec dTree_is_perfect tree = 
match tree with
Leaf(x) -> true
|Node(ch, left, right) -> dTree_height left = dTree_height right;;

(* (e) dTree_map: that given the following arguments f: char -> char
g: int -> int
t: dTree
returns a new dTree resulting from t by applying f to the characters in each node
and g to the numbers in each leaf*)

(* dTree_map : (char -> char) -> (int -> int) -> dTree -> dTree *)
let rec dTree_map f g t = 
match t with
Leaf(x) -> Leaf(g x)
|Node(ch, left, right) -> Node(f ch, dTree_map f g left, dTree_map f g right);;


(* #4. Define list_to_tree, a function that given a list of characters l, creates a tree in which
	the symbols of an inner node at level n corresponds to the n-th element in l. The
	value of all of its leaves may be set to 0. *)

(*list_to_tree : char list -> dTree *)
let rec list_to_tree xs = 
match xs with
[] -> Leaf(0)
|h::t -> Node(h, list_to_tree t, list_to_tree t);;


(* #5. Define replace_leaf_at, a function that given a tree t and a graph for a function f,
	replaces all the leaves in t by the value indicated in the graph of the function *)

(* #6. Define a function bf_to_dTree that takes a pair-encoding of a boolean function and
	returns its tree-encoding. Note that, depending on the order in which the formal
	parameters are processed, there may be more than one possible tree-encoding for a
	given pair-encoding. You may return any of them. *)

(* If these are blank I couldn't figure them out*)


