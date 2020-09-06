# Introduction à la programmation fonctionnelle

Ce dépôt git contient les ressources pédagogiques du cours de troisième
année de licence d'Informatique de l'Université Paris Diderot intitulé
"Programmation Fonctionnelle".

## Objectifs du cours

Ce cours vise à vous familiariser avec l'approche fonctionnelle de la
programmation, qui est une des grandes approches de la programmation
avec la programmation procédurale (dite aussi impérative) et la
programmation orientée objet.

Cette approche se caractérise par :

- l'usage intensif de fonctions récursives travaillant sur des **structures de données
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
mais elle connaît un essor important depuis quelques années.

La plupart des mécanismes de la programmation fonctionnelle sont
aujourd'hui intégrés dans les langages de programmation les plus
utilisés : Python, Java, Javascript... mais il manque encore quelques
mécanismes importants pour l'utiliser pleinement. C'est pourquoi on
étudiera dans ce cours le langage de programmation OCaml qui donne
accès à l'ensemble des mécanismes de la programmation fonctionnelle.

## Organisation du cours

- Le responsable du cours est Pierre Letouzey. 

- Les chargés de travaux dirigés sont:
  - Balthazar Bauer
  - Giovanni Bernardi
  - Adrien Guatto
  - Pierre Letouzey
  - Vincent Padovani

- Le cours est évalué par un projet et par un examen final (à confirmer).

## Cours en ligne (ex-Amphis)

Beaucoup de contenus proviennent ou s'inspirent d'anciens enseignants de ce cours, en particulier de Yann Régis-Gianas (merci!).

- Cours 1 :
  - Un document d'[introduction au fonctionnel et à OCaml](slides/cours-01-yann.pdf) par Yann Régis-Gianas. 
    Très riche, privilégier l'idée générale aux détails fins pour l'instant.
  - Un premier [sketch](https://sketch.sh/s/agM8OE0PPCmcU0oO9GPWBa/) de tour d'horizon d'OCaml.
  - Séance de questions/réponses sur ces deux premiers documents : Précisions à venir


## Travaux pratiques (via Learn-OCaml)

Précisions à venir

## Projet

Précisions à venir

## Examens

- [examen 2018/2019](exams/examen1819.pdf) écrit par Michele Pagani.
  Le [sketch](https://sketch.sh/s/dgfrHHkNzdUuf3VYTRO3Vy/) de correction.
