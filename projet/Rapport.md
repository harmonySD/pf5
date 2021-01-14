# Rapport

### Identifiants

- Chagnon Sarah, n°etu : **71800911**, @chagnons (ou @Sarah)
- Simon-Duchatel Harmony, n°etu : **71802495**, @Harmony

### Fonctionnalités

   Nous avons choisi d'implémenter le **sujet minimal** comprenant le chargement d'un
    L-système à partir d'un fichier (.sys). Des exemples de fichier se trouvent dans le repertoire examples
    (*certain ont été rajouté par nous pour plus de possibilités !*). 
  
  Concernant la gestion des interpretations et substitutions, nous avons décidé 
  de les gérer en liste de commande (*même si cela utilise beaucoup de mémoire*)
    afin de ne pas passer trop de temps sur ce point. L'appel a certains fichiers avec de trop grandes 
    itérations entraineras donc une erreur *stack overflow*, cependant l'affichage des itérations 
    avant ce problème de mémoire s'afficheront correctement.
  
  Pour la partie Tortue, nous utilisons le module Graphics, afin de rendre l'affichage un 
   peu plus interactif, chaque itération apparait après un clic sur la fenêtre.
   
   Le dessin s'affiche a une échelle raisonnable par rapport à la fenêtre, et donc chaque trait diminue à chaque étape en fonction de la dimension de l'image de base.
  
 De plus nous avons réussi a ajouté une **extension**, un affichage du dessin en couleur aléatoire ou en dégradé avec couleur au choix. 

### Compilation et exécution

*Utilisez une version d'Ocaml supérieur a 4.08.0*
```
> make
> ./run (avec option)
```
***listes d'options disponibles***
- `-i ` : int : nombre d'itérations 
- `-b` : boolean : pour couleur aléatoire à chaque trait
- `-c` : int en hexadecimal (0xRRGGBB) : couleur dégradée 
- `-s ` : string : choix du fichier pour le système (examples/nomFichier.sys)

Par exemple vous pouvez lancer :
```
> make 
> ./run -i 6 -c 0x206890 -s examples/dragon.sys 
```
ou bien ...
```
> make 
> ./run -i 10 -b  -s examples/br1.sys
```
**Subtilité** si vous lancer l'option `-b` **et** `-c` alors seul le `-b` sera pris en compte !

*Rappel* pour afficher les différentes itérations, il suffit de cliquer sur la fenêtre.

### Découpage modulaire

- **system.ml** : tout ce qui traite du L-system, la transformation d'un système, la construction d'un système apres lecture du fichier, la transformation d'un système en commandes, le nombre d'appels a la transformation en fonction du nombres d'itérations.

- **turtle.ml** : tout ce qui traite du dessin, donc du module Graphics, le dessin,la couleur, ou la taille du dessin.

- **main.ml** : lien entre l'utilisateur et le programme, options, appel a la transformation d'un fichier en fonction des paramètres rentrés par l'utilisateur.

### Organisation du travail

Sarah s'est occupée de tout ce qui traite du dessin, la transformation d'un système en commande. Le dessin à partir des commandes, de l'extension couleur (*et donc des options `-b` et `-c`*).
 L'adaptation de la taille du dessin en fonction de la fenêtre ainsi que de la transformation d'une chaine de charactère en sword. 

Harmony s'est occupée tout ce qui traite du système, la substitution d'un système, le nombre de répétitions d'une étape d'un système donné par l'utilisateur (*options `-i`*).
Ainsi que de la transformation d'un fichier en un système (*option `-s`*)

Et bien sure quelques séances de débuggage ensemble :)

*Nous avons en premier privilégier la base du projet, c'est-à-dire la substitution et le dessin a l'écran (avant et debut confinement). Puis en plus, la lecture d'un fichier, l'adaptation du dessin 
par rapport a la taille de l'écran et des couleurs. (fin confinement)*

### Misc

Nous avons trouvé le sujet sympa, très intéressant, avec une structure de L-system un peu difficile à comprendre au debut mais assez simple à prendre en main par la suite.
Le sujet de base était assez simple (après compréhension des structures), mais pour le plus intéressant (sauvegarde du dessin etc..) c'était plus compliqué (manque de temps).

Sinon le sujet était quand même de bonne taille ce qui a permis de résumer rapidement le cours. Il a permis de survoler toutes les parties du cours et même un peu plus,
ce qui est très valorisant.

*Petits commentaires sur le code* :
- Nous avons utilisé les références pour gérer les options car nous ne voyons vraiment pas 
comment réussir autrement.
- Afin de lire dans un fichier nous nous sommes inspiré [ici](https://stackoverflow.com/questions/5774934/how-do-i-read-in-lines-from-a-text-file-in-ocaml).
