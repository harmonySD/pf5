Installation d'OCaml sur vos machines
=====================================

A partir du TP6 (exercices sur le morption), et pour le projet de 
ce cours, il vous faudra disposer du compilateur OCaml et de la 
bibliothèque `graphics` en local.

  - Si vous utilisez une machine des salles 2031/2032 (PC/Linux), 
    pas de souci, ils y sont déjà.

  - Si vous utilisez un Mac de la salle 2003, ça devrait être possible, 
    mais dans le doute **amenez si possible vos ordinateurs portables**, 
    et suivez les instructions ci-dessous à l'avance.

  - Sur vos propres machines, tout dépend du système:
    * Sur une Ubuntu ou Debian : `sudo apt install ocaml`
    * Les autres Linux fournissent presque tous ocaml : https://ocaml.org/docs/install.html#Linux
    * Sur Mac et Windows, privilégier une machine virtuelle Linux si vous avez ça. 
      Sinon suivre les instructions de https://ocaml.org/docs/install.html

## Graphics

Si votre version d'OCaml est 4.08 ou moins, la bibliothèque `graphics` 
est fournie avec l'installation standard d'OCaml, rien à faire de plus. 
C'est normalement le cas sur les Ubuntu et Debian actuelles, et probablement 
la plupart des autres Linux en ce moment.

Par contre si vous avez OCaml 4.09 ou plus récent, il faudra installer `graphics` 
en plus. Votre système le propose peut-être comme "paquet" déjà installable, 
à vous de voir. Par exemple sous Ubuntu/Debian cela s'appelera un jour 
`libgraphics-ocaml-dev`. Sinon, une manière de faire est d'installer `opam`, voir 
https://ocaml.org/docs/install.html#OPAM  puis lancer `opam install graphics`.

## Dune

L'outil `dune` est très commode pour superviser la compilation d'un programme OCaml. 
Sur Ubuntu ou Debian, normalement `sudo apt install dune`. Ailleurs, si ce n'est 
pas fourni par votre système, `opam install dune` après avoir installé 
[opam](https://ocaml.org/docs/install.html#OPAM).

## Editeur de code

Mon favori est `emacs` équipé du plugin `tuareg` (paquet nommé `tuareg-mode` 
sous Ubuntu et Debian), et éventuellement du plugin `merlin`. Sinon il y a bien 
d'autres éditeurs de code proposant un support pour OCaml, à vous de voir.

## Plus d'informations

Revoir le cours 2 à propos des outils disponibles dans l'écosystème OCaml.


