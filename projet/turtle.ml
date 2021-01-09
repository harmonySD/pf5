(*open Systems *)

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
let printPos (pos : position) : unit = 
	print_string "x= ";
	print_float pos.x;
	print_string "\ny= ";
	print_float pos.y;
	print_string "\na= ";
	print_int pos.a;
	print_string "\n"
;;

let couleur = [Graphics.white; Graphics.red; Graphics.green; Graphics.blue; 
				Graphics.yellow; Graphics.cyan; Graphics.magenta]

(** Put here any type and function implementations concerning turtle *)

(* fonction qui a partir d'une liste de commande va dessiner *)
let rec dessin (listCommande : command list)
	(position : position)
	(l : position list)
	(color : Graphics.color)
	: unit =
	let (nb: int) = Random.int(List.length couleur) in
	match listCommande with
	|[]-> Graphics.set_color (List.nth couleur nb);
	|Line(n)::e ->  Graphics.set_color color;
					let newPos={x=position.x +. (Float.of_int n) *. 
									(cos ((Float.of_int position.a) /.180. *.Float.pi));
								y=position.y +. (Float.of_int n) *. 
									(sin ((Float.of_int position.a) /.180. *.Float.pi));
								a=position.a} in 
					Graphics.lineto (int_of_float (newPos.x)) (int_of_float (newPos.y)); 
					dessin e newPos l ((color + 256) mod 16777215);
	|Move(n)::e ->  let newPos={x=position.x +. (Float.of_int n) *. 
									(cos ((Float.of_int position.a) /.180. *.Float.pi) );
								y=position.y +. (Float.of_int n) *. 
									(sin ((Float.of_int position.a) /.180. *.Float.pi));
								a=position.a} in 
					Graphics.moveto (int_of_float (newPos.x)) (int_of_float (newPos.y)); 
					dessin e newPos l color;
	|Turn(n)::e ->  let newPos={x=position.x;y=position.y;a=n+position.a} 
					in dessin e newPos l color;
	|Store::e -> dessin e position ([position] @ l) color;
	|Restore::e -> dessin e (List.hd l) (List.tl l) color
;;
