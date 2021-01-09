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

val cut2 : string -> string
val cut : string -> string
val transfo_cmd : string -> Turtle.command list
val transfo_file_inter : string list -> char list -> Turtle.command list -> int -> char -> Turtle.command list
val transfo_file_in_sys : string -> char system
val rewrite : 's system -> 's system
val repeat_ntimes : 's system -> int -> 's system
val transSystInCommand : 's system -> Turtle.command list  
