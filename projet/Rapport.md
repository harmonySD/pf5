# Rapport

### Identifiants

- Chagnon Sarah, n°etu : 71800911, @chagnons (ou @Sarah)
- Simon-Duchatel Harmony, n°etu : 71802495, @Harmony

### Fonctionnalités

sujet minimal : dessiner une fractale a partir dun systeme, augmenter le systeme
couleur aleatoire ou en degrade
lecture dun fichier pour lancer un systeme
taille adapte a la fenetre en focntion du premier trait

   Donnez une description précise des fonctionnalités implémentées
   par votre rendu - sujet minimal, extensions éventuelles,
   éventuellement parties non réalisées ou non encore fonctionnelles.

### Compilation et exécution

make -> run avec option : 
- -i : int : nombre d'itération 
- -b : boolean : pour couleur aléatoire à chaque trait
- -c : int en hexadecimal (OxRRGGBB) : couleur dégradé 
- -s : string : choix du fichier pour le system

   Documentez ensuite de façon précise la manière dont votre
   projet doit être compilé et exécuté. Précisez si vous vous êtes
   servi de bibliothèques externes, et donnez dans ce cas un pointeur
   vers leur documentation.

### Découpage modulaire

- system.ml : tout ce qui traite du lsystem, la transformation dun system, la costruction dun system, la transformation dun system en commande
- turtle.ml : tout ce qui traite du dessin, donc du module Graphics, le dessin ou la taille du dessin

   Donnez une description des traitements pris en charge par chaque
   module (.ml) de votre projet. Précisez le rôle et la nécessité
   de chaque module ajouté au dépôt initial.

### Organisation du travail

- Sarah : tout ce qui traite du dessin : transformation dun systeme en commande, dessin a partir des commandes, couleurs, taille du dessin en fonction de la
fenetre, transformation dune chaine en sword, -b et -c
- Harmony : tout ce qui traite du systeme : substitution dun system, repetition dune etape dun systeme, transformation dun fichier en un systeme, -i et -s

en premier la base, la substitution et le dessin a lecran (avant et debut confinement), puis en plus, lecture dun fichier, taille ecran et couleur 
(fin confinement)

   Cette partie est plus libre dans sa forme. Indiquez la manière
   dont les tâches ont été réparties entre les membres du groupe
   au cours du temps. Donnez une brève chronologie de votre travail
   sur ce projet au cours de ce semestre, avant et après le
   confinement.

### Misc

projet sympa a faire, parfois difficile mais parfois simple, base simple mais pour rendre plus interressant plus complique

sujet de bonne taille qui permet de resumer rapidement le cours 

   Cette partie est entièrement libre : remarques, suggestions,
   questions...