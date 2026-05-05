#import "/template-exercices.typ": *

#show: series

#title[Complexité algorithmique]



// concept: annoter un programme ligne par ligne, compter opérations et exécutions, complexité O(n)
#ex("Somme des n premiers nombres")[

  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée.

  #table(
    columns: (auto, 3fr, 1fr, 1fr, 1fr),
    align: (right, left, right, right, right),
    [\#], [*Programme*], [*Opérations*], [*Executions*], [*Sous-total*],
    `1`, `somme = 0`, [#an[1]], [#an[1]], [#an[1]],
    `2`, `for i in range(n):`, [#an[1]], [#an[1]], [#an[1]],
    `3`, `    somme = somme + (i + 1)`, [#an[3]], [#an[$n$]], [#an[$3n + 3$]],
    `4`, `print(somme)`, [#an[1]], [#an[1]], [#an[1]],
  )

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 3n + 6$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(n)$]
]


// concept: même annotation mais O(1) — contraster avec la version itérative pour montrer l'impact d'une formule fermée
#ex("Somme des n premiers nombres – forme fermée")[
  Il y a une manière plus rapide de calculer la somme des $n$ premiers nombres,
  grâce à cette identité :
  $ 1 + 2 + 3 + dots.c + (n-1) + n = (n times (n + 1)) / 2 $

  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée

  #table(
    columns: (auto, 3fr, 1fr, 1fr, 1fr),
    align: (right, left, right, right, right),
    [\#], [*Programme*], [*Opérations*], [*Executions*], [*Sous-total*],
    `1`, `somme = (n * (n + 1)) / 2`, [#an[4]], [#an[1]], [#an[4]],
    `2`, `print(somme)`, [#an[1]], [#an[1]], [#an[1]],
  )

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 5$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(1)$]
]

// concept: même annotation avec une variable x (exécutions dépendant des données), complexité O(n)
#ex("Déterminer si un nombre est premier")[
  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée

  #table(
    columns: (auto, 3fr, 1fr, 1fr, 1fr),
    align: (right, left, right, right, right),
    [\#], [*Programme*], [*Opérations*], [*Executions*], [*Sous-total*],
    `1`, `for i in range(2, n):`, [#an[1]], [#an[1]], [#an[1]],
    `2`, `  if n % i == 0:`, [#an[2]], [#an[$n - 2$]], [#an[$2n - 4$]],
    `3`, `    print(i, "divise", n)`, [#an[1]], [#an[$x$]], [#an[$x$]],
    `4`, `  else:`, [#an[0]], [#an[0]], [#an[0]],
    `5`, `    print(".")`, [#an[1]], [#an[$n - 2 - x$]], [#an[$n - 2 - x$]],
  )
  _Rappel_ : `n % i` calcule le reste de la division entière de `n` par `i`.

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 3n - 5$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(n)$]
]



// concept: boucles imbriquées → n² exécutions → complexité O(n²)
#ex("Table de multiplication")[
  Le programme suivant affiche la table de multiplication de 1 à $n$.

  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée

  #table(
    columns: (auto, 3fr, 1fr, 1fr, 1fr),
    align: (right, left, right, right, right),
    [\#], [*Programme*], [*Opérations*], [*Executions*], [*Sous-total*],
    `1`, `for i in range(n):`, [#an[1]], [#an[1]], [#an[1]],
    `2`, `    for j in range(n):`, [#an[1]], [#an[$n$]], [#an[$n$]],
    `3`, `        print((i+1) * (j+1))`, [#an[4]], [#an[$n^2$]], [#an[$4n^2$]],
  )

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 4n^2 + n + 1$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(n^2)$]
]
