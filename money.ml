open Str
open Graph
open Tools
open Ford


(*Fonction qui avec un fichier money renvoie la somme totale payée*)

(*Fonction qui calcule ce qui devait être payé par chacun*)

(*Fonction qui calcule la différence entre ce qui a été payé et ce qui devait être payé pour chacun*)

(*Fonction qui récupère tous les noms des personnes impliquées dans le fichier money et les met sous forme de liste*)

(*Fonction qui crée un graphe avec les noms des personnes issus de la liste précédente*)

(*Fonction qui crée des arcs de capacité infinie entre chaque noeud*)

(*Fonction qui change le flot en fonction des remboursements d'argent calculés*)




let sort_negat ff names debt id1 id2 =
   match (current_flow debt id1 id2) with
      | Some c -> if c <= 0 
         then Printf.fprintf ff ""
         else Printf.fprintf ff "\"%s\" -> \"%s\" [label = \"%s\"];\n" names.((id1-2)) names.((id2-2)) (string_of_int(c)^"/inf")
      | None -> Printf.fprintf ff ""

let print_arcs ff names debt id1 id2 lbl =
   match (id1,id2,lbl) with
      | 0,n,f -> Printf.fprintf ff "\"source\" -> \"%s\" [label = \"%s\"];\n" names.((n-2)) (string_of_flow f)
      | n,1,f -> Printf.fprintf ff "\"%s\" -> \"target\" [label = \"%s\"];\n" names.((n-2)) (string_of_flow f)
      | n1,n2,_ -> sort_negat ff names debt n1 n2


let export_debt (path: string) ((names,debt): (string array * flow graph)) =

  (* Open a write-file. *)
  let ff = open_out path in

  (* Write in this file. *)
  Printf.fprintf ff "digraph diagram_out{\n   rankdir=LR;\n   size=\"8,5\"\n   node [shape = circle];\n" ;

  (* Write all arcs *)
  e_iter debt (print_arcs ff names debt);

  Printf.fprintf ff "\n}" ;
  
  close_out ff ;
  ()