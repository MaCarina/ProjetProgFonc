type D = int (*Flot de débit*)

let init graph = 
    (*initialiser les flots et D à O*)
    clone_nodes(graph)
    gmap(gr,fun label->0) (* Soucis ici je pense parce qu'on met une valeur sur un arc et non pas un truc au format .../...*)
    let D = 0 (*par définition D vaut 0 puisque tout les flots vallent 0*)

let trouver_chemin graph node1 node2 = assert false
    

let calcul_variation_flot chemin = assert false
    (*calcule la variation de flot d'un chemin*)
    (*On fait la somme, pour chaque noeud, des flots entrants flots + (capacité - flot sortant) *)


let maj_graphe_flot graph chemin flot = assert false
    (*On remplace les flots du chemin choisi en incrémentant ce chemin du plus petit flot du chemin*)


let algo_ford graph = assert false
    (*chercher un chemin de s à p dans graphe
    calculer la variation de flot de ce chemin
    mettre à jour le graphe de flot
    mettre à jour D = D + var_flot
    while jusqu'à ce qu'il n'y est plus de chemin*)