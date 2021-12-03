open Gfile
open Tools
open Ford
open List
open String
open Option
    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (*graph est un string graph*)
  (*gmap du string graph pour avoir un int graph attendu dans add_arc*)
  (*let node1 = 0 
  and node2 = 3 
  and n = 8 in
  let graph = gmap (add_arc (gmap graph int_of_string) node1 node2 n) string_of_int  in*)
  
  let graph2 = gmap graph int_of_string in
  let algo = algo_ford graph2 source sink in
  (*let liste = trouver_chemin graph2 source sink (source::[]) in
  let rev_liste_int = List.rev liste in
  let liste_string = List.map string_of_int liste in
  let rev_liste_string = List.rev liste_string in
  let chaine = String.concat "," rev_liste_string in
  Printf.printf "Le chemin est : %s\n" chaine;
  let calcul = calcul_variation_flot graph2 rev_liste_int min_chem in
  Printf.printf "Calcul_var_flot donne : %d\n" calcul;
  let maj = maj_graphe_flot graph2 rev_liste_int calcul in*)
  let string_maj = gmap algo string_of_int in
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile string_maj in

  ();
  (*export outfile graph;*)