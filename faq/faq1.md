Programmation Fonctionnelle, Questions/Réponses Semaine 1
=========================================================

Pierre Letouzey (@irif.fr), avec l'aide précieuse d'un scribe anonyme (merci à elle ou lui)

# Organisation

### Page du cours ?

Dernières infos sur le cours : https://gaufre.informatique.univ-paris-diderot.fr/letouzey/pf5/
Lien court vers la même page : http://frama.link/pf5

Cette page est en fait un dépôt git, possibilité d'en voir l'historique des changements,
et même d'en récupérer une copie locale et de la mettre à jour (`git clone ...` puis des
`git pull`, on en reparlera).

### Suivi des étudiants ?

Inscrivez vous au moodle même s'il a pas prévu pour l'instant de s'en servir.
Inscrivez vous aussi à la mailling liste.
Dans les deux cas, détails en haut de la page du cours.

### Début des TP ?

Les TP commencent la semaine du 14/9. Amener vos PC si possible pour les TP, au moins au début.

### Qu'est que ces séances par visioconf ?

Les scéances à distances du mercredi et jeudi midi sont des séances de questions-réponses, pas des cours magistraux.
Lire les documents de cours (slides ou demo "sketch") mis à disposition chaque semaine.

Pas d'enregistrement de ces séances pour l'instant, mais probablement un fichier FAQ du style de celui-ci quelques jours après.

Possible de poser aussi des questions sur la mailing-list l3.pf5.info ou par mail direct

Sentez vous libre sur la séance à assister, vous pouvez même assister aux deux séances si vous le voulez. Tant que le système visio tient la charge...
Du moment que vous pouvez poser vos questions, tout est good. Pas forcément besoin de venir de la première à la dernière minute.

L'url utilisé pour ces séances changera sans doute au cours du semestre (p.ex. version de BBB avec authentification). Soyez vigilants.


### Notation du cours ?

Pour l'instant, l'évaluation du cours est toujours prévu 70% Examen + 30% Projet.
Examen en décembre ou début janvier. Soutenances de projet à ce moment-là.
Session2 : max(Exam2, 70% Exam2 + 30% Projet). A confirmer selon les conditions.

### Projet ?

Sujet du projet toujours en construction.

Idéalement il y aura une soutenance autour de début janvier où on vient avec son code et on l'explique. Sur place ou par visio, selon les possibles.

# OCaml, versions, installations ...

### Quoi installer sur sa machine ?

Pour les premiers TP, un navigateur web et du wifi suffiront, TPs sur une plateforme dédié :
LearnOCaml, http://pf5.ddns.net , merci de respecter les consignes d'utilisation données sur la page du cours
(choix de son pseudo, token à ne pas perdre, etc).

Au besoin, on peut aussi utiliser OCaml en ligne sur http://try.ocamlpro.org (accès libre).

Plus tard, pour des TP plus avancés et pour le projet, il y aura besoin d'une installation locale (avec compilateur, etc etc).
On fera le point à ce moment-là.

### Quelle version d'OCaml ? 

Oui le prof utilise encore souvent OCaml 4.05 (version fournie par `sudo apt install ocaml` sur certaines Debian et Ubuntu).
Cela suffit largement pour débuter. Mais quelques petits détails peuvent changer dans les versions plus récentes, en particulier
dans la librairie standard fournie. On en reparlera, mais au minimum cela pourra aider que les binômes d'un projet utilisent la
même version.

# Pourquoi la programmation fonctionnelle ?

### Un principe clé de la programmation fonctionnelle

Penser par équation mathématique, et donc par *réécriture*. Cela permet de s'abstraire des détails d'implémentation machine (instructions bas niveau, mémoire, etc). 

Par exemple, si `f` est `fun x -> x + 1`, alors `f 3` vaut `(fun x -> x+1) 3` qui vaut `3+1` qui vaut `4`.

Voir aussi l'exemple du tri dans les slides (syntaxe idéalisée pour l'instant) : 
`tri(x puis L) = (tri L filtré sur les nombre < x) ++ x ++ (L filtré tri sur les nombre > x)`
C'est une équation récursive. Pas besoin de savoir où sont ces listes en mémoire.

Gain : raisonnement bien plus facile pour se convaincre que le code est bon, pas d'état caché ou loin ou modifiable par autrui dans notre dos.

### En fonctionnel, des fonctions prises au sérieux ! 

On peut recevoir en argument des fonctions (p.ex. pour écrire une composition de fonction)

Le typage est ici une aide précieuse. Il est *inféré* par le système (mais on pourra *déclarer* des types en plus, ou des signatures) plus tard

```ocaml
fun f x -> f x;; (* ici on ne sait pas si les types 'a (entrée de f) et 'b (sortie de f) sont identiques. *)

fun f x -> f (f x);; (* ici on sait que les types 'a (entrée de f) et 'b (sortie de f) sont identiques. *)
```

### Manipulation de données structurées

Notion clé, l'immutabilité : une structure immutable ne change plus jamais une fois créée ! Mais on peut accéder à une sous-partie, ou bien faire une structure dérivée réutilisant tout ou partie. Quand une structure n'est plus accessible, récupération mémoire automatique.

La programmation fonctionnelle est très adaptée pour manipuler des données structurées, des langages, de la logique, des arbres, graphes, etc, etc.


