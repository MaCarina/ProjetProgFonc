open Graph
open Tools

let rec trouver_chemin graph node1 node2 file =
    (*on met node1 dans la file au début*)
    (* parcours en profondeur*)
    (*Modifier pour ne pas explorer où flot=capa*)
    if node1 = node2 then file
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
                    if (List.mem x file) then parcours_voisins rest (*pb si boucle*)
                    else 
                        let chemin = trouver_chemin graph x node2 (x::file) in
                        if chemin=[] then parcours_voisins rest
                        else chemin
        in
        parcours_voisins voisins

 let rec calcul_variation_flot graph chemin min_chemin = (*on commence avec un chiffre grand pour min_chemin*)
    (*calcule la variation de flot d'un chemin*)
    (*On fait la somme, pour chaque noeud, des flots entrants flots + (capacité - flot sortant) *)
    match chemin with 
        |[] -> min_chemin
        |x::[] -> min_chemin 
        |x::y::rest -> 
            let min_arc = find_arc graph x y in (*de type option*) (*renvoie label =int*)
            match min_arc with
                |None -> failwith ("L'arc de "^(string_of_int x)^" à "^(string_of_int y)^" n'existe pas\n")
                |Some a -> if a < min_chemin then calcul_variation_flot graph (y::rest) a
                            else calcul_variation_flot graph (y::rest) min_chemin

let rec maj_graphe_flot graph chemin flot =
    (*va raugmenter de "flot" tout les flot de "chemin" dans  le "graph"*)
    match chemin with
        |[] -> graph
        |x::[] -> graph
    (*faire les arcs arrières, réfléchir à qui on augmente et qui on diminue. Les arcs sont orientés: id1 id2 correspond à celui de 1 vers 2*)
        |x::y::rest -> let graphmajmoins = add_arc graph x y (-flot) in 
                        let graphmajplus = add_arc graphmajmoins y x flot in
                        (maj_graphe_flot graphmajplus (y::rest) flot)
(* de 1 vers 2 on a sur larc capa-flot et sur 2 vers 1 on met flot. Ici on veut dimuniuer le premier et augmenter le deuxième*)

let algo_ford graph node1 node2 =
    let rec boucle graph =
        let chemin = trouver_chemin graph node1 node2 (node1::[]) in
        match chemin with
            |[] -> graph
            |x::rest ->
                let rev_chemin = List.rev chemin in
                let calcul = calcul_variation_flot graph rev_chemin 100 in
                let maj = maj_graphe_flot graph rev_chemin calcul in
                boucle maj
    in 
        boucle graph

        (*On veut transformer un graphe d'écart en graphe de flots*)
let transfo graph_ford graph_transfo = (*graph_ford = graph initial et graph_transfo = graph après fonction ford*)
    e_fold graph_ford (fun graph node1 node2 m ->
        match (find_arc graph_transfo node1 node2) with
        |None -> failwith "arc non trouvé"
        |Some l -> if ((m-l) >= 0) then new_arc graph node1 node2 l
                    else new_arc graph node1 node2 m
    )
    (clone_nodes graph_ford)