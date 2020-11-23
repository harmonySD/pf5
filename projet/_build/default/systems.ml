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



(**let rec printWord word =
    match word with
    |Symb s -> Printf.printf "%s" s;
    |Seq se -> printSeq se;
    |Branch w -> Printf.printf"[";
                 printWord w;
                 Printf.printf"]";

and printSequence sequence =
    match sequence with
    |[]-> failwith "empty"
    |x::[]-> printWord x
    |x::q-> printWord y;
            printSequence q
;;

let rec transfo axiom rules=
	match axiom with
	|Symb x -> match rules with
				|Symb y  when x=y-> Seq y
				|Symb ->
**)