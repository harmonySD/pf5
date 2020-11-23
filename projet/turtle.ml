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

let transformWordInCommand 
	(word : 's word) 
	: 's command =
;;

let dessin (listeCommande :'s command)
	(position : position)
	: unit =
	match listeCommande with
	|[]->
	|Line(n)::e -> moveto position.x*(cos position.a) position.y*(sin position.a) ; 
					dessin e position
	|Move(n)::e -> lineto position.x*(cos position.a) position.y*(sin position.a) ; 
					dessin e position
	|Turn(n)::e -> position.a <- n; dessin e position
	|Store::e ->
	|Restore::e ->
;;