
(** Words, rewrite systems, and rewriting *)

type 's word =
  | Symb of 's
  | Seq of 's word list
  | Branch of 's word

type 's rewrite_rules = 's -> 's word

type 's system = {
    axiom : 's word;
    rules : 's rewrite_rules;
    interp : 's -> Turtle.command list }

(** Put here any type and function implementations concerning systems *)


(*let rec printWord (word : 's word) : unit=
    match word with
    |Symb s -> Printf.printf "%s" s;
    |Seq se -> let rec  printSequence sequence =
      match sequence with
      |[]-> failwith "empty"
      |y::q-> printWord y;
            printSequence q;
             in printSequence se 

    |Branch w -> Printf.printf"[";
                 printWord w;
                 Printf.printf"]"
;;*)

(* rewrite -> return a new system but axiom is changed in relation with his rules*)
let rewrite (system : 's system) : 's system =
    let rec rewrite_word w =
      match w with
      |Symb s-> (try system.rules s with Not_found -> Symb s)
      |Seq se-> let rec rewrite_word_Seq se = match se with
        |[]->[]
        |t::q-> [rewrite_word t] @ (rewrite_word_Seq q)
        in Seq(rewrite_word_Seq se)
      |Branch b-> rewrite_word b
      in
  {axiom=(rewrite_word system.axiom); rules = system.rules; interp=system.interp}

;;


(* fonction qui a partir d'un system va renvoyer une list de commande *)
let transSystInCommand (syst : 's system) : Turtle.command list  = 
	let rec transWordInCommand w = match w with
		|Symb(s) -> syst.interp s
		|Branch (b) -> [Turtle.Store] @ transWordInCommand b @ [Turtle.Restore]
		|Seq(l) -> let rec transSeqInCommand seq = match seq with
			|[] -> []
			|h::e -> (transWordInCommand h) @ (transSeqInCommand e)
		in transSeqInCommand l
	in transWordInCommand syst.axiom
;;

(* dessine a partir d'un system *)
let dessinAvecSystem (system : 's system) (pos : Turtle.position) (color : Graphics.color) 
				(boolean : bool) (dim : Turtle.dimension) : Turtle.dimension =
	Graphics.clear_graph ();
	Graphics.set_color Graphics.black;
	Graphics.fill_rect 0 0 700 700;
	(* (* Turtle.printPos pos; *)
	print_string "\n";
	print_string "\n"; *)
	(* dimension du dessin sans toucher a la taille du dessin *)
	let newDim = Turtle.tailleDiminution (transSystInCommand system) pos [] dim 
	(* just avoir la hauteur et la longueur de la figure *)
	in let carre = {Turtle.longueur= (newDim.xmax -. newDim.xmin); 
					Turtle.hauteur=(newDim.ymax -. newDim.ymin)} 
	(* diviser la taille de chaque segment pour entrer dans la fenetre *)
	in let div = if (dim.xmax-.dim.xmin=0. && dim.ymax-.dim.ymin=0.) then 1
				else if (dim.xmax-.dim.xmin=0.) then 
						(Float.to_int (Float.round (carre.hauteur/.(dim.ymax-.dim.ymin))))
				else if (dim.ymax-.dim.ymin=0.) then 
						(Float.to_int (Float.round (carre.longueur /. (dim.xmax -. dim.xmin))))
				else max (Float.to_int (Float.round (carre.longueur /. (dim.xmax -. dim.xmin)))) 
				(Float.to_int (Float.round (carre.hauteur /. (dim.ymax -. dim.ymin))))
	(* trouver le bon depart pour que la figure soit entierement dans la fenetre *)
	in let x = if ((newDim.xmin/.(Float.of_int div))-.100. <= 0.) then begin
					pos.x-.(newDim.xmin) +.100.
				end
			else if ((newDim.xmax/.(Float.of_int div))+.100. >=(Float.of_int (Graphics.size_x ()))) then begin 
					pos.x-.(newDim.xmax-.(Float.of_int (Graphics.size_x ()))) -.100.
				end
			else begin
				pos.x
				end 
	in let y = if ((newDim.ymin/.(Float.of_int div))-.100. <= 0.) then begin
					pos.y-.(newDim.ymin) +.100.
				end
			else if ((newDim.ymax/.(Float.of_int div))+.100. >= (Float.of_int (Graphics.size_y ()))) then begin 
					pos.y-.(newDim.ymax-.(Float.of_int (Graphics.size_y ()))) -.100.
				end
			else begin
				pos.y
				end 
	in let newPosDepart = {Turtle.x=x; Turtle.y=y; Turtle.a=pos.a}
	in
	(* Turtle.printDim newDim;
	Turtle.printPos newPosDepart;
	print_string "\n";
	print_string "\n"; *)
	Graphics.moveto ((Float.to_int newPosDepart.x)/div) ((Float.to_int newPosDepart.y)/div); 
	Turtle.dessin (transSystInCommand system) newPosDepart [] color boolean div;
	if ((dim.xmax -. dim.xmin) = 0. || (dim.ymax -. dim.ymin = 0.)) then newDim
	else dim
;;

(* ! a appeler avec n qui est iter !*)
let rec repeat_ntimes (system : 's system) (n : int) (pos : Turtle.position) 
				(color : Graphics.color) (boolean : bool) (dim : Turtle.dimension) : unit =
    if n>0 then begin 
    	let newDim = dessinAvecSystem system pos color boolean dim; 
    	in ignore (Graphics.wait_next_event [Button_down ; Key_pressed]);
    	repeat_ntimes (rewrite system) (n-1) pos color boolean newDim
    end
    else begin
    	let newDim = dessinAvecSystem system pos color boolean dim;
    	in Graphics.set_color Graphics.black
    end
;;


