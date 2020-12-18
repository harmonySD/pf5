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

(** Put here any type and function interfaces concerning systems *)
(*val set_iter : int -> unit*) 
val transfo : string -> 's word list -> 's word

val transfo_file_in_sys : string -> 's system
val rewrite : 's system -> 's system
val repeat_ntimes : 's system -> int -> 's system
val transSystInCommand : 's system -> Turtle.command list  
