#import "/template-exercices.typ": *

#show: series

#title[ Exercices python : Entrées - Sorties]

#ex("Variables simples")[

  - Crée une variable `age` (entier) avec ton âge.
  - Crée une variable `prenom` (chaîne) avec ton prénom.
  - Affiche "Nom : \<nom> , Age : \<age>" en utilisant `print` avec plusieurs éléments séparés par des virgules.

  #an[```
    age = 20
    prenom = "Alice"
    print("Bonjour, je m'appelle", prenom, "et j'ai", age, "ans.")
    ```
  ]
]

#ex("Saisie et affichage")[

  - Demande à l’utilisateur son prénom avec `input`.
  - Affiche "Bonjour \<prenom> !" avec `print`.

  #an[```
    prenom = input("Entrez votre prénom : ")
    print("Bonjour", prenom, "!")
    ```
  ]
]

#ex("Conversion en entier")[

  - Demande l’âge de l’utilisateur avec `input`.
  - Convertis en `int`.
  - Affiche son âge dans 10 ans, en faisant une phrase complète.

  #an[```
    age_str = input("Quel est ton âge ? ")
    age = int(age_str)
    print("Dans 10 ans tu auras", age + 10, "ans.")
    ```
  ]
]

#ex("Conversion en décimal (float)")[

  - Demande un nombre décimal (ex. 2.5).
  - Convertis en `float`.
  - Affiche "Le double de \<nombre-donné> est \<résultat-du-calcul>"

  #an[```
    x_str = input("Tape un nombre décimal : ")
    x = float(x_str)
    print("Le double de", x, "est", x * 2)
    ```
  ]
]

#ex("Ville et code postal")[

  - Crée `ville` (chaîne) et `code_postal` (entier).
  - Affiche une phrase d’adresse "Je vis à \<ville> (\<code_postal>)" :

  #an[```python
    ville = "Lausanne"
    code_postal = 1005
    print("Je vis à", ville, "(", code_postal, ")")
    ```
  ]
]

#ex("Deux entiers : somme et produit")[

  - Demande deux entiers à l’utilisateur.
  - Affiche la somme avec une phrase complète.
  - Affiche le produit avec une phrase complète.

  #an[```python
    a = int(input("Premier entier : "))
    b = int(input("Deuxième entier : "))
    print("Somme :", a + b, "| Produit :", a * b)
    ```
  ]
]
