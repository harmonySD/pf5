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



let rec printWord word =
    match word with
    |Symb s -> Printf.printf "%s" s;
    |Seq se -> printSequence se;
    |Branch w -> Printf.printf"[";
                 printWord w;
                 Printf.printf"]";

and printSequence sequence =
    match sequence with
    |[]-> failwith "empty"
    |x::[]-> printWord x
    |y::q-> printWord y;
            printSequence q
;;

let rewrite system=
    let rec rewrite_word w =
      match w with
      |Symb s-> (try system.rules s with Not_found -> Symb s)
      |Seq se-> let rec rewrite_word_Seq se = match se with
        |[]->[]
        |t::q-> [rewrite_word t] @ (rewrite_word_Seq q)
        in Seq(rewrite_word_Seq se)
      |Branch b-> rewrite_word b
      in
  {axiom=(rewrite_word system.axiom); rules = system.rules}

;;




