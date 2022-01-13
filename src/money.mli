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
   val affichage: (string * int) list -> unit list
   val lecture: string -> string list
   val extraction_somme: string list -> int list -> int list
   val extraction_nom: string list -> string list -> string list
   val liste_paire: string list -> int list -> (string * int) list
   val somme_totale: int list -> int -> int
   val dette: string -> (string * int) list
   val crea_graphe: string -> int graph
   val crea_edge: string -> int graph
   val link: string -> int graph -> int -> int graph
   val application: string -> int graph -> int graph