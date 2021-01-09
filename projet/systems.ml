
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
(* Differente fonction daffichage *)
let rec printWord (word : 's word) : unit=
    match word with
    |Symb s -> print_char s;
    |Seq se -> let rec  printSequence sequence =
      match sequence with
      |[]-> print_string "";
      |y::q-> printWord y;
            printSequence q;
             in printSequence se 

    |Branch w -> print_char '[';
                 printWord w;
                 print_char ']'
;;
(* let rec printWord2 (word : char word) : unit =
    match word with
    |Symb s -> print_string "Symb "; print_char s;
    |Seq se -> print_string "[";
    	let rec  printSequence2 sequence =
      match sequence with
      |[]-> print_string "]";
      |y::q-> printWord2 y; print_string "; ";
            printSequence2 q;
       in printSequence2 se; 

    |Branch w -> print_string "Branch (";
                 printWord2 w;
                 print_string ")"
;; *)
let printSys (s : char system) : unit = printWord s.axiom;;
let rec printList l = match l with
	|[] -> print_string "\n";
	|b::e -> print_char b; print_char ' '; printList e
;;
let rec printListWord l = match l with
	|[] -> print_string "\n";
	|b::e -> printWord b; printListWord e
;;
let rec printListString l = match l with
	|[] -> print_string "\n";
	|b::e -> print_string b; print_string "\n"; printListString e
;;
let rec printListCommand l = match l with
	|[] -> print_string "\n";
	|Turtle.Line(n)::e -> print_string "line "; print_string (string_of_int n); print_string "\n"; printListCommand e
	|Turtle.Move(n)::e -> print_string "move "; print_string (string_of_int n); print_string "\n"; printListCommand e
	|Turtle.Turn(n)::e -> print_string "turn "; print_string (string_of_int n); print_string "\n"; printListCommand e
	|Turtle.Restore::e -> print_string "restore \n"; printListCommand e
	|Turtle.Store::e -> print_string "store \n";  printListCommand e
;;
let rec printAssocRule l = match l with
	|[] -> print_string "\n";
	|(c,s)::e -> print_char c; print_string " "; printWord s; print_string "\n"; printAssocRule e
;;

(* let safe f x = try Some (f x) with _ -> None *)
(*prends un fichier-> l'ouvre-> pour chaque ligne la rajoute dans une liste
on se retrouve avec une liste de string*)
let read_file filename = 
	let lines = ref [] in
	let chan = open_in filename in
	try
  	while true; do
    	lines := input_line chan :: !lines
	done; !lines
	with End_of_file ->
	close_in chan;
	List.rev !lines ;;

let i = ref 0;;

(* prend un string et une liste vide et
return le 's word associé *)
let rec transfo_ax_word (s : string) (l : 's word list) : 's word = 
  i := 1+ !i;
  let o='[' in
  let f=']' in
	if ((!i -1) >= (String.length s)) then Seq (List.rev l)
	else if ((String.get s (!i-1))==o) then 
	    transfo_ax_word s ((Branch (transfo_ax_word s [] ))::l)
	else if ((String.get s (!i-1))==f) then 
    	Seq (List.rev l) 
    else 
	    transfo_ax_word s ((Symb (String.get s (!i-1)))::l) 
;;

(* prends une liste de string la premiere ligne non commenter est l'axiom -> on
va transfomer l'axiom en word avec transfo_ax_word*)
let rec transfo_file_ax l =
    match l with
    |t::q-> if (String.length t > 0) then
                if (not (Char.equal t.[0] '#')) then begin
                    i := 0;
                    transfo_ax_word t []
                    
                end
                else
                    transfo_file_ax q
            else
                transfo_file_ax q
    | []-> failwith "Erreur"
;;
(*couper les 2 premiers characteres d'une string*)
let cut2 (s : string) : string =
	String.sub s 2 ((String.length s)-2)
;;

let cut (s : string) : string =
	String.sub s 1 ((String.length s)-1)
;;


(*prends deux listes et retourne une liste d'association*)
let rec transfo_listAssoc (a:char list) (b:'s word list) (i: int) = 
  let l=[] in
  if i>=List.length a then l else ((List.nth a i),(List.nth b i))::l @ (transfo_listAssoc a b (i+1))
;;

let build_fun l_assoc = 
	fun s -> try List.assoc s l_assoc with Not_found -> Symb s
                                  ;;
let rec transfo_file_ru (l: string list) (a: char list) (b:'s word list) (esp: int)=
    if(esp<0) then build_fun (transfo_listAssoc a b 0) else
    match l with
    |t::q -> if (String.length t > 0) then
                if ((not(Char.equal t.[0] '#')) && (esp == 0)) then begin
                	i := 0;
                	transfo_file_ru q ([t.[0]] @ a) ([(transfo_ax_word (cut2 t) [])] @ b) esp
                end
                else
                	transfo_file_ru q a b esp
            else
            	transfo_file_ru q a b (esp-1)
	|[]-> build_fun (transfo_listAssoc a b 0)
;;
let rec transfo_listAssoc2 (a:char list) (b: Turtle.command list) (i: int) = 
  	let l=[] in
	if i>=List.length a then begin 
		l
	end 
	else ((List.nth a i),[(List.nth b i )])::l @ (transfo_listAssoc2 a b (i+1))
;;
(*faire peut etre une boucle ?*)
    let build_fun2 (l_assoc : (char * Turtle.command list) list)  =
    fun s -> try List.assoc s l_assoc with Not_found ->failwith "rr"
;;

let transfo_cmd (s : string) : Turtle.command list =
  if(String.get s 0)== 'T' then
      [Turtle.Turn (int_of_string(cut s))]
  else
  if (String.get s 0)== 'L' then
      [Turtle.Line ((int_of_string (cut s)))]
  else
  if (String.get s 0)== 'M' then
     [Turtle.Move ((int_of_string (cut s)))]
  else
     failwith "inconnu";;


let rec transfo_file_inter (l: string list) (a: char list) (b: Turtle.command list) (esp: int) =
  match l with
  |t::q-> if (String.length t > 0) then
            if ((not(Char.equal t.[0] '#')) && (esp == 0)) then begin
                transfo_file_inter q (t.[0]::a) ((transfo_cmd (cut2 t))@b) esp
            end
            else
                transfo_file_inter q a b esp
        else
            transfo_file_inter q a b (esp -1)
  |[]-> build_fun2 (transfo_listAssoc2 a b 0) 
;;


 (*l -> read_file f -> le fichier*)
 let transfo_file_in_sys (f : string) : char system =
    let lines = read_file f in
    let axiom= transfo_file_ax lines  in
    let rules= transfo_file_ru lines  [] [] 1 in  
    let interp= transfo_file_inter lines  [] [] 2 in
    {axiom=axiom; rules=rules; interp=interp}
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

(* dessine a partir d'un system *)
let dessinAvecSystem (system : 's system) (pos : Turtle.position) : unit =
	Graphics.clear_graph ();
	Graphics.set_color Graphics.black;
	Graphics.fill_rect 0 0 800 800;
	Graphics.moveto (Float.to_int pos.x) (Float.to_int pos.y);
	Turtle.dessin (transSystInCommand system) pos [] Graphics.magenta
;;

(* ! a appeler avec n qui est iter !*)
let rec repeat_ntimes (system : 's system) (n : int) (pos : Turtle.position) : unit =
    if n>0 then begin 
    	dessinAvecSystem system pos; 
    	ignore (Graphics.wait_next_event [Button_down ; Key_pressed]);
    	repeat_ntimes (rewrite system) (n-1) pos;
    end
    else begin
    	dessinAvecSystem system pos
    end
;;


