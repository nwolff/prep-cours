#import "/template-exercices.typ": *

#show: series

#title[ Exercices python : Entrées - Sorties]

#ex("print avec plusieurs éléments")[

  - Créer une variable `age` (entier) avec votre âge
  - Créer une variable `prenom` (chaîne) avec votre prénom
  - Afficher "Nom : \<nom> , Age : \<age>" en utilisant `print` avec plusieurs éléments séparés par des virgules

  #an[```
    age = 20
    prénom = "Alice"
    print("Bonjour, je m'appelle", prénom, "et j'ai", age, "ans.")
    ```
  ]
]

#ex("Saisie et affichage")[

  - Demander à l’utilisateur son prénom avec `input`
  - Afficher "Bonjour \<prénom> !" avec `print`

  #an[```
    prénom = input("Entrez votre prénom : ")
    print("Bonjour", prénom, "!")
    ```
  ]
]

#ex("Conversion en entier")[

  - Demander l’âge de l’utilisateur avec `input`
  - Convertir en `int`
  - Afficher son âge dans 10 ans, en faisant une phrase complète

  #an[```
    age_str = input("Quel est ton âge ? ")
    age = int(age_str)
    print("Dans 10 ans tu auras", age + 10, "ans.")
    ```
  ]
]

#ex("Conversion en décimal (float)")[

  - Demander un nombre décimal
  - Convertir en `float`
  - Afficher "Le double de \<nombre-donné> est \<résultat-du-calcul>"

  #an[```
    x_str = input("Tape un nombre décimal : ")
    x = float(x_str)
    print("Le double de", x, "est", x * 2)
    ```
  ]
]

#ex("Ville et code postal")[

  - Créer `ville` (str) et `code_postal` (int).
  - Afficher une phrase d’adresse "Je vis à \<ville> (\<code_postal>)" :

  #an[```python
    ville = "Lausanne"
    code_postal = 1005
    print("Je vis à", ville, "(", code_postal, ")")
    ```
  ]
]

#ex("Deux entiers : somme et produit")[

  - Demander deux entiers à l’utilisateur
  - Afficher la somme avec une phrase complète.
  - Afficher le produit avec une phrase complète.

  #an[```python
    a = int(input("Premier entier : "))
    b = int(input("Deuxième entier : "))
    print("Somme :", a + b, "| Produit :", a * b)
    ```
  ]
]
