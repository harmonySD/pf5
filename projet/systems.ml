
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
		|Branch (b) -> transWordInCommand b
		|Seq(l) -> let rec transSeqInCommand seq = match seq with
			|[] -> []
			|h::e -> (transWordInCommand h) @ (transSeqInCommand e)
		in transSeqInCommand l
	in transWordInCommand syst.axiom
;;

(* dessine a partir d'un system *)
let dessinAvecSystem (system : 's system) (pos : Turtle.position) : unit =
	Graphics.clear_graph ();
	Graphics.set_color Graphics.black;
	Graphics.fill_rect 0 0 800 800;
	Graphics.moveto (Float.to_int pos.x) (Float.to_int pos.y);
	Turtle.dessin (transSystInCommand system) pos [] Graphics.magenta
;;

(* ! a appeler avec n qui est iter !*)
let rec repeat_ntimes (system : 's system) (n : int) (pos : Turtle.position) : unit =
    if n>0 then begin 
    	dessinAvecSystem system pos; 
    	ignore (Graphics.wait_next_event [Button_down ; Key_pressed]);
    	repeat_ntimes (rewrite system) (n-1) pos;
    end
    else begin
    	dessinAvecSystem system pos
    end
;;


