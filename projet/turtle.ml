open Systems *)

type command =
| Line of int
| Move of int
| Turn of int
| Store
| Restore

type position = {
  x: float;      (** position x *)
  y: float;      (** position y *)
  a: int;        (** angle of the direction *)
}

(* fonction pour afficher une position *)
let printPos pos=print_string "x= ";
	print_float pos.x;
	print_string "\ny= ";
	print_float pos.y;
	print_string "\na= ";
	print_int pos.a;
	print_string "\n"
;;

(** Put here any type and function implementations concerning turtle *)

(* fonction qui a partir d'un system va renvoyer une list de commande *)
let rec transformSystInCommand (syst : 's system) 
	: command list  = 
	let rec transWordInCommand w = match w with
		|Symb(s) -> [syst.interp s]
		|Branch (b) -> [transWordInCommand b]
		|Seq(l) -> let rec transSeqInCommand seq = match seq with
			|[] -> []
			|h::e ->[transWordInCommand h]@ (transSeqInCommand e)
		in [transSeqInCommand l]
	in [transWordInCommand syst.axiom]
;;

(* fonction qui a partir d'une liste de commande va dessiner *)
let rec dessin (listCommande : command list)
	(position : position)
	(l : position list)
	: unit =
	(* position en degre -> mettre en radian *)
	match listCommande with
	|[]-> Graphics.set_color Graphics.black;
	|Line(n)::e ->  let newPos={x=position.x +. (Float.of_int n) *. 
									(cos ((Float.of_int position.a) /.180. *.Float.pi));
								y=position.y +. (Float.of_int n) *. 
									(sin ((Float.of_int position.a) /.180. *.Float.pi));
								a=position.a} in 
					Graphics.lineto (int_of_float (newPos.x)) (int_of_float (newPos.y)); 
					dessin e newPos l;
	|Move(n)::e ->  let newPos={x=position.x +. (Float.of_int n) *. 
									(cos ((Float.of_int position.a) /.180. *.Float.pi) );
								y=position.y +. (Float.of_int n) *. 
									(sin ((Float.of_int position.a) /.180. *.Float.pi));
								a=position.a} in 
					Graphics.moveto (int_of_float (newPos.x)) (int_of_float (newPos.y)); 
					dessin e newPos l;
	|Turn(n)::e ->  let newPos={x=position.x;y=position.y;a=n+position.a} 
					in dessin e newPos l;
	|Store::e -> dessin e position ([position] @ l);
	|Restore::e -> dessin e (List.hd l) (List.tl l)
;;
