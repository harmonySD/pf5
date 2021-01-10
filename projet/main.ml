
open Lsystems (* Librairie regroupant le reste du code. Cf. fichier dune *)
open Systems (* Par exemple *)
open Turtle

(** Gestion des arguments de la ligne de commande.
    Nous suggérons l'utilisation du module Arg
    http://caml.inria.fr/pub/docs/manual-ocaml/libref/Arg.html
*)
let iter = ref 0
let set_iter i= iter := i

let str= ref ""
let set_str st= str := st

(* col = int en hexadecimal : 0xRRGGBB *) 
let color = ref Graphics.white
let setColor col= color :=col
 
(* pour choisir si on prend a partir tu tableau de couleur ou rien *)
let boolean = ref false


let usage = (* Entete du message d'aide pour --help *)
  "Interpretation de L-systemes et dessins fractals"

let action_what () = Printf.printf "%s\n" usage; exit 0

let cmdline_options = [
("--what" , Arg.Unit action_what, "description");
("-i" , Arg.Int set_iter, "how many iteration");
("-c" , Arg.Int setColor, "which color");
("-b" , Arg.Set boolean, "tab or nothing");
("-s", Arg.String set_str, "insert a .sys file");
]

let extra_arg_action = fun s -> failwith ("Argument inconnu :"^s)

let close_after_event () =
  ignore (Graphics.wait_next_event [Button_down ; Key_pressed])

(* TEST *)
let test1 =[Line 30;Turn 60;Turn 60;Line 30;Turn 60;Turn 60; Line 30];;
let test2 =[Line 30; Turn (-60); Line 30; Turn 60; Turn 60; Line 30; Turn (-60); Line 30;Turn 60;Turn 60;
			Line 30; Turn (-60); Line 30; Turn 60; Turn 60; Line 30; Turn (-60); Line 30;Turn 60;Turn 60;
			Line 30; Turn (-60); Line 30; Turn 60; Turn 60; Line 30; Turn (-60); Line 30];;

let position={x=50.;y=50.;a=0};;
let dimension={xmin=700.;xmax=0.;ymin=700.;ymax=0.;}

type symbol = A|B|P|M

let dragon : symbol system =
  let a = Symb A in
  let b = Symb B in
  let p = Symb P in
  let m = Symb M in
  {
    axiom = Seq [a];
    rules =
      (function
       | A -> Seq [a;p;b;p]
       | B -> Seq [m;a;m;b]
       | s -> Symb s);
    interp =
      (function
       | A -> [Line 600]
       | B -> [Line 600]
       | P -> [Turn 90]
       | M -> [Turn (-90)])
  }
type sybol = A|B|P 
let br1 : sybol system =
  let a = Symb A in
  let b = Symb B in
  let p = Symb P in
  {
    axiom = Seq [a];
    rules =
      (function
       | A -> Seq [a;Branch(Seq [b;a]);a;Branch(Seq[p;a]);a]
       | s -> Symb s);
    interp =
      (function
       | A -> [Line 300]
       | B -> [Turn 25]
       | P -> [Turn (-25)])
  }

(* let l2=transSystInCommand Examples.snow;; *)

let main () =
	Arg.parse cmdline_options extra_arg_action usage;
	(* print_string "Pour l'instant je ne fais rien\n"; *)
	Graphics.open_graph " 700x700";
	Graphics.set_window_title "L-Systeme";
	Graphics.clear_graph ();
	Graphics.set_color Graphics.black;
	Graphics.fill_rect 0 0 700 700;
(* 
	let l = transSystInCommand Examples.snow
	in let dim = tailleDiminution l position [] dimension
	in printDim dim;
	print_string "\n";
	let l2 = transSystInCommand (rewrite Examples.snow)
	in let dim2 = tailleDiminution l2 position [] dimension
	in printDim dim2;
	print_string "\n";
	let l3 = transSystInCommand (rewrite (rewrite Examples.snow))
	in let dim3 = tailleDiminution l3 position [] dimension
	in printDim dim3;
	print_string "\n";
	let l4 = transSystInCommand (rewrite (rewrite (rewrite Examples.snow)))
	in let dim4 = tailleDiminution l4 position [] dimension
	in printDim dim4;
	print_string "\n";
	let l5 = transSystInCommand (rewrite (rewrite (rewrite (rewrite Examples.snow))))
	in let dim5 = tailleDiminution l5 position [] dimension
	in printDim dim5; *)

	let newDim = tailleDiminution (transSystInCommand dragon) position [] dimension
	in 
	let system = transfo_file_in_sys !str 
	in 
	repeat_ntimes system !iter position !color !boolean newDim;
	(* let newSnow = repeat_ntimes Examples.snow !iter in dessin (transSystInCommand newSnow) position []; *)

	(* let system = transfo_file_in_sys !str	
	in 
	let fig = repeat_ntimes system !iter
	in  
	dessin (transSystInCommand fig) position []; *)
	
	(*let newSnow = repeat_ntimes Examples.snow !iter in dessin (transSystInCommand newSnow) position [];*)
    
	(*dessin l position [];*)
	(* clear_graph(); *)
	(* synchronize(); *)
	close_after_event ()

(** On ne lance ce main que dans le cas d'un programme autonome
    (c'est-à-dire que l'on est pas dans un "toplevel" ocaml interactif).
    Sinon c'est au programmeur de lancer ce qu'il veut *)

let () = if not !Sys.interactive then main ()
