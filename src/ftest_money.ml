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
    let h = Money.help lignes [] in
    (*let line = Money.extraction_somme lignes [] in*)
    let chaine = String.concat "," h in
    Printf.printf "La liste est : %s\n" chaine;
    ();