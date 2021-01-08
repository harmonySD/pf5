
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
(*couper les 2 premiers characteres d'une string*)
let cut2 s=
  String.sub s 2 ((String.length s)-2)
;;

let cut s=
  String.sub s 1 ((String.length s)-1)
;;

(*prends deux listes et retourne une liste d'association*)
let rec transfo_listAssoc (a:char list) (b:'s word list) (i: int) =
  let l=[] in
  if i>=List.length a then l else ((List.nth a i),(List.nth b i ))::l @ (transfo_listAssoc a b (i+1))
;;

let build_fun l_assoc =  fun s -> try List.assoc s l_assoc
                                  with Not_found -> Symb s
                                  ;;
let rec transfo_file_ru (l: string list) (a: char list) (b:'s word list) (esp: int)=
    if(esp<0) then build_fun (transfo_listAssoc a b 0) else
    match l with
    |t::q -> if (String.length t > 0) then
                if ((not(Char.equal t.[0] '#')) && (esp == 0))then
                 transfo_file_ru q (t.[0]::a) ((transfo_ax_word (cut2 t) [])::b) esp

                else
                  transfo_file_ru q a b esp
             else
                transfo_file_ru q a b (esp-1)
     |[]-> failwith "Erreur transfo_file_rules"
;;
let rec transfo_listAssoc2 (a:char list) (b: Turtle.command list list) (i: int) =
  let l=[] in
  if i>=List.length a then l else ((List.nth a i),(List.nth b i ))::l @ (transfo_listAssoc2 a b (i+1))
;;
(*faire peut etre une boucle ?*)
    let build_fun2 (l_assoc : (char * Turtle.command list) list)  =  fun s -> try List.assoc s l_assoc
                                  with Not_found ->failwith "rr"
;;

let transfo_cmd (s : string) : Turtle.command list =
  if(String.get s 0)== 'T' then
      [Turtle.Turn (int_of_string(cut s))]
  else
  if (String.get s 0)== 'L' then
      [Turtle.Line ((int_of_string (cut s))*30)]
  else
  if (String.get s 0)== 'M' then
     [Turtle.Move ((int_of_string (cut s))*30)]
  else
     failwith "inconnu";;


let rec transfo_file_inter (l: string list) (a: char list) (b: Turtle.command list) (esp: int) =
  if(esp<0) then build_fun2 (transfo_listAssoc2 a [b] 0)  else
  match l with
  |t::q-> if (String.length t > 0) then
              if ((not(Char.equal t.[0] '#')) && (Char.equal t.[1] ' ')) then
                transfo_file_inter q(t.[0]::a) ((transfo_cmd (cut2 t))@b) esp
              else
                transfo_file_inter q a b esp
          else
            transfo_file_inter q a b (esp -1)
  |[]-> failwith "Erreur transfo_file_inter"
;;


 (*l -> read_file f -> le fichier*)
 let transfo_file_in_sys (f : string) : 's system =
    let lines= read_file f in
    (*List.rev lines*)
    let axiom= transfo_file_ax lines  in
    let rules= transfo_file_ru lines  [] [] 1 in
    let interp= transfo_file_inter lines  [] [] 2 in
    {axiom=axiom; rules=rules; interp=interp};;




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
