#import "/template-exercices.typ": *

#show: series

// render a playing card glyph
#let c(g) = box(text(font: "Noto Sans Symbols 2", size: 2.5em)[#g])

// render a discarded card — grayed out with a diagonal strikethrough
#let x(g) = context {
  let card = box(text(font: "Noto Sans Symbols 2", size: 2.5em, fill: luma(160))[#g])
  let sz = measure(card)
  // measure actual ink bounds to skip empty space around the glyph
  let ink = measure(text(font: "Noto Sans Symbols 2", size: 2.5em, top-edge: "bounds", bottom-edge: "bounds")[#g])
  let dx = (sz.width - ink.width) / 2
  let dy = sz.height - ink.height
  box[
    #card
    #place(top + left)[
      #line(start: (dx, dy), end: (sz.width - dx, sz.height), stroke: 2pt + luma(160))
    ]
  ]
}

= Trouver le plus grand élément

*Problème :* un tas de N cartes, faces cachées. On ne peut regarder et comparer que deux cartes à la fois.

== Algorithme

+ Retourner la première carte du tas — elle devient le *maximum courant*
+ Tant que le tas n'est pas vide :
  + Retourner la prochaine carte du tas
  + La comparer avec le maximum courant
  + Si elle est plus grande → elle devient le nouveau maximum courant, l'ancienne est écartée
  + Sinon → la nouvelle carte est écartée
+ La carte restante en jeu est la plus grande du jeu

== Trace

Exemple avec 5 cartes, tirées dans l'ordre : 3, 2, 4, K, 5

#table(
  columns: (auto, auto, 1fr),
  align: (center + horizon, left + horizon, left + horizon),
  [*Tas*], [*En jeu*], [],
  [#c[🂠]#c[🂠]#c[🂠]#c[🂠]#c[🂠]], [], [Toutes les cartes sont faces cachées],
  [#c[🂠]#c[🂠]#c[🂠]#c[🂠]], [#c[🂣]], [On retourne la 1ère carte → *maximum courant : 3*],
  [#c[🂠]#c[🂠]#c[🂠]], [#c[🂣] #c[🂢]], [On retourne la 2ème carte],
  [#c[🂠]#c[🂠]#c[🂠]], [#c[🂣] #x[🂢]], [3 > 2 → on garde 3, on écarte 2],
  [#c[🂠]#c[🂠]], [#c[🂣] #c[🂤]], [On retourne une nouvelle carte],
  [#c[🂠]#c[🂠]], [#x[🂣] #c[🂤]], [4 > 3 → on garde 4, on écarte 3 — *maximum courant : 4*],
  [#c[🂠]], [#c[🂤] #c[🂮]], [On retourne une nouvelle carte],
  [#c[🂠]], [#x[🂤] #c[🂮]], [K > 4 → on garde K, on écarte 4 — *maximum courant : K*],
  [], [#c[🂮] #c[🂥]], [On retourne la dernière carte],
  [], [#c[🂮] #x[🂥]], [K > 5 → on garde K, on écarte 5 — le tas est vide],
)

*Résultat :* la plus grande carte est #c[🂮] — il a fallu *4 comparaisons* pour 5 cartes.

*Complexité :* pour N cartes, il faut exactement *N − 1 comparaisons*.

#pagebreak()

= Trier un jeu de cartes

*Problème :* un tas de N cartes mélangées, faces cachées. On ne peut comparer que deux cartes à la fois. Trier le jeu du plus petit au plus grand.

== Algorithme

Idée : appliquer la recherche du minimum en boucle, en rangeant chaque minimum dans le résultat sans regarder.

+ Trouver le minimum du tas → le placer dans le résultat _(sans regarder l'ordre)_
+ Répéter avec le tas restant
+ Quand le tas est vide, le résultat est trié

== Trace

Exemple : 7 cartes dans l'ordre initial 3, K, 4, 7, 2, 6, 5

#table(
  columns: (auto, auto, 1fr, auto),
  align: (center + horizon, center + horizon, left + horizon, left + horizon),
  [*Tas*], [*Minimum*], [], [*Résultat*],
  [#c[🂠]#c[🂠]#c[🂠]#c[🂠]#c[🂠]#c[🂠]#c[🂠]], [], [État initial], [],
  [#c[🂠]#c[🂠]#c[🂠]#c[🂠]#c[🂠]#c[🂠]],
  [#c[🂢]],
  [Minimum = 2

    _(6 comparaisons)_],
  [],

  [#c[🂠]#c[🂠]#c[🂠]#c[🂠]#c[🂠]],
  [#c[🂣]],
  [Minimum = 3

    _(5 comparaisons)_],
  [#c[🂢]],

  [#c[🂠]#c[🂠]#c[🂠]#c[🂠]],
  [#c[🂤]],
  [Minimum = 4

    _(4 comparaisons)_],
  [#c[🂢]#c[🂣]],

  [#c[🂠]#c[🂠]#c[🂠]],
  [#c[🂥]],
  [Minimum = 5

    _(3 comparaisons)_],
  [#c[🂢]#c[🂣]#c[🂤]],

  [#c[🂠]#c[🂠]],
  [#c[🂦]],
  [Minimum = 6

    _(2 comparaisons)_],
  [#c[🂢]#c[🂣]#c[🂤]#c[🂥]],

  [#c[🂠]],
  [#c[🂧]],
  [Minimum = 7

    _(1 comparaison)_],
  [#c[🂢]#c[🂣]#c[🂤]#c[🂥]#c[🂦]],

  [], [#c[🂮]], [Dernière carte : K], [#c[🂢]#c[🂣]#c[🂤]#c[🂥]#c[🂦]#c[🂧]],
  [], [], [Le tas est vide — *le jeu est trié !*], [#c[🂢]#c[🂣]#c[🂤]#c[🂥]#c[🂦]#c[🂧]#c[🂮]],
)

*Résultat :* #c[🂢]#c[🂣]#c[🂤]#c[🂥]#c[🂦]#c[🂧]#c[🂮] — il a fallu *21 comparaisons* pour trier 7 cartes.

*Complexité :* dans cet exemple : $6 + 5 + 4 + 3 + 2 + 1 = 21$ comparaisons pour 7 cartes.

En général, pour N cartes : $(N-1) + (N-2) + dots.h + 1 = N(N-1)/2$ comparaisons.

#pagebreak()

= Fusionner deux jeux triés

*Problème :* deux tas de cartes déjà triées, faces cachées. On ne peut comparer que deux cartes à la fois. Les fusionner en un seul tas trié.

== Algorithme

+ Retourner la carte du dessus de chaque tas
+ Prendre la plus petite → la placer dans le tas résultat
+ Retourner la prochaine carte du tas dont on vient de prendre
+ Répéter jusqu'à ce qu'un tas soit vide
+ Vider le tas restant dans le résultat

== Trace

Exemple : fusionner [2, 4, K] et [3, 5, 7]

#table(
  columns: (auto, auto, 1fr, auto),
  align: (right + horizon, left + horizon, left + horizon, left + horizon),
  table.cell(colspan: 2)[*Tas*], [], [*Résultat*],

  [T1],
  [#c[🂠]#c[🂠]#c[🂠]],
  table.cell(rowspan: 2)[État initial : deux tas triés, faces cachées],
  table.cell(rowspan: 2)[],
  [T2], [#c[🂠]#c[🂠]#c[🂠]],

  [T1],
  [#c[🂠]#c[🂠]#c[🂢]],
  table.cell(rowspan: 2)[On retourne la 1ère carte de chaque tas.

    On a 2 et 3],
  table.cell(rowspan: 2)[],
  [T2], [#c[🂠]#c[🂠]#c[🂣]],

  [T1],
  [#c[🂠]#c[🂤]],
  table.cell(rowspan: 2)[2 < 3 → on prend 2, on retourne la suivante de T1

    On a 4 et 3],
  table.cell(rowspan: 2)[#c[🂢]],
  [T2], [#c[🂠]#c[🂠]#c[🂣]],

  [T1],
  [#c[🂠]#c[🂤]],
  table.cell(rowspan: 2)[4 > 3 → on prend 3, on retourne la suivante de T2

    On a 4 et 5],
  table.cell(rowspan: 2)[#c[🂢]#c[🂣]],
  [T2], [#c[🂠]#c[🂥]],

  [T1],
  [#c[🂮]],
  table.cell(rowspan: 2)[4 < 5 → on prend 4, on retourne la suivante de T1

    On a K et 5],
  table.cell(rowspan: 2)[#c[🂢]#c[🂣]#c[🂤]],
  [T2], [#c[🂠]#c[🂥]],

  [T1],
  [#c[🂮]],
  table.cell(rowspan: 2)[K > 5 → on prend 5, on retourne la suivante de T2

    On a K et 7
  ],
  table.cell(rowspan: 2)[#c[🂢]#c[🂣]#c[🂤]#c[🂥]],
  [T2], [#c[🂧]],

  [T1],
  [#c[🂮]],
  table.cell(rowspan: 2)[K > 7 → on prend 7.

    On a K],
  table.cell(rowspan: 2)[#c[🂢]#c[🂣]#c[🂤]#c[🂥]#c[🂧]],
  [T2], [#hide(c[🂠])],

  [T1],
  [#hide(c[🂠])],
  table.cell(rowspan: 2)[T2 vide → on place les cartes restantes de T1 dans le résultat],
  table.cell(rowspan: 2)[#c[🂢]#c[🂣]#c[🂤]#c[🂥]#c[🂧]#c[🂮]],
  [T2], [#hide(c[🂠])],
)

*Résultat :* #c[🂢]#c[🂣]#c[🂤]#c[🂥]#c[🂧]#c[🂮] — il a fallu *5 comparaisons* pour fusionner 6 cartes.

*Complexité :* pour N cartes au total, il faut au plus *N − 1 comparaisons*.
