open Money
open Ford
open List
open String
open Option
open Gfile
open Tools


let () =

    if Array.length Sys.argv <> 2 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : money file\n") ;
      exit 0
    end ;

    let infile = Sys.argv.(1) in
    let lignes = Money.lecture infile in
    let somme = extraction_somme lignes [] in
    List.map (fun x -> Printf.printf "int : %d, " x) somme;
    let nom = extraction_nom lignes [] in
    Printf.printf "\n";
    affichage nom;
    (*let h = Money.split lignes [] in
    (*let line = Money.extraction_somme lignes [] in*)
    let chaine = String.concat "," h in
    Printf.printf "La liste est : %s\n" chaine;*)
    (*let liste = [10;10;40] in
    let somme = somme_totale liste 0 in
    Printf.printf "la somme est : %d" somme;*)
    ();