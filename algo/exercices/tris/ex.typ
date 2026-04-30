#import "/template-exercices.typ": *

#show: series

// Renders a list state in code style for the sorting exercises
#let lst(content) = text(font: "Hack", size: .9em)[#content]
#let cmt(content) = text(font: "Hack", size: .9em, fill: luma(130))[  \# #content]

#title[ Exercices : Tris et Recherche ]

= Tri par sélection

Le principe du tri par sélection est le suivant :
- Chercher (_sélectionner_) le plus petit élément de la liste et l'échanger avec l'élément d'indice `0`
- Chercher le plus petit élément dans le reste de la liste et l'échanger avec l'élément d'indice `1`
- Continuer jusqu'à ce que la liste soit entièrement triée

À tout moment, la partie déjà parcourue est bien triée.

#ex("Trier une liste")[
  Trier la liste `[3, 6, 8, 1, 9, 7, 6, 0]` en utilisant le tri par sélection. \
  Représenter l'état de la liste après chaque étape.

  #lst[\[3, 6, 8, 1, 9, 7, 6, 0\]]
  #a7[
    #lst[\[#highlight[*0*], 6, 8, 1, 9, 7, 6, 3\]]#cmt[On cherche le plus petit élément (0). On le met à l'index 0.] \
    #lst[\[#highlight[0, *1*], 8, 6, 9, 7, 6, 3\]]#cmt[On cherche le plus petit élément dans la liste restante (1). On le met à l'index 1.] \
    #lst[\[#highlight[0, 1, *3*], 6, 9, 7, 6, 8\]]#cmt[On cherche le plus petit élément dans la liste restante (3). On le met à l'index 2.] \
    #lst[\[#highlight[0, 1, 3, *6*], 9, 7, 6, 8\]]#cmt[On cherche le plus petit élément dans la liste restante (6). On le met à l'index 3.] \
    #lst[\[#highlight[0, 1, 3, 6, *6*], 7, 9, 8\]]#cmt[On cherche le plus petit élément dans la liste restante (6). On le met à l'index 4.] \
    #lst[\[#highlight[0, 1, 3, 6, 6, *7*], 9, 8\]]#cmt[On cherche le plus petit élément dans la liste restante (7). On le met à l'index 5.] \
    #lst[\[#highlight[0, 1, 3, 6, 6, 7, *8*, 9]\]]#cmt[On cherche le plus petit élément dans la liste restante (8). On le met à l'index 6.]
  ]
]

#ex("Meilleur / Pire cas")[
  Le nombre d'étapes nécessaires pour trier la liste dépend de sa taille, mais dépend-il aussi de l'ordre initial des éléments ?

  - Quel ordre initial fait terminer l'algorithme le plus rapidement ?
  #a2[Peu importe l'ordre initial : pour trouver le minimum de la liste restante, il faut toujours la parcourir entièrement. Le tri par sélection effectue toujours le même nombre d'étapes.]

  - Quel ordre initial fait terminer l'algorithme le plus lentement ?
  #a2[Même réponse : l'ordre initial n'a aucune influence.]
]

#pagebreak()

= Tri par insertion

Le principe du tri par insertion est le suivant :

- On parcourt la liste d'éléments à trier du deuxième au dernier élément.
- Pour chaque nouvel élément considéré :
  - On parcourt la liste déjà triée depuis la droite, jusqu'à ce qu'on trouve un nombre plus petit.
  - On _insère_ l'élément considéré juste à côté, en décalant tous les nombres plus grands d'une case vers la droite.
  - La partie de la liste déjà triée est maintenant plus grande de 1 élément.

#ex("Trier une liste")[
  Trier la liste `[6, 3, 8, 1, 9, 7, 5, 0]` en utilisant le tri par insertion. \
  Représenter l'état de la liste après chaque étape.

  #lst[\[6, 3, 8, 1, 9, 7, 5, 0\]]
  #a7[
    #lst[\[#highlight[*3*, 6], 8, 1, 9, 7, 5, 0\]]#cmt[On considère l'élément d'indice 1 (3) et on l'insère à l'indice 0.] \
    #lst[\[#highlight[3, 6, *8*], 1, 9, 7, 5, 0\]]#cmt[On considère l'élément d'indice 2 (8). Il est déjà à la bonne place.] \
    #lst[\[#highlight[*1*, 3, 6, 8], 9, 7, 5, 0\]]#cmt[On considère l'élément d'indice 3 (1) et on l'insère à l'indice 0.] \
    #lst[\[#highlight[1, 3, 6, 8, *9*], 7, 5, 0\]]#cmt[On considère l'élément d'indice 4 (9). Il est déjà à la bonne place.] \
    #lst[\[#highlight[1, 3, 6, *7*, 8, 9], 5, 0\]]#cmt[On considère l'élément d'indice 5 (7) et on l'insère à l'indice 3.] \
    #lst[\[#highlight[1, 3, *5*, 6, 7, 8, 9], 0\]]#cmt[On considère l'élément d'indice 6 (5) et on l'insère à l'indice 2.] \
    #lst[\[#highlight[*0*, 1, 3, 5, 6, 7, 8, 9]\]]#cmt[On considère l'élément d'indice 7 (0) et on l'insère à l'indice 0.]
  ]
]

