 (* Nous calculons l'argent que se doivent 2 personnes et pour cela nous lisons les différents paiement qui les relient*)

(* Notre format de fichier pour l'utiliser:  :
   Name1 MoneyPaid1\n
   Name2 MoneyPaid2\n
   ....
   NameN MoneyPaidN
   *)
   open Graph
   open Ford
   
   (**************  ALGORITHM  **************)
   val lecture: string -> string list
   val help: string list -> string list -> string list
   val extraction_somme: ('a*'b) list -> 'b list -> 'b list
   val affichage: int list -> unit list
   (* Echanges de paiements et recherche du flot de débit de chacun *)
   (*
   val debt : string -> (string array * flow graph)
   (* Export *)
   val export_debt : string -> (string array * flow graph) -> unit*)