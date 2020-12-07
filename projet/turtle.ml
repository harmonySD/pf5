
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


let printPos pos=print_string "x= ";
	print_float pos.x;
	print_string "\ny= ";
	print_float pos.y;
	print_string "\na= ";
	print_int pos.a;
	print_string "\n"
;;

(** Put here any type and function implementations concerning turtle *)

(* let transformWordInCommand (syst : command list) 
	: command list  =[]
;; *)

let rec dessin (listCommande : command list)
	(position : position)
	: unit =
	(* position en degre -> mettre en radian *)
	match listCommande with
	|[]-> print_string "[]\n";
		  Graphics.set_color Graphics.black;
	|Line(n)::e ->  print_string "Line\n";
					let newPos={x=position.x +. (Float.of_int n) *. (cos ((Float.of_int position.a) /.180. *.Float.pi) );
								y=position.y +. (Float.of_int n) *. (sin ((Float.of_int position.a) /.180. *.Float.pi));
								a=position.a} in 
					Graphics.lineto (int_of_float (newPos.x)) (int_of_float (newPos.y)); 
					printPos newPos;
					dessin e newPos;
	|Move(n)::e ->  print_string "Move\n";
					let newPos={x=position.x +. (Float.of_int n) *. (cos ((Float.of_int position.a) /.180. *.Float.pi) );
								y=position.y +. (Float.of_int n) *. (sin ((Float.of_int position.a) /.180. *.Float.pi));
								a=position.a} in 
					Graphics.moveto (int_of_float (newPos.x)) (int_of_float (newPos.y)); 
					printPos newPos;
					dessin e newPos;
	|Turn(n)::e ->  print_string "Turn\n";
					let newPos={x=position.x;y=position.y;a=n+position.a} 
					in printPos newPos; dessin e newPos
	|Store::e -> Graphics.set_color Graphics.red;
	|Restore::e -> Graphics.set_color Graphics.magenta;
;;

(* let coucou i= Graphics.lineto i i
;; *)