open Graph
open Tools

let init graph =
    (*initialiser les flots et D à O*)
    let gr = clone_nodes(graph)
    gmap gr (fun label -> "0"^"/"^string_of_int(label))
    (*ça va renvoyer un string graphe*) 

let rec trouver_chemin graph node1 node2 file =
    (*y a pas encore node1 dans file au début*)
    (* parcours en profondeur*)
    (*pb si boucle*)
    let rec boucle file = utiliser List.mem elt list au lieu de toute la boucle
        match file with
            |[] -> false
            |a::rest -> if a=node1 then true
                        else boucle rest
    in
    if (boucle file) then passer au suivant, ignorer ceux qu'on a déjà vu 
    else
        if node1=node2 then node1::file
        else
            let voisins = out_arcs graph node1 in
            let rec parcours_voisins liste_voisins =
                (*vision récursive de la liste de voisins*)
                (*vérifier si on trouve un chemin par là ou non*)
                match liste_voisins with
                    |[] -> []
                    (*pb si label arc = 0, il ne faut pas le prendre*)
                    |(y,0)::rest -> parcours_voisins rest
                    |(x,_)::rest -> 
                        let chemin = trouver_chemin graph x node2 (x::file) in
                        if chemin=[] then parcours_voisins rest
                        else chemin
            in
            parcours_voisins voisins
(*
let rec calcul_variation_flot graph chemin =
    (*calcule la variation de flot d'un chemin*)
    (*On fait la somme, pour chaque noeud, des flots entrants flots + (capacité - flot sortant) *)
    let min_chemin = Some 100 in
    match chemin with 
        |[] -> min_chemin
        |x::[] -> min_chemin 
        |x::y::rest -> 
            let min_arc = find_arc graph x y in (*de type option*)
            if min_arc > min_chemin then min_chemin = min_arc,
            if min_arc > min_chemin then calcul_variation_flot graph (y::rest)

let maj_graphe_flot graph chemin flot =
    match chemin with
        |[] -> graph
        |x::rest -> 
            let arcs_sortants x = 
    add_arc graph ... ... flot

let algo_ford graph node1 node2 =
    (*Débit de flot*) (*sera un argument de la fonction qu'on donnera à 0 au début et qui bouge à chaque éxécution*)
    (*chercher un chemin de s à p dans graphe
    calculer la variation de flot de ce chemin
    mettre à jour le graphe de flot
    mettre à jour D = D + var_flot
    while jusqu'à ce qu'il n'y est plus de chemin*)
    trouver_chemin graph node1 node2 []*)