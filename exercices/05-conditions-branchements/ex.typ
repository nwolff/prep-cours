#import "/exercices/template.typ": *

#show: series

#title[ Série d'exercices : Conditions - Branchements]

#ex("Vérifier un nombre positif")[
  - Demander un nombre décimal à l’utilisateur.
  - Si le nombre est strictement positif, afficher : `Le nombre <nombre> est positif`.
  - Dans tous les cas, afficher: `KTHXBYE`à la fin

  #an[
    ```
    n = float(input("Nombre entier : "))
    if n > 0:
      print("Le nombre", n, "est positif")
    print("KTHXBYE")
    ```
  ]
]

#ex("Pair ou impair")[
  - Demander un entier à l’utilisateur.
  - Si l’entier est pair, afficher : `Pair`. Sinon, afficher : `Impair.`

  *Indice* L'opérateur modulo (`%`) permet de tester la parité, par exemple x % 2 == 0.

  #an[
    ```
    x = int(input("Entier : "))
    if x % 2 == 0:
      print("Pair")
    else:
      print("Impair")
    ```
  ]
]

#ex("Vérifier une entrée")[
  - Demander un mot ou une phrase à l’utilisateur.
  - Si l’utilisateur n’a rien tapé, afficher : `Tu n’as rien écrit`.

  #an[
    ```
    texte = input("Entre un mot : ")
    if texte == "":
      print("Tu n'as rien écrit.")
    ```
  ]
]

#ex("Température")[
  - Demander une température en degrés Celsius (nombre décimal).
  - Si la température est inférieure à 0, afficher : `Il gèle` ! Sinon, afficher : `Il ne gèle pas`.

  #an[
    ```
    t = float(input("Température (°C) : "))
    if t < 0:
      print("Il gèle !")
    else:
      print("Il ne gèle pas.")
    ```
  ]
]

#ex("Talk about the weather")[
  - Demande une température en degrés Celsius (nombre décimal).
  - Si la température est inférieure à 0, affiche : `il gèle !`
  - Si elle est supérieure à 30, afficher : `canicule !`
  - Si elle est entre 0 et 30, afficher : `ça va`

  #an[
    ```
    t = float(input("Entrez la température : "))
    if t < 0:
      print("il gèle !")
    else:
      # Ici on sait qu'il ne gèle pas, reste à départager deux cas
      if temp > 30:
          print("canicule !")
      else:
        # On arrive ici seulement si t n'est ni <0, ni > 30
        print("ça va")
    ```
  ]
]
