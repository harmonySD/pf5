(* open Systems *)

(** Turtle graphical commands *)
type command =
| Line of int      (** advance turtle while drawing *)
| Move of int      (** advance without drawing *)
| Turn of int      (** turn turtle by n degrees *)
| Store            (** save the current position of the turtle *)
| Restore          (** restore the last saved position not yet restored *)

(** Position and angle of the turtle *)
type position = {
  x: float;        (** position x *)
  y: float;        (** position y *)
  a: int;          (** angle of the direction *)
}

(* dimension dune figure *)
type dimension = {
	xmin : float;
	xmax : float;
	ymin : float;
	ymax : float;
}

(* longeur et hauteur dune figure *)
type carre = {
	longueur : float;
	hauteur : float;
}
(** Put here any type and function signatures concerning turtle *)

val printPos : position -> unit
val printDim : dimension -> unit
val printListCommand : command list -> unit
val dessin : command list -> position -> position list -> Graphics.color -> bool -> int -> unit 
val tailleDiminution : command list -> position -> position list -> dimension -> dimension 
