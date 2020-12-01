open Graphics

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

(** Put here any type and function implementations concerning turtle *)

(* let transformWordInCommand (syst : command list) 
	: command list  =[]
;; *)

(* let dessin (listCommande : command list)
	(position : position)
	: unit =
	(* position en degre -> mettre en radian *)
	match listCommande with
	|[]-> unit ();
	|Line(n)::e -> moveto (int_of_float (position.x *. (cos (position.a)))) (int_of_float (position.y*.(sin (position.a)))) ; 
					dessin e position;
	|Move(n)::e -> lineto (int_of_float (position.x *. (cos (position.a)))) (int_of_float (position.y*.(sin (position.a)))) ; 
					dessin e position;
	|Turn(n)::e -> position.a <- n; dessin e position
	|Store::e -> unit ();
	|Restore::e -> unit ();
;; *)