open Money
open Ford
open List
open String
open Option
open Gfile
open Tools


let () =

    if Array.length Sys.argv <> 3 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : money file\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;

    let infile = Sys.argv.(1)
    and outfile = Sys.argv.(2)
    in
    (*
    let lignes = Money.lecture infile in
    let somme = extraction_somme lignes [] in
    List.map (fun x -> Printf.printf "int : %d, " x) somme;
    let nom = extraction_nom lignes [] in
    Printf.printf "\n";
    affichage nom;
    Printf.printf "\n";
    let calcul = somme_totale somme 0 in
    Printf.printf "Somme totale : %d\n" calcul;
    *)
    let de = dette infile in
    let graph = crea_graphe infile in
    (*let h = Money.split lignes [] in
    (*let line = Money.extraction_somme lignes [] in*)
    let chaine = String.concat "," h in
    Printf.printf "La liste est : %s\n" chaine;*)
    (*let liste = [10;10;40] in
    let somme = somme_totale liste 0 in
    Printf.printf "la somme est : %d" somme;*)
    let () = write_file outfile graph in
    ();