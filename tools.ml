(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let rec clone_nodes (gr:'a graph) = function
	|[] -> []
	|(a,b)::rest -> (a,None)::(clone_nodes rest)
let gmap gr f = assert false