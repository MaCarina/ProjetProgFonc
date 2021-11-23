open Graph
open Tools

let init graph = assert false
    (*initialiser les flots et D à O*)

let rec trouver_chemin graph node1 node2 file =
    (*y a pas encore node1 dans file au début*)
    (* parcours en profondeur*)
    if node1=node2 then node1::file
    else
        let voisins = out_arcs graph node1 in
        let rec parcours_voisins liste_voisins =
            (*vision récursive de la liste de voisins*)
            (*vérifier si on trouve un chemin par là ou non*)
            match liste_voisins with
                |[] -> []
                |x::rest -> if (trouver_chemin graph x node2 (x::file))=[] then parcours_voisins rest
                            else (trouver_chemin graph x node2 (x::file)) (*à modifier*)
            (*appel à parcours_voisins*)
            (*finir la fonction rec en syntaxe*)

let calcul_variation_flot chemin = assert false
    (*calcule la variation de flot d'un chemin*)

let maj_graphe_flot graph chemin flot = assert false

let algo_ford graph = assert false
    (*chercher un chemin de s à p dans graphe
    calculer la variation de flot de ce chemin
    mettre à jour le graphe de flot
    mettre à jour D = D + var_flot
    while jusqu'à ce qu'il n'y est plus de chemin*)