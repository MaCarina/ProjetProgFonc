val init: 'a graphe -> 'b graph

val trouver_chemin: 'a graph -> id -> id -> 'b 

val calcul_variation_flot: 'b -> int 

val maj_graphe_flot: 'a graph -> 'b -> int -> 'b graph

val algo_ford: 'a graph -> 'b graph (*utilise les fonctions chemin et calcul_var_flot*)