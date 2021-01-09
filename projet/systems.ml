
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



let rec printWord (word : 's word) : unit=
    match word with
    |Symb s -> print_char s;
    |Seq se -> let rec  printSequence sequence =
      match sequence with
      |[]-> print_char ' ';
      |y::q-> printWord y;
            printSequence q;
             in printSequence se; 

    |Branch w -> print_char '[';
                 printWord w;
                 print_char ']'
;;

let printSys (s : char system) : unit = printWord s.axiom;;

let rec printList l = match l with
	|[] -> print_string "\n";
	|b::e -> print_char b; print_char ' '; printList e
;;
let rec printListWord l = match l with
	|[] -> print_string "\n";
	|b::e -> printWord b; printListWord e
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
(* let rec printAssocInterp l = match l with
	|[] -> print_string "\n";
	|(c,s)::e -> print_char c; print_string " "; printCo s; print_string "\n"; printAssocRule e
;; *)
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
let rec transfo_listAssoc (a:char list) (b:'s word list) (i: int) = print_string "listAssoc\n"; 
	printList a; printListWord b;
  let l=[] in
  if i>=List.length a then l else ((List.nth a i),(List.nth b i))::l @ (transfo_listAssoc a b (i+1))
;;

let build_fun l_assoc = print_string "build\n"; printAssocRule l_assoc;   
	fun s -> try List.assoc s l_assoc with Not_found -> Symb s
                                  ;;
let rec transfo_file_ru (l: string list) (a: char list) (b:'s word list) (esp: int)=
    if(esp<0) then build_fun (transfo_listAssoc a b 0) else
    match l with
    |t::q -> if (String.length t > 0) then
                if ((not(Char.equal t.[0] '#')) && (esp == 0)) then begin
                	print_string "list a \n";
                	printList a;
                	print_string "list b \n";
                	printListWord b;
                	print_string "ligne \n";
                	print_string t;
                	print_string "\n";
                	print_string "cut \n";
                	let couper = cut2 t in
                	print_string couper;
                	print_string "\n";
                	print_string "tarnsfo \n";
                	printWord (transfo_ax_word couper []);
                	print_string "\n";
                	transfo_file_ru q ([t.[0]] @ a) ([(transfo_ax_word couper [])] @ b) esp
                end
                else
                	transfo_file_ru q a b esp
            else
            	transfo_file_ru q a b (esp-1)
	|[]-> build_fun (transfo_listAssoc a b 0)
;;
let rec transfo_listAssoc2 (a:char list) (b: Turtle.command list) (i: int) = 
	(* print_int (i); print_int (List.length b); print_string "\n"; *)
  	let l=[] in
	if i>=List.length a then begin 
		(* print_string "i>=length a\n"; *)
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
      [Turtle.Line ((int_of_string (cut s))*30)]
  else
  if (String.get s 0)== 'M' then
     [Turtle.Move ((int_of_string (cut s))*30)]
  else
     failwith "inconnu";;


let rec transfo_file_inter (l: string list) (a: char list) (b: Turtle.command list) (esp: int) =
  match l with
  |t::q-> (* print_string t; 
  			print_string "\n";
  			print_int (String.length t);
  			print_string "\n";
  			print_int esp;
  			print_string "\n"; *)
  		if (String.length t > 0) then
            if ((not(Char.equal t.[0] '#')) && (esp == 0)) then begin
              	(* print_string "list a \n";
                printList a;
                print_string "list b \n";
                printListCommand b;
                print_string "ligne \n";
                print_string t;
                print_string "\n";
                print_string "cut \n";
                print_string (cut2 t);
                print_string "\n"; *)
                transfo_file_inter q (t.[0]::a) ((transfo_cmd (cut2 t))@b) esp
            end
            else
                transfo_file_inter q a b esp
        else
            transfo_file_inter q a b (esp -1)
  |[]-> build_fun2 (transfo_listAssoc2 a b 0) 
;;

let rec printListString l = match l with
	|[] -> print_string "\n";
	|b::e -> print_string b; print_string "\n"; printListString e
;;


 (*l -> read_file f -> le fichier*)
 let transfo_file_in_sys (f : string) : char system =
    let lines = read_file f in
    let axiom= transfo_file_ax lines  in
    print_string "axiom \n";
    let rules= transfo_file_ru lines  [] [] 1 in  
    print_string "rules\n";  
    let interp= transfo_file_inter lines  [] [] 2 in
    print_string "interp\n";
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
