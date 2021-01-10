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

(* dimension de la figure en terme de position *)
type dimension = {
	xmin : float;
	xmax : float;
	ymin : float;
	ymax : float;
}

(* autre facon pour les dimensions en terme de distance*)
type carre = {
	longueur : float;
	hauteur : float;
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

let printDim (dim : dimension) : unit =
	print_string "xmin= ";
	print_float dim.xmin;
	print_string "\nxmax= ";
	print_float dim.xmax;
	print_string "\n";
	print_string "ymin= ";
	print_float dim.ymin;
	print_string "\nymax= ";
	print_float dim.ymax;
	print_string "\n"
;;
let rec printListPos (l : position list) : unit = match l with
	|[] -> print_string "\n"
	|p::e -> printPos p; printListPos e;
;;

let rec printListCommand (l: command list) : unit = match l with
	|[] -> print_string "\n";
	|Line(n)::e -> print_string "line "; print_string (string_of_int n); print_string "\n"; printListCommand e
	|Move(n)::e -> print_string "move "; print_string (string_of_int n); print_string "\n"; printListCommand e
	|Turn(n)::e -> print_string "turn "; print_string (string_of_int n); print_string "\n"; printListCommand e
	|Restore::e -> print_string "restore \n"; printListCommand e
	|Store::e -> print_string "store \n";  printListCommand e
;;

let couleur = [Graphics.white; Graphics.red; Graphics.green; Graphics.blue; 
				Graphics.yellow; Graphics.cyan; Graphics.magenta]

(** Put here any type and function implementations concerning turtle *)

(* fonction qui a partir d'une liste de commande va dessiner *)
let rec dessin (listCommande : command list)
	(position : position)
	(l : position list)
	(color : Graphics.color)
	(boolean : bool)
	(div : int)
	: unit =
	match listCommande with
	|[]-> Graphics.set_color color;
	|Line(n)::e ->  
				(* choix de la couleur *)
				let col = 
				if (boolean) then begin
					let (nb: int) = Random.int(List.length couleur) in
					(List.nth couleur nb);
				end
				else begin
					color;
				end
				in Graphics.set_color col; 

				Graphics.moveto ((Float.to_int (position.x))/div) ((Float.to_int (position.y))/div);
				(* position a la fin du mouvement *)
				let newPos={x=position.x +. (Float.of_int n) *. 
							(cos ((Float.of_int position.a) /.180. *.Float.pi));
							y=position.y +. (Float.of_int n) *. 
							(sin ((Float.of_int position.a) /.180. *.Float.pi));
							a=position.a} in 
				Graphics.lineto ((Float.to_int (newPos.x))/div) ((Float.to_int (newPos.y))/div);
				dessin e newPos l ((color + 256) mod 16777215) boolean div;

	|Move(n)::e ->  Graphics.moveto ((Float.to_int (position.x))/div) ((Float.to_int (position.y))/div);
					let newPos={x=position.x +. (Float.of_int n) *. 
									(cos ((Float.of_int position.a) /.180. *.Float.pi));
								y=position.y +. (Float.of_int n) *. 
									(sin ((Float.of_int position.a) /.180. *.Float.pi));
								a=position.a} in 
					Graphics.moveto ((Float.to_int (newPos.x))/div) ((Float.to_int (newPos.y))/div);
					dessin e newPos l color boolean div;

	|Turn(n)::e ->  let newPos={x=position.x;y=position.y;a=n+position.a} 
					in dessin e newPos l color boolean div;
	|Store::e -> dessin e position ([position] @ l) color boolean div;
	|Restore::e -> dessin e (List.hd l) (List.tl l) color boolean div
;;

(* dessin sans reduction pour connaitre les dimensions du dessin *)
let rec tailleDiminution (listCommande : command list)
	(position : position)
	(l : position list)
	(dim : dimension)
	: dimension =
	match listCommande with
	|[]-> dim
	|Line(n)::e -> Graphics.moveto ((Float.to_int (position.x))) ((Float.to_int (position.y)));
					let newPos={x=position.x +. (Float.of_int n) *. 
								(cos ((Float.of_int position.a) /.180. *.Float.pi));
							y=position.y +. (Float.of_int n) *. 
								(sin ((Float.of_int position.a) /.180. *.Float.pi));
							a=position.a} in 
					Graphics.moveto (Float.to_int (newPos.x)) (Float.to_int (newPos.y));
					let newDim={xmin=(min dim.xmin newPos.x); xmax=(max dim.xmax newPos.x);
								ymin=(min dim.ymin newPos.y) ;ymax=(max dim.ymax newPos.y)}
					in
					tailleDiminution e newPos l newDim;

	|Move(n)::e ->  Graphics.moveto ((Float.to_int (position.x))) ((Float.to_int (position.y)));
					let newPos={x=position.x +. (Float.of_int n) *. 
								(cos ((Float.of_int position.a) /.180. *.Float.pi) );
							y=position.y +. (Float.of_int n) *. 
								(sin ((Float.of_int position.a) /.180. *.Float.pi));
							a=position.a} in 
					Graphics.moveto (Float.to_int (newPos.x)) (Float.to_int (newPos.y)); 
					let newDim={xmin=(min dim.xmin newPos.x); xmax=(max dim.xmax newPos.x);
								ymin=(min dim.ymin newPos.y) ;ymax=(max dim.ymax newPos.y)}
					in
					tailleDiminution e newPos l newDim;

	|Turn(n)::e ->  let newPos={x=position.x;y=position.y;a=n+position.a} 
					in tailleDiminution e newPos l dim;
	|Store::e -> tailleDiminution e position ([position] @ l) dim;
	|Restore::e -> tailleDiminution e (List.hd l) (List.tl l) dim
;;