#ex("Meilleur / Pire cas")[
  Le nombre d'étapes nécessaires pour trier la liste dépend de sa taille, mais dépend-il aussi de l'ordre initial des éléments ?

  - Quel ordre initial fait terminer l'algorithme le plus rapidement ?
  #a2[La liste déjà triée dans l'ordre croissant : `[0, 1, 3, 5, 6, 7, 8, 9]`. Chaque élément est déjà à sa place, aucune insertion n'est nécessaire.]

  - Quel ordre initial fait terminer l'algorithme le plus lentement ?
  #a2[La liste triée en ordre décroissant : `[9, 8, 7, 6, 5, 3, 1, 0]`. Chaque nouvel élément doit être inséré au début de la partie déjà triée.]
]

#ex("Tri immédiat")[
  Dans le cas particulier où les éléments de la liste sont des entiers consécutifs commençant à 0, sans doublons, il existe un algorithme de tri très rapide.

  #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    [*Indice*], [0], [1], [2], [3], [4], [5], [6], [7], [8], [9],
    [*Liste non-triée*], [2], [7], [1], [5], [3], [9], [0], [4], [6], [8],
    [*Liste triée*], an[0], an[1], an[2], an[3], an[4], an[5], an[6], an[7], an[8], an[9],
  )

  - Pouvez-vous trouver l'algorithme ? Décrivez-le. #a3[On parcourt la liste du début à la fin. On place chaque élément directement à l'indice correspondant à sa valeur : le nombre 2 va à l'indice 2, le 7 à l'indice 7, etc.]
  - Combien d'étapes sont nécessaires pour trier cette liste de 10 éléments ? #a1[10 étapes.]
  - Dérivez une relation entre la taille de la liste N et le nombre d'étapes. #a1[N étapes pour N éléments.]
]

#pagebreak()

= Rechercher dans des listes

#ex("Dans une liste non-triée")[

  `[47, 89, 204, 55, 215, 168, 127, 210, 62, 109, 73, 125, 218, 93, 40, 84, 184, 202, 165, 12, 141, 59, 82, 76, 196, 229, 95, 231, 5, 187]`

  - Comment procéder pour chercher un nombre (par exemple 12, 85 ou 231) dans cette liste ?
  #a3[On parcourt la liste du début à la fin, en comparant chaque élément au nombre cherché, jusqu'à le trouver ou atteindre la fin (auquel cas on sait qu'il n'est pas dans la liste).]

  - Combien d'étapes dans le pire cas ?
  #a2[Le meilleur cas (chance) c'est quand le nombre cherché est au début de la liste, le pire cas c'est si le nombre est à la fin ou n'est pas dans la liste. Il faut alors parcourir tous les éléments de la liste]

  - Dérivez une relation entre la taille N et le nombre d'étapes dans le pire cas.
  #a1[N étapes pour une liste de taille N]
]

#ex("Dans une liste triée")[

  `[5, 12, 40, 47, 55, 59, 62, 73, 76, 82, 84, 89, 93, 95, 109, 125, 127, 141, 165, 168, 184, 187, 196, 202, 204, 210, 215, 218, 229, 231]`

  - Comment procéder pour chercher un nombre (par exemple 12, 85 ou 231) dans cette liste ?
  _(Indice : penser au jeu où l'on devine un nombre en posant des questions « plus grand / plus petit »)_

  #a3[On compare le nombre cherché à l'élément au milieu de la liste. S'il est plus grand, on recommence dans la moitié supérieure ; s'il est plus petit, dans la moitié inférieure. On répète jusqu'à ce qu'on trouve le nombre (ou jusqu'à ce qu'on soit sûr qu'il n'y est pas).]
  - Combien d'étapes dans le pire cas pour cette liste de 30 éléments ? #a2[On divise la liste en deux à chaque étape : 30 → 15 → 7 → 3 → 1, soit 5 étapes au maximum.]
  - Dérivez une relation entre la taille N et le nombre d'étapes dans le pire cas. #a1[log#sub[2]\(N) étapes.]
]