### Est-ce répandu ?

Cf plus bas pour la dissémination d'OCaml ou d'autres langages fonctionnels comme Haskell.

Au delà, la plupart des langages de programmation modernes proposent maintenant des idées venant de la programmation fonctionnelle (clôtures en Java, 8 p.ex). Car ces idées aident le programmeur !

Voir aussi Scala par exemple pour faire du fonctionnel tout en restant compatible avec la JVM et les bibliothèques Java.

L'intéret de la programmation fonctionnelle est de pouvoir raisonner/ prouver du code car on s'abstrait de l'état de la machine.

Ce serait pas mal de relire le document introductif à la fin du semestre pour se donner un avis sur la programmation fonctionnelle, une fois l'avoir pratiqué.

# Pourquoi OCaml ?

### Déjà, où ne *pas* mettre OCaml ?

Dans les avions et autres endroits "embarqués", en général : pas de garanties sur la quantité de mémoire utilisée, et la gestion automatique de mémoire (ramasse-miette, alias "garbage collector", GC) entraîne des micro-pauses de temps en temps, donc pas de garanties "temps-réel".

Par contre OCaml est tout indiqué pour des outils permettant d'analyser, raisonner, valider du code critique (avionique, etc). 
Voir par exemple https://ocaml.org/learn/success.html#The-ASTR-E-Static-Analyzer

### A part ça, un langage généraliste mais axé fonctionnel dès le départ !

OCaml propose également de l'impératif (on parle aussi de style déclaratif, voir plus tard les "références", les tableaux mutables, etc).
Et de la programmation objet (que l'on utilisera pas ici), de l'asynchrone, etc. Citation anonyme : "Enfin on peut presque tout faire en Caml".

Pour nous c'est surtout un langage où le style fonctionnel est mis en avant dès le début, avec du typage fort et des structures de données immutables par défaut. Mais sans être aussi radical dans ces choix qu'un langage fonctionnel "pur" comme Haskell.


### OCaml est surtout utilisé pour la recherche ?

C'est la réputation de ce langage, "un truc d'universitaire". Comme souvent avec les idées reçues, il y a un fond de vérité, voir par exemple l'usage d'OCaml dans des outils logiques comme [Coq](https://coq.inria.fr). Mais on est maintenant bien au delà de ça, voir par exemple https://ocaml.org/learn/success.html . En particulier beaucoup de start-up ou même d'entreprises déjà bien établies embauchant des programmeurs OCaml, même en île-de-france. 


# Syntaxe OCaml

### Pourquoi ces `;;` ?

`;;` permet de finir les phrases mais OCaml est intelligent et on aura plus besoin de mettre de ";;" lorsque l'on apprendra a utiliser les `let`.
Pour l'instant, dans le doute, mettre partout ces `;;` partout.

### Plusieurs styles pour écrire des fonctions nommées ?

Les deux phrases suivantes sont compris 100% pareil par OCaml:

```ocaml
let identity = fun x -> x
let identity x = x
```	

Idem pour les quatres suivantes :

```ocaml
let f x y = x + y
let f x = fun y -> x + y
let f = fun x y -> x + y
let f = fun x -> fun y -> x + y
```

La préférence du prof : en général, aller au plus court, donc les arguments à gauche du `=`.

### Appel de fonction sans parenthèse ?

Tant que l'argument est "simple" (une constante ou bien une variable), l'usage est de ne *pas* parenthéser,
juste mettre un blanc. Mettre des parenthèses ne seraient pas une erreur, juste un style un peu lourd.
Par contre, pour un argument plus complexe (lui-même un calcul, appel de fonction, etc), les parenthèses
sont nécessaires pour désambiguer.

```ocaml
let f x = 2 * x;;
let c = 3;;

f 5;;  (* argument constant *)
f c;; (* argument : une variable *)
f c + f 5;;
f(c) + f(5);; (* possible aussi, mais pas "idiomatique" en OCaml *)
f (c + f 5);; (* les parenthèses changent radicalement le sens de cette expression, resultat 26 au lieu de 16 *) 
```

Tout ceci vaut également pour les fonctions à plusieurs arguments : `f 1 2` ou `f x y` mais `f (x+1) y`.
Dans cette dernière expression, les parenthères sont indispensables, `f x + 1 y` serait une addition entre un appel `f x` et ... une erreur, vu que `1 y` est *mal typé*, 1 n'étant pas une fonction.

On verra par la suite qu'une syntaxe comme ̀f(1,2)` est possible aussi en OCaml, mais avec une autre signification: fonction recevait une *paire* `(1,2)`.

### Et le match ?

match c'est à peu près l'equivalent de switch dans Java, mais aux stéroides.

quand on a un match avec une liste, on pourra analyser les différents cas, exemple le cas d'une liste avec deux éléments exactement.


### Pourquoi dire qu'un `let x = ...` n'allouera peut-être pas de mémoire ?

Par exemple dans le cas d'un "let" local : 

```
let x = 3+3
in x+x;;
```

Ici la compilation a toutes les informations, il n'a pas besoin de sauvegarder ces valeurs.
Un compilateur intelligent remplacera le code au dessus par 12 car ça ne change pas la sémantique.
