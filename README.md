# Introduction à la programmation fonctionnelle

Ce dépôt git contient les ressources pédagogiques du cours de troisième
année de licence d'Informatique de l'Université Paris Diderot intitulé
"Programmation Fonctionnelle".

## Objectifs du cours

Ce cours vise à vous familiariser avec l'approche fonctionnelle de la
programmation, qui est une des grandes approches de la programmation
avec la programmation procédurale et la programmation orientée objet.

Cette approche se caractérise par :

- l'usage intensif fonctions récursives travaillant **structure de données
  inductives** (listes, arbres, ...) ;

- une méthodologie qui consiste **à contrôler voire à supprimer toutes
  formes d'état** dans les programmes pour simplifier le raisonnement
  et augmenter le parallélisme ;

- une décomposition centrée sur les schémas de calcul (itération,
  accumulation, filtrage, composition, réduction, ...) à travers
  l'écriture de **fonctions d'ordre supérieur**

Nous suivrons particulièrement l'approche *typée* de la programmation
fonctionnelle, c'est-à-dire que l'on ne considérera que des programmes
fonctionnels qui ont été validés par typage avant leur exécution. Cette
validation garantit que le programme ne peut pas produire d'erreur
d'exécution (accès à une mémoire désallouée, incompatibilité entre
les opérations et leurs arguments, ...).

Cette approche répond à des problèmes de l'ingénierie du logiciel:

- d'abord, le typage garantit la **sûreté de l'exécution** ;

- ensuite, le haut niveau d'abstraction des programmes fonctionnels
  simplifient la **vérification de la correction des programmes** car
  ils sont très proches de leur spécification ;

- par ailleurs, l'approche fonctionnelle de la programmation améliore la
  **robustesse au changement** en favorisant l'écriture de composants
  logiciels généraux et composables ;

- enfin, l'usage de composants logiciels sans état permet de dupliquer
  sans effort les unités de calcul et de stockage et ainsi favoriser
  un **passage à l'échelle** des systèmes informatiques.

La programmation fonctionnelle existe depuis les débuts de l'informatique
mais elle connaît un essor important depuis [quelques années](https://trends.google.fr/trends/explore?date=all&geo=US&q=functional%20programming,object%20oriented%20programming).

La plupart des mécanismes de la programmation fonctionnelle sont
aujourd'hui intégrés dans les langages de programmation les plus
utilisés : Python, Java, Javascript... mais il manque encore quelques
mécanismes importants pour l'utiliser pleinement. C'est pourquoi on
étudiera dans ce cours le langage de programmation OCaml qui donne
accès à l'ensemble des mécanismes de la programmation fonctionnelle.

## Informations pratiques

- Le responsable du cours est Yann Régis-Gianas.

## Supports de cours

- [cours-01](slides/cours-01.pdf) -- le [sketch](https://sketch.sh/s/agM8OE0PPCmcU0oO9GPWBa/).
- [cours-02](slides/cours-02.pdf) -- le [sketch](https://sketch.sh/s/l3N96HVMsM3eGQQw9JQ6y8/).
- [cours-03](slides/cours-03.pdf) -- le [sketch](https://sketch.sh/s/N4zt2tZ1AX4X8kT2aHWwro/).
- [cours-04](slides/cours-04.pdf) -- le [sketch](https://sketch.sh/s/q0QnNEkP6quhXdinv60zef/).
- [cours-05](slides/cours-05.pdf) -- le [code](slides/cours-05).
- [cours-06](slides/cours-06.pdf) -- le [code](slides/cours-06).
- [cours-07](slides/cours-07.pdf) -- le [sketch](https://sketch.sh/s/pmpCjGZjGnrDneOBiLSuBF/).
- le [sketch](https://sketch.sh/s/bU2dh9pkztj2TJrrCN5z15/) du cours 8.

## Projet

- [sujet](project/lambda-man.pdf)

- Le rendu du projet est le **6 janvier**.

- Un script copiera le contenu de votre dépôt git à 18h00 le 6 janvier.

- Aucun rendu par email ou par tout autre moyen ne sera accepté.

## Examens

- [examen 2018/2019](exams/examen1819.pdf) écrit par Michele Pagani.
  Le [sketch](https://sketch.sh/s/dgfrHHkNzdUuf3VYTRO3Vy/) de correction.

## Learn-OCaml

- Connectez vous sur [LearnOCaml](http://ocaml.hackojo.org)

- Saisissez un login qui commence par votre groupe et se termine par
  votre nom de famille. Par exemple `INFO3Skywalker`.

- Le secret est `pf5`

- Notez ensuite absolument votre TOKEN. C'est grâce à lui que vous
  pourrez retrouver votre session lors de votre prochaine connexion.
