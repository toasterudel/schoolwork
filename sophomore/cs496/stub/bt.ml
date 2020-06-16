
module type Tree = 
sig
  type 'a t
  val create: unit-> 'a t
  val node: 'a->'a t -> 'a t -> 'a t
  val empty: 'a t->bool
  val elem: 'a -> 'a t -> bool
  val mapt: ('a -> 'a) -> 'a t -> unit
  val string_of_tree:('a -> string) -> 'a t -> string
end

module MyTree: Tree = 
struct

  type 'a nodet= {mutable data: 'a; mutable left: ('a nodet) ref option; mutable right: ('a nodet) ref option;} 

  type 'a t = {mutable root: ('a nodet) ref option;
	mutable size: int}


let create () = { root = None; size =0}
let node x lt rt = {root = Some (ref{data=x;left = lt.root; right = rt.root});
		   size = 1+lt.size + rt.size}
let empty t = t.root=None
let elem x t=
    let rec elemn x = function
    | None -> false
    | Some r-> !r.data=x || elemn x(!r.left) || elemn x (!r.right)
  in elemn x t.root
let mapt f t = 
    let rec maptn f = function
	|None-> ()
	|Some r-> !r.data <- f (!r.data);
	maptn f (!r.left);
	maptn f (!r.right);
    in maptn f t.root

let string_of_tree f t = 
    let rec string_of_node f = function
	|None -> ""
	|Some r -> (f (!r.data)) ^ string_of_node f (!r.left) 
		^ string_of_node f (!r.right)
    in string_of_node f t.root

end
