open Money
open Ford
open List
open String
open Option


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

    ();