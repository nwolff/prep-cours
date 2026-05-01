#import "/template-exercices.typ": *

#show: series

#title[Complexité algorithmique]



#ex("Somme des n premiers nombres")[

  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée

  #table(
    columns: (3fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right),
    [*programme*], [*Op par ligne*], [*Nb fois ligne*], [*Sous-total*],
    `somme = 0`, [#an[1]], [#an[1]], [#an[1]],
    `for i in range(n):`, [#an[2]], [#an[1]], [#an[2]],
    `    somme = somme + (i + 1)`, [#an[3]], [#an[$n$]], [#an[$3n + 3$]],
    `print(somme)`, [#an[1]], [#an[1]], [#an[1]],
  )

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 2n + 6$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(n)$]
]


#ex("Somme des n premiers nombres – forme fermée")[
  Il y a une manière plus rapide de calculer la somme des $n$ premiers nombres,
  grâce à cette identité :
  $ 1 + 2 + 3 + dots.c + (n-1) + n = (n times (n + 1)) / 2 $

  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée

  #table(
    columns: (3fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right),
    [*programme*], [*Op par ligne*], [*Nb fois ligne*], [*Sous-total*],
    `somme = (n * (n + 1)) / 2`, [#an[4]], [#an[1]], [#an[4]],
    `print(somme)`, [#an[1]], [#an[1]], [#an[1]],
  )

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 5$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(1)$]
]

#ex("Déterminer si un nombre est premier")[
  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée

  #table(
    columns: (3fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right),
    [*programme*], [*Op par ligne*], [*Nb fois ligne*], [*Sous-total*],
    `for i in range(2, n):`, [#an[1]], [#an[1]], [#an[1]],
    `  if n % i == 0:`, [#an[2]], [#an[$n - 2$]], [#an[$2n - 4$]],
    `    print(i, "divise", n)`, [#an[1]], [#an[$x$]], [#an[$x$]],
    `  else:`, [#an[0]], [#an[0]], [#an[0]],
    `    print(".")`, [#an[1]], [#an[$n - 2 - x$]], [#an[$n - 2 - x$]],
  )
  _Rappel_ : `n % i` calcule le reste de la division entière de `n` par `i`.

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 3n - 5$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(n)$]
]



#ex("Table de multiplication")[
  Le programme suivant affiche la table de multiplication de 1 à $n$.

  1) Annoter le programme pour compter combien de fois chaque ligne est exécutée

  #table(
    columns: (3fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right),
    [*programme*], [*Op par ligne*], [*Nb fois ligne*], [*Sous-total*],
    `for i in range(1, n+1):`, [#an[1]], [#an[1]], [#an[1]],
    `    for j in range(1, n+1):`, [#an[1]], [#an[$n$]], [#an[$n$]],
    `        print(i * j)`, [#an[2]], [#an[$n^2$]], [#an[$2n^2$]],
  )

  #linebreak()

  2) Trouver la fonction qui lie le nombre d'opérations à $n$

  #a1[$f(n) = 2n^2 + n + 1$]

  3) Déterminer la classe de complexité du programme

  #a1[$O(n^2)$]
]
