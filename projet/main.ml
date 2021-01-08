
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


let usage = (* Entete du message d'aide pour --help *)
  "Interpretation de L-systemes et dessins fractals"

let action_what () = Printf.printf "%s\n" usage; exit 0

let cmdline_options = [
("--what" , Arg.Unit action_what, "description");
("-i" , Arg.Int set_iter, "how many iteration");
("-s", Arg.String set_str, "insert a .sys file");
]

let extra_arg_action = fun s -> failwith ("Argument inconnu :"^s)

let close_after_event () =
  ignore (Graphics.wait_next_event [Button_down ; Key_pressed])

let test1 =[Line 30;Turn 60;Turn 60;Line 30;Turn 60;Turn 60; Line 30];;
let test2 =[Line 30; Turn (-60); Line 30; Turn 60; Turn 60; Line 30; Turn (-60); Line 30;Turn 60;Turn 60;
			Line 30; Turn (-60); Line 30; Turn 60; Turn 60; Line 30; Turn (-60); Line 30;Turn 60;Turn 60;
			Line 30; Turn (-60); Line 30; Turn 60; Turn 60; Line 30; Turn (-60); Line 30];;


let position={x=300.;y=300.;a=0};;





let l2=transSystInCommand Examples.snow;;


let main () =
	Arg.parse cmdline_options extra_arg_action usage;
	(* print_string "Pour l'instant je ne fais rien\n"; *)
	Graphics.open_graph " 800x800";
	Graphics.clear_graph ();

	Graphics.moveto 300 300;

	(*let system= transfo_file_in_sys !str in;*)
	

	(*let newSnow = repeat_ntimes Examples.snow !iter in dessin (transSystInCommand newSnow) position [];*)
    (*let fig= repeat_ntimes system in dessin (transSystInCommand system) position []*)
	
	(*dessin l position [];*)
	(* clear_graph(); *)
	(* synchronize(); *)

	close_after_event ()

(** On ne lance ce main que dans le cas d'un programme autonome
    (c'est-à-dire que l'on est pas dans un "toplevel" ocaml interactif).
    Sinon c'est au programmeur de lancer ce qu'il veut *)

let () = if not !Sys.interactive then main ()
