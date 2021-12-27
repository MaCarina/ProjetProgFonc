 open Graph

val trouver_chemin: int graph -> id -> id -> int list -> int list

val calcul_variation_flot: int graph -> int list -> int -> int

val maj_graphe_flot: int graph -> int list -> int -> int graph

val algo_ford: int graph -> int -> int -> int graph (*utilise les fonctions chemin et calcul_var_flot*)

val transfo: int graph -> int -> int graph