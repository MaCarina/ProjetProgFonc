open Graph
open Ford
open List
open String
open Gfile
open Tools
open Option
open Int

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

let liste_paire liste_nom liste_somme =
   List.combine liste_nom liste_somme

(*Fonction qui calcule la somme totale payée avec les int d'une liste*)
let rec somme_totale liste somme =
   match liste with
   |[] -> somme
   |a::[] -> somme_totale [] (a+somme)
   |b::rest -> somme_totale rest (b+somme)
   
(*Fonction qui calcule ce qui devait être payé par chacun*)
let dette fichier = 
   let lignes = lecture fichier in
   let somme = extraction_somme lignes [] in
   let nom = extraction_nom lignes [] in
   let calcul = somme_totale somme 0 in
   let m = calcul / (List.length somme) in
   List.map (fun (n,d) -> (n,(d-m))) (liste_paire nom somme)

(*Fonction qui crée le graphe avec comme noeud les elts d'une liste*)
let crea_graphe fichier =
   let lignes = lecture fichier in
   let liste = extraction_nom lignes [] in
   let graph = new_node empty_graph 0 in (*0 est la source*)
   let graph2 = new_node graph ((List.length liste)+1) in (*4 est le puit*)
   let rec creation_graphe graph num =
      match num with
      |0 -> graph
      |a -> creation_graphe (Graph.new_node graph a) (num-1)
   in
      creation_graphe graph2 (List.length liste)

(*Fonction qui crée des arcs de capacité infinie entre chaque noeud*)
let crea_edge fichier =
   let gr = crea_graphe fichier in
   let rec edge graph max n =
      match (((max+1)=n)||(n=0)||(n=4)) with
      |false -> edge (Graph.n_fold graph (fun graph x -> if (x=n) then graph 
                                                         else if (x=0) then graph
                                                         else if (x=4) then graph
                                                         else Tools.add_arc graph x n Int.max_int) graph) max (n+1)
      |true -> graph
   in
      edge gr 3 1

(*Fonction qui relie les noeuds à la source et au puit en fonction de leur dette*)
let link fichier graph n =
   let lignes = lecture fichier in
   let somme = extraction_somme lignes [] in
   let nom = extraction_nom lignes [] in
   let liste = liste_paire nom somme in
   let rec link_rec graph a list =
      match list with
      |[] -> graph
      |(_,s)::rest -> if (s<0) then link_rec (Tools.add_arc graph 4 n (-s)) (n+1) rest
                     else link_rec (Tools.add_arc graph 0 n s) (n+1) rest
   in
      link_rec graph n liste
(*
(* Fonction qui crée la source et la destination *)
let graph = creation_graphe extraction_nom clone_nodes in
let (extraction_nom, graph) = lecture path graph in
(* Graphe de retour *)
(Array.of_list(List.rev (List.fold_left (fun l (n,_) -> n::l) [] extraction_nom)), (algo_ford graph 0 1))
*)

(*Fonction qui change le flot en fonction des remboursements d'argent calculés*)