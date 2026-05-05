#import "/template-exercices.typ": *

#show: series

#title[ Exercices python : Entrées - Sorties]

/*
// concept: variables de types mixtes + print avec virgules, sans input
#ex("print avec plusieurs éléments")[

  - Créer une variable `age` (entier) avec votre âge
  - Créer une variable `prénom` (chaîne) avec votre prénom
  - Afficher "Nom : \<nom> , Age : \<age>" en utilisant `print` avec plusieurs éléments séparés par des virgules

  #an[```
    age = 20
    prénom = "Alice"
    print("Bonjour, je m'appelle", prénom, "et j'ai", age, "ans.")
    ```
  ]
]
*/

// concept: variables de types mixtes (str + int) + print avec virgules, sans input
#ex("Ville et code postal")[
  Écrire un programme qui :
  - Crée deux variables `ville` (str) et `code_postal` (int), avec des valeurs de votre choix.
  - Utilise les variables pour afficher la phrase : `Je vis à <ville> ( <code_postal> )`

  #an[```
    ville = "Lausanne"
    code_postal = 1005
    print("Je vis à", ville, "(", code_postal, ")")
    ```
  ]
]

/*
// concept: premier input, pas de conversion
#ex("Saisie et affichage")[

  - Demander à l'utilisateur son prénom avec `input`
  - Afficher "Bonjour \<prénom> !" avec `print`

  #an[```
    prénom = input("Entrez votre prénom : ")
    print("Bonjour", prénom, "!")
    ```
  ]
]
*/

// concept: plusieurs inputs sans conversion, assembler une phrase
#ex("Nom et âge")[
  Écrire un programme qui :
  - Demande à l'utilisateur son nom et son âge
  - Ensuite utilise ces éléments dans une phrase.
    #linebreak()
    Par exemple `Bonjour <nom> , vous avez <age>`

  #an[```
    age = input("Donne moi ton age : ")
    nom = input("Quel ton nom hombre: ")
    print("Tu t'appelles", nom, "et tu as", age, "ans")
    ```
  ]
]

// concept: introduire int() et float(), expressions
#ex("Conversions de types")[
  Écrire un programme qui fait deux choses :
  - Demande un prix, le convertit en `int`, et affiche le prix avec 10% de réduction
  - Demande une distance en kilomètres, la convertit en `float`, et affiche cette distance en mètres.

  #an[```
    prix_str = input("Quel est le prix ? ")
    prix = int(prix_str)
    print(prix * 0.9)

    km_str = input("Distance en km : ")
    km = float(km_str)
    print(km * 1000)
    ```
  ]
]

/*
#ex("Conversion en entier")[

  - Demander l'âge de l'utilisateur avec `input`
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
*/

// concept: contraster int(input()) en une ligne vs deux étapes séparées
#ex("Conversion en une ou deux étapes")[
  Ces deux programmes font exactement la même chose :

  *En deux étapes :*
  ```
  age_str = input("Quel est ton âge ? ")
  age = int(age_str)
  print("Dans 10 ans tu auras", age + 10, "ans.")
  ```

  *En une seule ligne :*
  ```
  age = int(input("Quel est ton âge ? "))
  print("Dans 10 ans tu auras", age + 10, "ans.")
  ```

  *À retenir :*
  - En deux étapes : plus lisible pour débuter, utile pour déboguer.
  - En une ligne : plus compact, c'est le style qu'on voit le plus souvent.

  *Consigne :* Réécrire ces deux lignes en une seule :
  ```
  prix_str = input("Quel est le prix unitaire ? ")
  prix = float(prix_str)
  ```

  #an[```
    prix = float(input("Quel est le prix unitaire ? "))
    ```
  ]
]

// concept: plusieurs inputs convertis, calculs arithmétiques, plusieurs print, littéraux str qui ressemblent à des opérateurs
#ex("Somme et produit")[

  - Demander deux nombres décimaux à l'utilisateur.
  - Afficher la somme sous la forme `<a> + <b> = <résultat>`.
  - Afficher le produit sous la forme `<a> * <b> = <résultat>`.

  #an[```
    a = float(input("Premier nombre : "))
    b = float(input("Deuxième nombre : "))
    print(a, "+", b, "=", a + b)
    print(a, "*", b, "=", a * b)
    ```
  ]
]

// concept: float inputs, variables intermédiaires, formules géométriques dont racine carrée
#ex("Calculs rectangle")[
  Écrire un programme qui demande à l'utilisateur les 2 côtés a et b d'un rectangle, pour ensuite en donner (afficher) trois choses :
  - la surface. Formule :  $a . b$
  - le périmètre. La formule est simple,  à vous de la retrouver, éventuellement en faisant un schéma
  - la longueur de la diagonale. Formule: $sqrt(a^2 + b^2)$

  Testez votre programme en même temps que vous l'écrivez. Pour ça il faut que vous sachiez quelles sont les valeurs correctes que le programme devrait afficher. Réfléchissez à un rectangle simple mais pas trop simple qui fait l'affaire.

  #an[```
    a = float(input("Coté a: "))
    b = float(input("Coté b: "))

    surface = a * b
    print("Surface:", surface)

    périmètre = (a + b) * 2
    print("Périmètre:", périmètre)

    diagonale = (a**2 + b**2) ** 0.5
    print("Diagonale:", diagonale)

    # On peut tester avec le triangle rectangle bien connu 3, 4, 5
  ```]
]

// concept: mélanger str et int inputs, calcul avec une constante, mise en situation
#ex("Tous centenaires")[
  Écrire un programme qui :
  - Demande à l'utilisateur·trice son nom et son année de naissance
  - Calcule l'âge que la personne aura à la fin de l'année (prenez un moment pour réfléchir, le calcul est simple).
  - Affiche `Félicitations <nom> ! À la fin de l'année vous aurez <age_calculé> ans.`

  #an[```
   nom = input("Prénom: ")
   naissance = int(input("Année de naissance: "))
   année_courante = 2026
   print("Félicitations", nom, "! À la fin de l'année vous aurez", année_courante - naissance, "ans.")
  ```]
]

// concept: contraster print(virgules) vs concaténation +, nécessité de str() pour les nombres
#ex("Concaténation vs print")[
  Ces deux programmes affichent exactement la même chose :

  *Avec `print` et des virgules :*
  ```
  prénom = "Alice"
  age = 30
  print("Bonjour", prénom, "! Tu as", age, "ans.")
  ```

  *Avec la concaténation `+` :*
  ```
  prénom = "Alice"
  age = 30
  print("Bonjour " + prénom + " ! Tu as " + str(age) + " ans.")
  ```

  *À retenir :*
  - Avec les virgules : simple, mais `print` ajoute des espaces automatiquement entre chaque élément.
  - Avec `+` : contrôle total du texte, mais les nombres doivent être convertis avec `str()`.

  *Consigne :* Réécrire cette ligne en utilisant la concaténation à la place des virgules :
  ```
  altitude = 496
  print("Lausanne est à", altitude, "mètres d'altitude.")
  ```

  #an[```
    print("Lausanne est à " + str(altitude) + " mètres d'altitude.")
    ```
  ]
]

// concept: choisir des noms de variables expressifs, abréger sans perdre le sens
#ex("Choix de noms de variables")[
  Compléter le programme en choisissant de bons noms de variables (en français, sans espaces, sans majuscules) :

  ```
  ............... = input("Quelle est votre destination de vacances ?")
  ............... = input("Quel mode de transport allez-vous utiliser ?")
  ............... = int(input("Quel est votre nombre d'enfants ?"))
  ............... = input("Quelle est votre date de naissance ?")
  ............... = float(input("Quelle est la température minimale enregistrée aujourd'hui ?"))
  ............... = int(input("Quel est le nombre maximum de passagers autorisés dans le véhicule ?"))
  ............... = float(input("Quelle est la distance en kilomètres entre votre domicile et votre lieu de travail ?"))
  ............... = input("Quel est votre numéro de téléphone d'urgence ?")
  ```

  #an[```
    destination = input("Quelle est votre destination de vacances ?")
    mode_transport = input("Quel mode de transport allez-vous utiliser ?")
    nb_enfants = int(input("Quel est votre nombre d'enfants ?"))
    date_naissance = input("Quelle est votre date de naissance ?")
    temp_min = float(input("Quelle est la température minimale enregistrée aujourd'hui ?"))
    nb_passagers_max = int(input("Quel est le nombre maximum de passagers autorisés dans le véhicule ?"))
    dist_domicile_travail = float(input("Quelle est la distance en kilomètres entre votre domicile et votre lieu de travail ?"))
    tel_urgence = input("Quel est votre numéro de téléphone d'urgence ?")
    ```
  ]
]

// concept: lire et simuler l'exécution; les commentaires ne sont pas exécutés
#ex("Une trace")[
  Écrire la trace de l'exécution de ce programme:
  ```
  texte = "42"
  n = int(texte)
  # on calcule le double
  double = n * 2
  message = "Double: " + str(double)
  print(message)
  print("Résultat:", n)
  ```

  #table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 2fr),
    [*ligne*], an[*texte*], an[*n*], an[*double*], an[*message*], [*affichage*],
    "1", an[`"42"`], [], [], [], [],
    "2", [], an[`42`], [], [], [],
    "3", [], [], [], [], [],
    "4", [], [], an[`84`], [], [],
    "5", [], [], [], an[`"Double: 84"`], [],
    "6", [], [], [], [], an[`Double: 84`],
    "7", [], [], [], [], an[`Résultat: 42`],
  )
]

// concept: comparaisons numériques, afficher une valeur booléenne
#ex("Comparer deux nombres")[
  Écrire un programme qui :
  - Demande deux nombres à l'utilisateur
  - Affiche `Le premier est plus grand : <True ou False selon les cas>`
  - Affiche `Les deux sont égaux : <True ou False selon les cas>`

  #an[```
    a = int(input("Premier nombre : "))
    b = int(input("Deuxième nombre : "))
    print("Le premier est plus grand :", a > b)
    print("Les deux sont égaux :", a == b)
    ```
  ]
]

// concept: comparer deux chaînes avec ==
#ex("Mot de passe")[
  Écrire un programme qui :
  - Stocke un mot de passe dans une variable (par exemple `"secret123"`)
  - Demande à l'utilisateur de saisir un mot de passe
  - Affiche `True` si le mot de passe saisi est correct, `False` sinon

  #an[```
    mot_de_passe = "secret123"
    saisi = input("Mot de passe : ")
    print(saisi == mot_de_passe)
    ```
  ]
]

// concept: piège classique — comparer comme str vs comme int
#ex("Texte ou nombre ?")[
  Que va afficher ce programme si l'utilisateur entre `10` puis `9` ?

  ```
  a = input("Premier : ")
  b = input("Deuxième : ")
  print(a > b)
  ```

  Réécrire le programme pour qu'il compare les valeurs comme des nombres.

  #an[
    Avec les saisies `10` et `9`, le programme affiche `False` : la comparaison
    se fait caractère par caractère, et `"1"` est plus petit que `"9"`.

    ```
    a = int(input("Premier : "))
    b = int(input("Deuxième : "))
    print(a > b)
    ```
  ]
]
