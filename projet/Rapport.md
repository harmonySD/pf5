# Rapport

### Identifiants

- Chagnon Sarah, n°etu : 71800911, @chagnons (ou @Sarah)
- Simon-Duchatel Harmony, n°etu : 71802495, @Harmony

### Fonctionnalités

   **Sujet minimal :** chargement d'un L-système à partir d'un fichier (.sys), interprétations des chaines parenthésés
  en suite de commandes, utilisations du module Graphics, affichage du dessin a chaque itérations apres un clic sur la fenêtre,
  choix d'une échelle raisonnable.
  
  **Extension :** Couleur aléatoire ou en dégradé  

### Compilation et exécution

*Utilisez une version d'Ocaml supérieur a 4.08.0*
```
> make
> ./run (avec option)
```
***listes d'options disponibles***
- i : int : nombre d'itérations 
- b : boolean : pour couleur aléatoire à chaque trait
- c : int en hexadecimal (0xRRGGBB) : couleur dégradé 
- s : string : choix du fichier pour le système

Par exemple vous pouvez lancer :
```
> make 
> ./run -i 6 -c 0xF68C -s examples/dragon.sys 
```
ou bien ...
```
> make 
> ./run -i 6 -b -c 0xF68C -s examples/dragon.sys
```
*Rappel* pour afficher les différentes itérations, il suffit de cliquer sur la fenêtre

### Découpage modulaire

- system.ml : tout ce qui traite du L-system, la transformation d'un système, la construction d'un système apres lecture du fichier, la transformation d'un système en commande, le nombre d'appels a la transformation en fonction du nombres d'itérations.

- turtle.ml : tout ce qui traite du dessin, donc du module Graphics, le dessin,la couleur, ou la taille du dessin.

- main.ml : lien entre l'utilisateur et le programme, options, appel a la transformation d'un fichier en fonction des paramètres rentrés par l'utilisateur.

### Organisation du travail

- Sarah : tout ce qui traite du dessin : transformation d'un système en commande, dessin à partir des commandes, couleurs, taille du dessin en fonction de la
fenêtre, transformation d'une chaine en sword, -b et -c
- Harmony : tout ce qui traite du système : substitution d'un système, repetition dune étape dun système, transformation d'un fichier en un système, -i et -s


*En premier la base, la substitution et le dessin a l'écran (avant et debut confinement), puis en plus, lecture d'un fichier, taille écran et couleur 
(fin confinement)*

### Misc

Projet sympa a réalisé, une structure de L-system un peu difficile a comprendre au debut mais assez simple a prendre en main par la suite, sujet de base assez simple (après compréhension des structures), mais pour rendre plus intéressant (sauvegarde fichier etc..) plus compliqué.

Sujet de bonne taille qui permet de résumer rapidement le cours.
