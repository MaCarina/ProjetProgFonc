open Graph
open Ford
open List
open String
open Gfile
open Tools
open Option
open Scanf

let affichage liste =
   List.map (fun x -> Printf.printf "elt : %s, " x) liste

(*Fonction qui lit dans le fichier money et renvoie la liste des sommes payées*)
let lecture fichier =
   let channel = open_in fichier in
   let lect sous =
      try
         let line = input_line channel in
         let sous = String.split_on_char ' ' line in (*sub est la liste de chaque elt séparé par un espace dans le fichier*)
         match sous with
         |[] -> []
         |_ -> sous
      with End_of_file -> sous
   in
   let sous = lect [] in
   close_in channel;
   sous

let extraction_somme liste liste_somme =
   let liste_s = filter (fun x -> x<"9999") liste in
   List.map (fun x -> int_of_string x) liste_s

(*Fonction qui récupère tous les noms des personnes impliquées dans le fichier money et les met sous forme de liste*)
let extraction_nom liste liste_nom =
   let liste_n = filter (fun x -> (x>"A") && (x<"Z")) liste in
   liste_n

(*Fonction qui calcule la somme totale payée avec les int d'une liste*)
let rec somme_totale liste somme =
   match liste with
   |[] -> somme
   |a::[] -> somme_totale [] (a+somme)
   |b::rest -> somme_totale rest (b+somme)
   

(*Fonction qui calcule la différence entre ce qui a été payé et ce qui devait être payé pour chacun*)
(* Fonction qui calcule ce qui devait être payé par chacun *)
let dette path = (*pas sure du deuxième argument là*)
   let m = (List.fold_left somme_totale extraction_nom 0)/(List.length extraction_nom) in
   let dette_perso = List.map (fun (n,d) -> (n,(d-m))) extraction_nom in

(*Fonction qui crée le graphe avec comme noeud les elts d'une liste*)
let rec creation_graphe liste graph =
   match liste with
   |[] -> graph
   |a::[] -> Graph.new_node graph a
   |b::rest -> creation_graphe rest (Graph.new_node graph b)
   in
      ...

(* Fonction qui crée la source et la destination *)
let graph = creation_graphe extraction_nom clone_nodes in
let (extraction_nom, graph) = lecture path graph in
(* Graphe de retour *)
(Array.of_list(List.rev (List.fold_left (fun l (n,_) -> n::l) [] extraction_nom)), (algo_ford graph 0 1))

(*Fonction qui crée des arcs de capacité infinie entre chaque noeud*)

(*Fonction qui change le flot en fonction des remboursements d'argent calculés*)

(*
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
  ()*)