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
(*
let transfo graph_ford node1 node2 =
    let clone_graph = clone_nodes graph_ford in
    let rec boucle graph =
        let chemin = trouver_chemin graph node1 node2 (node1::[]) in
        match chemin with
            |[] -> graph
            |x::[] -> graph
        (*faire les arcs arrières, réfléchir à qui on augmente et qui on diminue. Les arcs sont orientés: id1 id2 correspond à celui de 1 vers 2*)
            |x::y::rest -> 
                let arc_ford = find_arc graph y x in
                match arc_ford with
                    |None -> graph
                    |Some a -> let graph_flot = add_arc clone_graph x y arc_ford in 
                            boucle graph_flot
    in
        boucle clone_graph

let transfo graph_ford node =
    let graph_transfo = clone_nodes graph_ford in
    let rec boucle graph node1 =
        let y = out_arcs graph node1 in
        let rec parcours voisins =
            match voisins with
            |[] -> []
            |(x,l)::rest -> boucle (new_arc graph node1 y l) y
                (*let lab = find_arc graph_ford node1 x in
                match lab with
                |None -> boucle graph y
                |Some l -> boucle (new_arc graph node1 y l) y*)
    in
        boucle graph_transfo node
*)
let transfo graph_ford node =
    let graph_transfo = clone_nodes graph_ford in
    let y = out_arcs graph_transfo node in
    let rec boucle graph node1 =
        match y with
        |[] -> []
        |(x,l)::rest -> boucle (new_arc graph node1 x l) x
    in
        boucle graph_transfo node