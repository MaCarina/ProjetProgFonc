val init: 'a graphe -> 'b graph

val trouver_chemin: 'a graph -> id -> id -> 'b list

val calcul_variation_flot: 'a graph -> 'b list -> int 

val maj_graphe_flot: 'a graph -> 'b list -> int -> 'b graph

val algo_ford: 'a graph -> 'b graph (*utilise les fonctions chemin et calcul_var_flot*)