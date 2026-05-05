#import "/template-exercices.typ": *

#show: series

#title[ Série d'exercices : Itération - while]

// concept: boucle while avec compteur et incrément, condition de fin
#ex("Compter jusqu’à 10")[
  Écrire un programme qui affiche les nombres de 1 à 10 avec une boucle while.

  #an[
    ```
    i = 1
    while i <= 10:
      print(i)
    i = i + 1
    ```
  ]
]

// concept: boucle while pilotée par une condition sur l'input, deux variantes (dont valeur sentinelle)
#ex("Mot de passe")[
  - Demander à l’utilisateur de taper un mot de passe.
  - Tant que ce n’est pas `python`, redemander le mot de passe.
  - Quand il est correct, afficher `Accès autorisé`.

  #an[
    ```
    mdp = input("Mot de passe : ")
    while mdp != "python":
      mdp = input("Mot de passe : ")
    print("Accès autorisé")
    ```
  ]

  Une version qui fonctionne aussi, qui évite de répèter la première ligne:
  #an[
    ```
    mdp = ""
    while mdp != "python":
      mdp = input("Mot de passe : ")
    print("Accès autorisé")
    ```
  ]
]

// concept: boucle while avec compteur, nombre d'itérations fourni par l'utilisateur
#ex("Répéter un mot")[
  - Demander à l’utilisateur un mot et un nombre.
  - Afficher le mot autant de fois que le nombre indiqué.

  #an[
    ```
    mot = input("Mot : ")
    n = int(input("Nombre de répétitions : "))
    i = 0
    while i < n:
      print(mot)
    ```
  ]
]

// concept: boucle while avec incrément de 2, filtrer une séquence sans if
#ex("Nombres pairs")[
  - Écrire un programme qui affiche uniquement les nombres pairs de 2 à 20.

  #an[
    ```
    n = 2
    while n <= 20:
      print(n)
      n = n + 2
    ```
  ]
]

// concept: boucle while avec valeur initiale invalide pour forcer l'entrée dans la boucle
#ex("Deviner un nombre")[
  - Choisir un nombre secret (par exemple 7).
  - Demander à l’utilisateur de deviner le nombre.
  - Répèter tant que la réponse n’est pas correcte.
  - Quand l’utilisateur trouve, afficher `Bravo, tu as trouvé !`

  #an[
    ```
    secret = 7
    reponse = -1 # Une valeur invalide, qui assure qu'on rentre dans la boucle
    while reponse != secret:
      reponse = int(input("Devine le nombre : "))
    print("Bravo, tu as trouvé !")
    ```
  ]
]

// concept: combiner if/else et while, boucle conditionnelle à l'entrée
#ex("Afficher des étoiles")[
  - Demander un nombre à l’utilisateur.
  - Si ce nombre est supérieur à 0, afficher autant d’étoiles `*` que ce nombre (une par ligne)
  • Si le nombre n'est pas supérieur à 0, afficher : `désolé, pas d’étoile`

  #an[
    ```
    n = int(input("Nombre : "))
    if n > 0:
      i = 0
      while i < n:
        print("*")
        i = i + 1
    else:
      print("désolé, pas d’étoile")
    ```
  ]
]
