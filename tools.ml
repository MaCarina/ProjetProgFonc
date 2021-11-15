(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = 
    (*créer un graphe vide, parcourir le graphe donné en argument grâce à un itérateur et ajouter les 
    noeuds au nouveau graphe*)
    n_fold gr (new_node empty_graph id) empty_graph
    
let gmap gr f = 
    e_fold gr (f )