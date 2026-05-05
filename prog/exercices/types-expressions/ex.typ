#import "/template-exercices.typ": *

#show: series

#title[ Exercices python : Types - Expressions ]

// concept: prédire valeur et type d'expressions — //, %, +, division, not
#ex("La calculatrice de l'esprit")[
  Sans utiliser d'ordinateur, prédire la valeur et le type Python des expressions suivantes :

  #table(
    columns: (1fr, 1fr, 1fr),
    [*Expression*], [*Valeur prédite*], [*Type (int, float, str, bool)*],
    `2 + 3.0`, an[`5.0`], an[`float`],
    `14 // 4`, an[`3`], an[`int`],
    `14 % 4`, an[`2`], an[`int`],
    `"Tic" + "Tac"`, an[`"TicTac"`], an[`str`],
    `1.0 / 1.0`, an[`1.0`], an[`float`],
    `not (10 < 2)`, an[`True`], an[`bool`],
  )
]

// concept: choisir le bon type Python (str, float, int, bool) pour des données du monde réel
#ex("Le profil du gamer")[
  On veut créer la fiche d'un joueur dans un jeu en ligne. Quel type Python choisir pour stocker ces informations ?

  - Le pseudonyme (ex: "ShadowBlade") #a[`str`]
  - Le ratio de victoires (ex: 1.25) #a[`float`]
  - Le nombre de trophées (ex: 42) #a[`int`]
  - Le compte est-il activé ? (Oui/Non) #a[`bool`]
]

// concept: appliquer // et % à un problème concret, écrire une expression de comparaison
#ex("Gestion de stock")[
  Un marchand d'œufs dispose de 50 œufs. Il les range dans des boîtes de 6.

  - Quelle expression calcule le nombre de boîtes totalement remplies ? #a1[`50 // 6`]
  - Quelle expression calcule combien d'œufs il reste après avoir rempli ces boîtes ? #a1[`50 % 6`]
  - Écrire une expression de comparaison qui vérifie si le marchand a assez d'œufs pour remplir au moins une boîte #a1[`n >= 6`]
]


// concept: identifier et corriger des erreurs de type avec float(), int(), str()
#ex("Analyse d'erreurs")[
  Corriger ces expressions en utilisant si possible des conversions `float()`, `int()`, `str()`.

  Puis évaluez l'expression corrigée.


  #table(
    columns: (1fr, 1fr, 1fr),
    [*Expression*], [*Expression corrigée*], [*Valeur*],
    `10.5 + "2"`, an[`10.5 + int("2")`], an[`12.5`],
    `int("Vingt")`, an[`int("20")`], an[`20`],
    `"Batman " + 8`, an[`"Batman " + str(8)`], an[`"Batman 8"`],
    `1,5 * 2`, an[`1.5 * 2`], an[`3.0`],
  )
]

// concept: décomposer une expression booléenne complexe pas à pas
#ex("Circuit logique")[
  Décomposer l'évaluation de cette expression : `not (10 == 10.0) or (5 * 2 > 8)`

  - `(10 == 10.0)` devient #a[`True`]
  - `not (10 == 10.0)` devient #a[`False`]
  - `5 * 2` devient #a[`10`]
  - `(5 * 2 > 8)` devient #a[`True`]
  - Résultat final #a[`True`]
]

// concept: concaténation de chaînes avec +, assembler un message depuis des fragments
#ex("Construction de message")[
  En utilisant uniquement les chaînes `"Alerte"`, `"Rouge"`, `"!"` et une chaîne contenant un espace `" "`, écrire l'expression (avec l'opérateur de concaténation `+`) pour obtenir : `"Alerte Rouge!"`.

  Réponse #a[`"Alerte" + " " + "Rouge" + "!"`]
]

// concept: priorité des opérateurs booléens (not > and > or), rôle des parenthèses
#ex("L'ordre des priorités")[
  Décomposer les étapes de l'évaluation de ces deux expressions :
  - `not(True or True)` #a[`not(True)` -> `False`]
  - `not True or True` #a[`(not True) or True` -> `False or True` -> `True`]
  - Justifier la différence #a[`not` a une priorité plus élevée que `and`]


  #ex("Le traducteur de texte")[
    On a l'expression suivante : `float("10") + 5`

    - Quelle est la valeur et le type du résultat ? #a[valeur: `15.0`, type: `float`]
    - Pourquoi utiliser `float()` au lieu de juste `"10"` ? #a[`str` + `int` est indéfini]
  ]
]

// concept: comparaison de chaînes (ordre lexicographique, sensibilité à la casse)
#ex("Le classement alphabétique")[
  Déterminer si ces expressions sont `True` ou `False` :
  - `"Zèbre" < "Abeille"` #a[`False`]
  - `"Chien" > "Chat"` #a[`True`]
  - `"A" == "a"` #a[`False`]

  #an[
    - L'ordre pour comparer des mots est l'ordre alphabétique (un mot qui apparaît après un autre dans un dictionnaire et "plus grand" que l'autre)
    - On distingue les majuscules des minuscules
  ]
]

// concept: décomposer une expression avec **, %, ==, not, and en plusieurs sous-étapes
#ex("Le système de sécurité")[
  Un coffre-fort s'ouvre si l'expression suivante est `True`:

  `(2**3 > 7) and not (15 % 2 == 0)`

  - Valeur de `(2**3)` #a[`8`]
  - Valeur de `(2**3 > 7)` #a[`True`]
  - Valeur de `(15 % 2)` #a[`1`]
  - Valeur de `(15 % 2 == 0)` #a[`False`]
  - Valeur de `not(15 % 2 == 0)` #a[`True`]
  - Valeur de l'expression complète #a[`True`]
]
