open Graph
open Ford
open List
open String
open Gfile
open Tools
open Option
open Scanf

(*Fonction qui lit dans le fichier money et renvoie la liste des sommes payées*)
(*let lecture fichier =
   let channel = open_in fichier in
   let rec lecture_recursive ligne acu =
      try
         let ligne = input_line channel in
         let ligne = split ligne in
         let lecture_ligne ligne =
            match ligne with
            |[] -> acu
            |_::[] -> acu
            |""::_ -> acu
            |nom::somme::_ -> (somme::acu)
         in
         lecture_recursive ligne acu
      with
         End_of_file -> ligne 
   in
      let lignes = lecture_recursive [] [] in
      List.rev (lignes);
      close_in channel*)
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

let rec help liste fin =
   match liste with
   |[] -> liste
   |x::rest -> 
      let elt = split (regexp "[ \t]+") x in 
      help rest (elt::fin)

let rec extraction_somme liste acu =
   match liste with
   |[] -> acu
   |(_,a)::[] -> extraction_somme [] (a::acu)
   |(_,b)::rest -> extraction_somme rest (b::acu)

let affichage liste =
   List.map (fun x -> Printf.printf "%d" x) liste

(*Fonction qui avec un fichier money renvoie la somme totale payée*)
(*let somme_totale fichier =
   let fich = from_file fichier in (*fich est un fichier string*)
   let r file = In_channel.read_lines fich in
   Printf.printf ff "dans le fichier il y a : %s" r
   assert false
*)
   
(*Fonction qui calcule ce qui devait être payé par chacun*)

(*Fonction qui calcule la différence entre ce qui a été payé et ce qui devait être payé pour chacun*)

(*Fonction qui récupère tous les noms des personnes impliquées dans le fichier money et les met sous forme de liste + Création du graphe associé*)
(*let recup_name file graph = (*le graph est vide au lancement*)
  let infile = open_in file in
  let rec loop n names graph =
     try
        let line = input_line infile in
        let (n2, names2, graph2) =
           match (line) with
              | name::_::_ -> (n+1, (name)::names, new_node graph n)
        in
        loop n2 names2 graph2 (* On aura le nombre de personne, les noms sous forme de liste et le graphe associé*)
     with End_of_file -> (List.rev(names),graph) (*ce que ça nous renvoit à la fin*)
     close_in infile;
*)
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
*)
(*
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
  *)