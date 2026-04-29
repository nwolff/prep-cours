#import "/template-exercices.typ": *

#show: series

#title[ Exercices python : Variables - Traces ]

#ex("Moo Deng")[
  Écrire la trace de l'execution de ce programme:
  ```
  # État initial de Moo Deng
  endurance = 10
  dort = False

  endurance = endurance - 7  # Joue à la balle
  dort = not dort  # Fait une sieste pour récupérer
  endurance = endurance + 5  # Gagne de l'énergie en se reposant
  dort = not dort  # Le réveil sonne!
  endurance = endurance - 1  # Marche doucement vers sa gamelle
  heureux = (endurance > 5) and (dort == False)
  print(heureux)
  ```
  #table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    [*ligne*], an[*endurance*], an[*dort*], an[*heureux*], [*affichage*],
    "2", an[`10`], [], [], [],
    "3", [], an[`False`], [], [],
    "5", an[`3`], [], [], [],
    "6", [], an[`True`], [], [],
    "7", an[`8`], [], [], [],
    "8", [], an[`False`], [], [],
    "9", an[`7`], [], [], [],
    "10", [], [], an[`True`], [],
    "11", [], [], [], an[`True`],
  )

  #an[
    #image("moo-deng.webp", width: 30%)
  ]
]

#ex("Distributeur de bonbons (logique booléenne)")[
  Un distributeur donne un bonbon si:
  - On a mis de l'argent
  - On tourne la poignée

  *Consigne :*
  Terminer ce programme:
  ```
  argent_mis = soit True soit False # Vient d'un capteur du distributeur
  poignée_tournée = soit True soit False # Vient d'un autre capteur

  # Écrire l'expression qui détermine s'il faut distribuer un bonbon
  # en fonction de l'état du distributeur

  distribution = _______________________________________

  print(distribution) # Affiche True si le bonbon est distribué
  ```

  #an[
    ```
    distribution = argent_mis and poignée_tournée
    ```
  ]
]

#ex("La carte de visite")[
  Écrire le code python qui:
  + Crée ces 3 variables :
    - prénom (str) : `"Ada"`
    - nom (str) : `"Lovelace"`
    - profession (str) : `"Programmeuse"`
  + Crée une variable `carte` _(en utilisant les variables, pas des valeurs fixes)_ qui produit : `"Ada Lovelace: Programmeuse"`
  + Affiche la valeur de cette variable

  #a5[
    ```
    prénom = "Ada"
    nom = "Lovelace"
    profession = "Programmeuse"
    carte = prénom + " " + nom + ": " + profession
    print(carte)
    ```
  ]
]

#ex("Carré")[
  Écrire le code python qui:
  - Crée une variable `x` contenant un nombre de votre choix.
  - Calcule $x^2$ et stocke le résultat dans une nouvelle variable `carré`.
  - Affiche ce résultat.

  #a3[```
    x = 3
    carré = x**2
    print(carré)
    ```
  ]
]

#ex("Que s'affiche-t-il ?")[
  Écrire ce que chaque `print` affiche:

  _il faut bien regarder le type de tous les éléments, il est possible que certaines lignes donnent lieu à des erreurs._
  ```
  niveau = 1
  print("niveau")             __________________________
  niveau = niveau + 1
  print(niveau)               __________________________
  niveau = 5
  print(niveau)               __________________________
  niveau = niveau ** 2
  print(niveau)               __________________________
  niveau = niveau + 1
  print("niveau:" + niveau)   __________________________
  ```

  #an[
    #table(
      columns: (1fr, 4fr),
      [*ligne*], [*affiche*],
      "2", `"niveau"`,
      "4", `2`,
      "6", `5`,
      "8", `25`,
      "10", `TypeError: on ne peut pas concaténer str et int`,
    )
  ]
]



#ex("Afficher une pub (logique booléenne)")[
  Vous possédez un réseau social.
  Dans leur profil les utilisateur·ices renseignent une variable `passion`qui peut prendre des valeurs diverses: `cinéma`, `jardinage`, `programmation`, etc
  Vous devez décider si vous allez leur montrer une publicité pour un magasin de matériel de montagne.

  *Règle :*
  On affiche la pub si l'utilisateur·ice a une passion pour `escalade`

  *Consigne :*
  Écrire le programme qui:
  - Stocke la passion de l'utilisateur·ice dans une variable (inventer une valeur)
  - Détermine dans une variable `montrer_pub`s'il faut montrer la pub ou pas.
  - Affiche cette valeur (Ca affichera True s'il faut montrer la pub à cette personne)

  #a3[
    ```
    passion = "alpinisme"
    montrer_pub = passion == "escalade"
    print(montrer_pub) # Affiche True s'il faut montrer la pub
    ```
  ]
]

#ex("Pub suite")[
  Modifier le programme précédent pour prendre en compte cette nouvelle règle:

  On affiche _aussi_ la pub quand `passion` est `alpinisme`

  `montrer_pub =` #al[ ``` passion == "escalade" or passion == "alpinisme" ``` ]
]

#ex("Le rapport de mission")[
  Écrire le code python qui:
  + Crée ces 3 variables et leur assigne leurs valeurs respectives :
    - vaisseau (str) : `"Major Tom"`
    - carburant (float): `75.5`
    - surchauffe (bool) : `True`
  + Crée une variable rapport qui concatène tout ça:  `Major Tom | 75.5% | True`
  + Affiche la valeur de cette variable

  _Bien regarder le type de chaque élément, il va falloir faire des conversions avant de concaténer_

  #a5[
    ```
    vaisseau = "Major Tom"
    carburant = 75.5
    surchauffe = True
    rapport = vaisseau + " | " + str(carburant) + "% | " + str(surchauffe)
    print(rapport)
    ```
  ]
]


#ex("Échanger la valeur de deux variables")[
  On aimerait échanger la _valeur_ de deux variables
  ```
  a = "pizza"
  b = "kebab"

  # Échanger le contenu des deux variables, sans réécrire pizza ou kebab.
  # Votre code ici:





  print(a) # doit afficher "kebab"
  print(b) # doit afficher "pizza"
  ```

  Faites une trace de votre solution pour la vérifier. Il est très probable que votre premier jet ne va pas faire ce que vous voulez.

  #an[```
    # On doit utiliser une troisième variable:
    # Si on commence par écrire a=b, on a perdu la valeur "pizza" pour toujours
    c = b
    b = a
    a = c
    ```
  ]
]
