open Graph
open Ford
open List
open String
open Gfile
open Tools
open Option
open Scanf

(*Fonction qui lit dans le fichier money et renvoie la liste des sommes payées*)
let lecture fichier =
   let channel = open_in fichier in
   let rec lecture_recursive ligne =
      try
         Scanf.fscanf channel "%[^\r\n]\n" (fun x -> lecture_recursive (x :: ligne))
      with 
         End_of_file -> ligne
   in
   let ligne = lecture_recursive [] in
   close_in channel;
   List.rev (List.map int_of_string ligne)

let rec split liste fin =
   match liste with
   |[] -> liste
   |x::rest -> 
      let elt = split (regexp "[ \t]+") x in 
      split rest (elt::fin)

let rec extraction_somme liste acu =
   match liste with
   |[] -> acu
   |(_,a)::[] -> extraction_somme [] (a::acu)
   |(_,b)::rest -> extraction_somme rest (b::acu)

let affichage liste =
   List.map (fun x -> Printf.printf "%d" x) liste

(*Fonction qui calcule la somme totale payée avec les int d'une liste*)
let rec somme_totale liste somme =
   match liste with
   |[] -> somme
   |a::[] -> somme_totale [] (a+somme)
   |b::rest -> somme_totale rest (b+somme)
   
(*Fonction qui calcule ce qui devait être payé par chacun*)

(*Fonction qui calcule la différence entre ce qui a été payé et ce qui devait être payé pour chacun*)

(*Fonction qui récupère tous les noms des personnes impliquées dans le fichier money et les met sous forme de liste + Création du graphe associé*)
let recup_name file graph = (*le graph est vide au lancement*)
   let liste = lecture file in
   let liste_split = split liste [] in
   let rec extraction_nom list acu =
      match list with
      |[] -> acu
      |(a,_)::[] -> extraction_nom [] (a::acu)
      |(b,_)::rest -> extraction_nom rest (b::acu)
   in
   ...

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