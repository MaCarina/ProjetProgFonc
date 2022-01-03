(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = 
    (*créer un graphe vide, parcourir le graphe donné en argument grâce à un itérateur et ajouter les 
    noeuds au nouveau graphe*)
    n_fold gr (fun acu node -> new_node acu node) empty_graph 
    
let gmap gr f =
    e_fold gr (fun acu node1 node2 label -> new_arc acu node1 node2 (f label)) (clone_nodes gr)
    (*on part du graphe gr qui a seulement les noeuds et on lui ajoute les arcs auxquels on a appliqué f*)

let add_arc gr node1 node2 n =
    (*si l'arc n'existe pas, il faut le créer*)(*si l'arc existe, il faut ajouter n au label de l'arc*)
    let option_label_arc = find_arc gr node1 node2 in
    match option_label_arc with
        |None -> new_arc gr node1 node2 n
        |Some k -> new_arc gr node1 node2 (n+k)
    