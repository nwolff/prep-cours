#import "/exercices/template.typ": *

#show: series

#title[ Série d'exercices : Types, Valeurs, Expressions ]

#ex("La calculatrice de l'esprit", taxonomy: "A")[
  Sans utiliser d'ordinateur, prédire la valeur et le type Python des expressions suivantes :

  #table(
    columns: (1fr, 1fr, 1fr),
    [*Expression*], [*Valeur prédite*], [*Type (int, float, str, bool)*],
    [`2 + 3.0`], [ #an[`5.0`]], [ #an[`float`]],
    [`15 // 4`], [ #an[`3`]], [ #an[`int`]],
    [`"Tic" + "Tac"`], [ #an[`"TicTac"`]], [ #an[`str`]],
    [`1.0 / 1.0`], [ #an[`1.0`]], [ #an[`float`]],
    [`not (10 < 2)`], [ #an[`True`]], [ #an[`bool`]],
  )
]

#ex("Le profil du gamer", taxonomy: "M")[
  On veut créer la fiche d'un joueur dans un jeu en ligne. Quel type Python choisir pour stocker ces informations ?

  - Le pseudonyme (ex: "ShadowBlade") #a[`str`]
  - Le ratio de victoires (ex: 1.25) #a[`float`]
  - Le nombre de trophées (ex: 42) #a[`int`]
  - Le compte est-il activé ? (Oui/Non) #a[`bool`]
]

#ex("Gestion de stock", taxonomy: "D")[
  Un marchand d'œufs dispose de 50 œufs. Il les range dans des boîtes de 6.

  - Quelle expression calcule le nombre de boîtes totalement remplies ? #a[`50 // 6`]
  - Quelle expression calcule combien d'œufs il reste après avoir rempli ces boîtes ? #a[`50 % 6`]
  - Écrire une expression de comparaison qui vérifie si le marchand a assez d'œufs pour remplir au moins une boîte #a[`n >= 6`]
]


#ex("Analyse d'erreurs", taxonomy: "G")[
  Pourquoi Python refuse-t-il d'évaluer les expressions suivantes ? Écrire la version correcte.

  - `10.5 + "2"` #a[`10.5 + float(2)`]
  - `int("Vingt")` #a[`int("20")`]
  - `True and "False"` #a[`True and False`]
  - `"Batman " + 8` #a[`"Batman " + str(8)`]
  - `1,5 * 2` #a[`1.5 * 2`]
]

#ex("Circuit logique", taxonomy: "X")[
  Décomposer l'évaluation de cette expression : `not (10 == 10.0) or (5 * 2 > 8)`

  - `(10 == 10.0)` devient #a[`True`]
  - `not (10 == 10.0)` devient #a[`False`]
  - `(5 * 2 > 8)` devient #a[`True`]
  - Résultat final #a[`True`]
]

#ex("Construction de message", taxonomy: "M")[
  En utilisant uniquement les chaînes `"Alerte"`, `"Rouge"`, `"!"` et une chaîne contenant un espace `" "`, écrire l'expression (avec l'opérateur de concaténation `+`) pour obtenir : `"Alerte Rouge!"`.

  Réponse #a[`"Alerte" + " " + "Rouge" + "!"`]
]

#ex("L'ordre des priorités", taxonomy: "A")[
  Calculer mentalement :
  - `not True or True` #a[`True`]
  - `not(True or True)` #a[`False`]
  - Justifier la différence #a[`not` a une priorité plus éleveé que `and`]


  #ex("Le traducteur de texte", taxonomy: "D")[
    On a l'expression suivante : `float("10") + 5`

    - Quelle est la valeur et le type du résultat ? #a[`15.0   float`]
    - Pourquoi utiliser `float()` au lieu de juste `"10"` ? #a[Car il n'est pas possible d'additionner un `str` et un `int`]
  ]
]

#ex("Le classement alphabétique", taxonomy: "X")[
  Déterminer si ces expressions sont `True` ou `False` :
  - `"Zèbre" < "Abeille"` #a[`False`]
  - `"Chien" > "Chat"` #a[`True`]
  - `"A" == "a"` #a[`False`]
]

#ex("Le système de sécurité", taxonomy: "E")[
  Un coffre-fort s'ouvre si l'expression suivante est `True`.

  `(2**3 > 7) and not (15 % 2 == 0)`

  - Valeur de `(2**3)` #a[`8`]
  - Valeur de `(2**3 > 7)` #a[`True`]
  - Valeur de `(15 % 2)` #a[`1`]
  - Valeur de `(15 % 2 == 0)` #a[`False`]
  - Valeur de `not(15 % 2 == 0)` #a[`True`]
  - Valeur de l'expression complète #a[`True`]
]
