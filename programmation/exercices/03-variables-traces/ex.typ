#import "/template-exercices.typ": *

#show: series

#title[ Série d'exercices : Variables et traces ]

#ex("Carré")[
  - Créer une variable `x` contenant un nombre de votre choix.
  - Calculer $x^2$ et stocker le résultat dans une nouvelle variable `carré`.
  - Afficher ce résultat.
  - Modifier la valeur de `x`et relancer le programme.

  #an[```
    x = 20
    carré = x**2
    print(carré)
    ```
  ]
]

#ex("Le rapport de mission")[
  + Déclarer ces variables :
    - vaisseau (str) : `"Major Tom"`
    - carburant (float): `75.5`
    - moteur_chaud (bool) : `True`
  + Créer une variable rapport qui concatène tout ça:  `Major Tom | 75.5% | True`
  + Afficher la valeur de cette variable

  #an[
    ```
     rapport = vaisseau + " | " + str(carburant) + "% | " + str(moteur_chaud)
     print(rapport)
    ```
  ]
]

#ex("Moo Deng")[
  Sans utiliser l'ordinateur, écrire la trace de l'execution de ce programme:
  ```
  endurance = 10
  dort = False

  endurance = endurance - 7  # Joue à la balle
  dort = True # Fait une sieste pour récupérer
  endurance = endurance + 5 # Gagne de l'énergie en se reposant
  dort = False # Le réveil sonne!
  endurance = endurance - 1 # Marche doucement vers sa gamelle
  heureux = (endurance > 5) and (dort == False)
  print(heureux)
  ```
  #an[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      [*ligne*], [*endurance*], [*dort*], [*heureux*], [*affichage*],
      "1", "10", "", "", "",
      "2", "", "False", "", "",
      "4", "3", "", "", "",
      "5", "", "True", "", "",
      "6", "8", "", "", "",
      "7", "", "False", "", "",
      "8", "7", "", "", "",
      "9", "", "", "True", "",
      "10", "", "", "", "True",
    )]
]

#pagebreak()


#ex("Distributeur de bonbons (logique booléenne)")[
  Un distributeur donne un bonbon si:
  - On a mis de l'argent
  - On tourne la poignée

  *Consigne*
  Terminer d'écrire ce programme, puis tester différents cas pour différentes valeurs de `argent_mis` et `poignée_tournée`
  ```
  argent_mis= ....
  poignée_tournée= ....

  # Ecrire le code qui détermine s'il faut distribuer un bonbon
  distribution= ...

  print(distribution) # Affiche True si le bonbon est distribué
  ```

  #an[
    ```
    distribution= argent_mis and poignée_tournée
    ```
  ]
]

#ex("Afficher une pub (logique booléenne)")[
  Vous possédez un réseau social.
  Dans leur profil les utilisateur·ics renseignent une variable `passion`qui peut prendre des valeurs diverses: `cinéma`, `jardinage`, `programmation`, etc
  Vous devez décider si vous allez leur montrer une publicité pour un magasin de matériel de montagne.

  *Regle*
  On affiche la pub si l'utilisateur·ice à une passion pour `escalade`

  *Consigne*
  Sur le modèle de l'exercice précédent, écrire le code qui détermine dans une variable `montrer_pub`s'il faut montrer la pub ou pas.
  Tester avec différentes values de `passion`


  #an[
    ```
    passion="alpinisme"

    montrer_pub = passion == "escalade"

    print(montrer_pub) # Affiche True s'il faut montrer la pub
    ```
  ]
]

#ex("Pub suite")[
  Modifier le programme précédent pour prendre en compte cette nouvelle règle:

  On affiche aussi la pub quand `passion` est `alpinisme`
  #an[
    ```
    passion="alpinisme"

    montrer_pub=passion == "escalade" or passion == "alpinisme"

    print(montrer_pub) # Affiche True s'il faut montrer la pub
    ```

  ]
]

#ex("Echanger la valeur de deux variables (difficile)")[
  On aimerait échanger la _valeur_ de deux variables
  ```
  a="pizza"
  b="kebab"`

  # Echanger le contenu des deux variables, sans réécrire pizza ou kebab
  # votre code ici
  # ...
  # ...

  print(a) # doit afficher "pizza"
  print(b) # doit afficher "kebab"
  ```

  #an[```
    # On doit utiliser une troisième variable:
    # Si on écrit a=b, puis b=a on a perdu "pizza"
    c=b
    b=a
    a=c
    ```
  ]
]
