
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


(*let rec printWord (word : 's word) : unit=
    match word with
    |Symb s -> Printf.printf "%s" s;
    |Seq se -> let rec  printSequence sequence =
      match sequence with
      |[]-> failwith "empty"
      |y::q-> printWord y;
            printSequence q;
             in printSequence se 

    |Branch w -> Printf.printf"[";
                 printWord w;
                 Printf.printf"]"
;;*)


let safe f x = try Some (f x) with _ -> None
(*prends un fichier-> l'ouvre-> pour chaque ligne la rajoute dans une liste
on se retrouve avec une liste de string*)
let read_file f=
  let fi = open_in f in
  let rec loop n l =
  match safe input_line fi with
  |None -> l
  |Some _ -> loop (n+1) ((input_line fi)::l)
  in
  loop 0 [""]
;;

let i = ref 0;;

(* prend un string et une liste vide et 
return le 's word associé *)
let rec transfo_ax_word (s : string) (l : 's word list) : 's word = 
  print_int !i;
  i := 1+ !i;
  let o='[' in
  let f=']' in
	if ((!i -1) >= (String.length s)) then Seq (List.rev l)
	else if ((String.get s (!i-1))==o) then begin
    transfo_ax_word s ((Branch (transfo_ax_word s [] ))::l)
    end
	else if ((String.get s (!i-1))==f) then begin
    Seq (List.rev l) 
    end
  else begin
    transfo_ax_word s ((Symb (String.get s (!i-1)))::l) 
    end
;;

(* prends une liste de string la premiere ligne non commenter est l'axiom -> on
va transfomer l'axiom en word avec transfo_ax_word*)
let rec transfo_file_ax l =
    match l with
    |t::q-> if (String.length t > 0) then
                if (not (Char.equal t.[0] '#')) then
                    transfo_ax_word t []
                else
                    transfo_file_ax q
            else
                failwith "Erreur"
    | []-> failwith "Erreur"
;;
let in_func a b =
    for i = 0 to (List.length a) - 1 do

    let func =(function |c -> List.nth b i ) in func
    done;
;;


let rec transfo_file_ru l a b n=
    if(n<0) then rin_func a b else
    match l with
    |t::q -> if (String.length t > 0) then
                if ((not(Char.equal t.[0] '#')) && (Char.equal t.[1] ' '))then
                 transfo_file_ru q (t.[0]::a) ([transfo_ax_word (cut t) []]@b) n

                else
                  transfo_file_ru q a b n
             else
                transfo_file_ru q a b (n-1)
     |[]-> failwith "Erreur transfo_file_rules"
;;
 (*l -> read_file f -> le fichier*)
let transfo_file_in_sys (f : string) : 's system =
    let lines= read_file f in
    List.rev lines
    let axiom= transfo_file_ax lines in
    (*let rules= transfo_file_ru lines  [] [] 1 in
    let interp= transfo_file_inter lines  [] [] 2in
    {axiom=axiom; rules=rules; interp=interp}*)
;;




(* rewrite -> return a new system but axiom is changed in relation with his rules*)
let rewrite (system : 's system) : 's system =
    let rec rewrite_word w =
      match w with
      |Symb s-> (try system.rules s with Not_found -> Symb s)
      |Seq se-> let rec rewrite_word_Seq se = match se with
        |[]->[]
        |t::q-> [rewrite_word t] @ (rewrite_word_Seq q)
        in Seq(rewrite_word_Seq se)
      |Branch b-> rewrite_word b
      in
  {axiom=(rewrite_word system.axiom); rules = system.rules; interp=system.interp}

;;

(* ! a appeler avec n qui est iter !*)
let rec repeat_ntimes (system : 's system) (n : int) : 's system =
    if n<=0 then system
    else repeat_ntimes (rewrite system) (n-1);
;;


(* fonction qui a partir d'un system va renvoyer une list de commande *)
let transSystInCommand (syst : 's system) : Turtle.command list  = 
	let rec transWordInCommand w = match w with
		|Symb(s) -> syst.interp s
		|Branch (b) -> transWordInCommand b
		|Seq(l) -> let rec transSeqInCommand seq = match seq with
			|[] -> []
			|h::e -> (transWordInCommand h) @ (transSeqInCommand e)
		in transSeqInCommand l
	in transWordInCommand syst.axiom
;;
