#import "/template-exercices.typ": *

#show: series

#title[ Série d'exercices python : Variables ]

#ex("Carré")[
  Ecrire le code python qui:
  - Crée une variable `x` contenant un nombre de votre choix.
  - Calcule $x^2$ et stocker le résultat dans une nouvelle variable `carré`.
  - Affiche ce résultat.

  #an[```
    x =
    carré = x**2
    print(carré)
    ```
  ]
]

#ex("Moo Deng")[
  Ecrire la trace de l'execution de ce programme:
  ```
  # Etat initial de Moo Deng
  endurance = 10
  dort = False

  endurance = endurance - 7  # Joue à la balle
  dort = True  # Fait une sieste pour récupérer
  endurance = endurance + 5  # Gagne de l'énergie en se reposant
  dort = False  # Le réveil sonne!
  endurance = endurance - 1  # Marche doucement vers sa gamelle
  heureux = (endurance > 5) and (dort == False)
  print(heureux)
  ```
  #an[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      [*ligne*], [*endurance*], [*dort*], [*heureux*], [*affichage*],
      "2", "10", "", "", "",
      "3", "", "False", "", "",
      "5", "3", "", "", "",
      "6", "", "True", "", "",
      "7", "8", "", "", "",
      "8", "", "False", "", "",
      "9", "7", "", "", "",
      "10", "", "", "True", "",
      "11", "", "", "", "True",
    )
    #image("moo-deng.webp", width: 30%)
  ]
]

#ex("Le rapport de mission")[
  Ecrire le code python qui:
  + Crée ces 3 variables et leur assigne leurs valeurs respectives :
    - vaisseau (str) : `"Major Tom"`
    - carburant (float): `75.5`
    - moteur_chaud (bool) : `True`
  + Crée une variable rapport qui concatène tout ça:  `Major Tom | 75.5% | True`
  + Affiche la valeur de cette variable

  #an[
    ```
     rapport = vaisseau + " | " + str(carburant) + "% | " + str(moteur_chaud)
     print(rapport)
    ```
  ]
]

#ex("Que s'affiche-t-il ?")[
  Compléter ce que chaque `print` affiche (à côté de chaque print):

  ```
  niveau = 1
  print("niveau")
  niveau = niveau + 1
  print(niveau)
  niveau = 5
  print(niveau)
  niveau = niveau * 2
  print("niveau:" + niveau)
  ```

  #an[
    #table(
      columns: (1fr, 1fr),
      [*ligne*], [*affiche*],
      "2", [`"niveau"`],
      "4", [2],
      "6", [5],
      "8", [TypeError: on ne peut pas concaténer str et int],
    )
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

  # Ecrire l'expression qui détermine s'il faut distribuer un bonbon
  # en fonction de l'état du distributeur

  distribution =

  print(distribution) # Affiche True si le bonbon est distribué
  ```

  #an[
    ```
    distribution = argent_mis and poignée_tournée
    ```
  ]
]

#ex("Afficher une pub (logique booléenne)")[
  Vous possédez un réseau social.
  Dans leur profil les utilisateur·ics renseignent une variable `passion`qui peut prendre des valeurs diverses: `cinéma`, `jardinage`, `programmation`, etc
  Vous devez décider si vous allez leur montrer une publicité pour un magasin de matériel de montagne.

  *Règle :*
  On affiche la pub si l'utilisateur·ice a une passion pour `escalade`

  *Consigne :*
  Sur le modèle de l'exercice précédent, écrire le programme qui:
  - Stocke la passion de l'utilisateur dans une variable (inventer une valeur)
  - Détermine dans une variable `montrer_pub`s'il faut montrer la pub ou pas.
  - Affiche cette valeur

  #an[
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
  #an[
    ```
    passion = "alpinisme"

    montrer_pub = passion == "escalade" or passion == "alpinisme"

    print(montrer_pub) # Affiche True s'il faut montrer la pub
    ```
  ]
]

#ex("Echanger la valeur de deux variables (difficile)")[
  On aimerait échanger la _valeur_ de deux variables
  ```
  a = "pizza"
  b = "kebab"

  # Echanger le contenu des deux variables, sans réécrire pizza ou kebab.
  # Ecrire le code ici:





  print(a) # doit afficher "pizza"
  print(b) # doit afficher "kebab"
  ```

  Faites une trace de votre solution pour la vérifier

  #an[```
    # On doit utiliser une troisième variable:
    # Si on écrit a=b, puis b=a on a perdu "pizza"
    c = b
    b = a
    a = c
    ```
  ]
]
