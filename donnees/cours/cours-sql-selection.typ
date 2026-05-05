#let inputs = (
  date: datetime.today().display("[year]-[month]-[day]"),
  ..sys.inputs,
)

#let tags = sys.inputs.at("tags", default: "").split(",").filter(t => t != "")

#let section(tag, title, body) = {
  if tags.len() == 0 or tag in tags {
    pagebreak(weak: true)
    heading(level: 1)[#title]
    body
  }
}

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2cm),
  footer: context {
    set text(size: 0.9em, fill: black.lighten(30%))
    let current = counter(page).at(here()).first()
    let last = counter(page).final().first()
    if current > 1 {
      grid(
        columns: (1fr, 1fr, 1fr),
        align: (bottom + left, bottom + center, bottom + right),
        [], [#current / #last], if current == last { inputs.date },
      )
    }
  },
)

#set text(font: "Inter", size: 10pt, lang: "fr")
#set heading(numbering: "1.")
#show heading.where(level: 3): set heading(numbering: none)
#show heading.where(level: 3): set text(size: 1.1em)
#set raw(lang: "sql")
#set list(spacing: 1.2em)

#show table: it => block(breakable: false)[#it]
#show table: set align(left)
#set table(
  inset: 0.7em,
  stroke: 0.5pt + gray,
  fill: (x, y) => if y == 0 { gray.lighten(80%) } else { none },
)

#show raw.where(block: true): it => {
  set text(font: "Hack", size: 1.1em)
  block(fill: luma(248), inset: 10pt, radius: 3pt, width: 100%, breakable: false)[#it]
}

#show raw.where(block: false): it => {
  set text(font: "Hack", size: 1.1em)
  box(fill: luma(248), inset: (x: 3pt), radius: 2pt)[#it.text]
}

#let note(body) = block(
  fill: rgb("#fff8e1"),
  inset: (x: 1em, y: 0.7em),
  radius: 3pt,
  width: 100%,
  below: 1em,
)[#body]

#let h4(body) = {
  v(0.5em)
  text(weight: "bold", size: 1.1em)[#body]
}

// ─── Title ───────────────────────────────────────────────────────────────────

#align(center)[
  #v(2em)
  #text(size: 2em, weight: "bold")[SQL --- Sélection de données]
  #v(2em)
]

#outline(title: [Sommaire], depth: 1)

// ─── Content ─────────────────────────────────────────────────────────────────

#section("select", "Structure générale SELECT")[

  La commande SQL `SELECT` est commune car il est très fréquent de devoir lire les données issues d'une base de données :

  - Filtrer pour ne sélectionner que certains enregistrements
  - Classer (ordonner) les résultats
  - Grouper les résultats pour faire uniquement des statistiques (note moyenne, prix le plus élevé)
  - Joindre une autre table aux résultats

  Voici l'ordre des éléments d'une requête de sélection de données (quand toutes les parties sont présentes) :

  ```sql
  SELECT …
  FROM table
  JOIN une_autre_table ON condition
  WHERE condition
  GROUP BY expression
  HAVING condition
  ORDER BY expression
  ```

  == Commande basique

  L'utilisation basique de cette commande s'effectue de la manière suivante :

  ```sql
  SELECT colonne
  FROM table
  ```

  Cette requête va sélectionner (`SELECT`) la colonne provenant (`FROM`) de `table`.

  == Exemple

  Imaginons une base de données qui contient des informations sur les clients d'une entreprise.

  #h4[Table « clients\_villes » :]

  #table(
    columns: 4,
    [*identifiant*], [*prenom*], [*nom*], [*ville*],
    [1], [Pierre], [Dupond], [Paris],
    [2], [Sabrina], [Durand], [Nantes],
    [3], [Julien], [Martin], [Lyon],
    [4], [Pierre], [Leroy], [Marseille],
    [5], [Marie], [Leroy], [Nice],
  )

  Si l'on veut avoir la liste de toutes les villes des clients, il suffit d'effectuer la requête suivante :

  ```sql
  SELECT ville
  FROM clients_villes
  ```

  #h4[Résultat :]

  #table(
    columns: 1,
    [*ville*],
    [Paris],
    [Nantes],
    [Lyon],
    [Marseille],
    [Nice],
  )

  == Obtenir plusieurs colonnes

  Avec la même table il est possible de lire plusieurs colonnes à la fois. Il suffit de séparer les noms des colonnes par des virgules.

  ```sql
  SELECT prenom, nom
  FROM clients_villes
  ```

  #h4[Résultat :]

  #table(
    columns: 2,
    [*prenom*], [*nom*],
    [Pierre], [Dupond],
    [Sabrina], [Durand],
    [Julien], [Martin],
    [Pierre], [Leroy],
    [Marie], [Leroy],
  )

  == Obtenir toutes les colonnes d'une table

  Il est possible de retourner automatiquement toutes les colonnes d'une table sans avoir à connaître le nom de toutes les colonnes en utilisant le caractère `*` :

  ```sql
  SELECT * FROM clients_villes
  ```

  Cette requête retourne exactement les mêmes colonnes qu'il y a dans la base de données. C'est une bonne idée de commencer à écrire une requête en utilisant `*`, pour ensuite raffiner la requête en extrayant uniquement les colonnes souhaitées.

]

#section("distinct", "DISTINCT")[

  L'utilisation de la commande `SELECT` en SQL permet de lire toutes les données d'une ou plusieurs colonnes. Cette commande peut potentiellement afficher des doublons si la même donnée est présente plusieurs fois. Pour éviter les doublons, on utilise `DISTINCT`.

  == Syntaxe

  ```sql
  SELECT DISTINCT colonne
  FROM table
  ```

  Cette requête sélectionne le champ `colonne` de `table` en évitant de retourner des doublons.

  == Exemple

  Prenons le cas concret d'une table « clients\_villes » :

  #table(
    columns: 4,
    [*identifiant*], [*prenom*], [*nom*], [*ville*],
    [1], [Pierre], [Dupond], [Paris],
    [2], [Sabrina], [Durand], [Nantes],
    [3], [Julien], [Martin], [Lyon],
    [4], [Pierre], [Leroy], [Paris],
    [5], [Marie], [Leroy], [Nantes],
  )

  #v(1em)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 0pt,
    grid.vline(x: 1, stroke: 0.5pt),
    [
      #pad(right: 1.5em)[
        Sans `DISTINCT`, Pierre apparaît deux fois :

        #v(0.65em)

        ```sql
        SELECT prenom
        FROM clients_villes
        ```

        #h4[Résultat :]

        #table(
          columns: 1,
          [*prenom*],
          [Pierre],
          [Sabrina],
          [Julien],
          [Pierre],
          [Marie],
        )
      ]
    ],
    [
      #pad(left: 1.5em)[
        Avec `DISTINCT`, chaque valeur n'apparaît qu'une seule fois :

        ```sql
        SELECT DISTINCT prenom
        FROM clients_villes
        ```

        #h4[Résultat :]

        #table(
          columns: 1,
          [*prenom*],
          [Pierre],
          [Sabrina],
          [Julien],
          [Marie],
        )
      ]
    ],
  )

]

#section("alias", "AS (alias)")[

  Dans le langage SQL il est possible d'utiliser des alias pour renommer temporairement une colonne ou une table dans une requête. Cette astuce est particulièrement utile pour faciliter la lecture des requêtes.

  == Intérêt et utilité

  === Alias sur une colonne

  Permet de renommer le nom d'une colonne dans les résultats d'une requête SQL. C'est pratique pour avoir un nom facilement compréhensible dans le résultat.

  Cas concrets d'utilisations :

  - Une colonne qui s'appelle normalement `c_iso_3166` peut être renommée « code\_pays »
  - Lorsqu'une fonction est utilisée, le nom d'une colonne peut devenir un peu complexe. Il est ainsi possible de renommer la colonne de résultat.
  - Lorsque plusieurs colonnes sont combinées il est plus simple de renommer la nouvelle colonne.

  === Alias sur une table

  Permet d'attribuer un autre nom à une table dans une requête SQL. Cela peut aider à avoir des noms plus courts, plus simples à écrire, notamment dans le cas de jointures.

  == Syntaxe

  === Alias sur une colonne

  La syntaxe pour renommer une colonne de `colonne1` à `c1` est la suivante :

  ```sql
  SELECT colonne1 AS c1, colonne2
  FROM table
  ```

  === Alias sur une table

  La syntaxe pour renommer une table dans une requête est la suivante :

  ```sql
  SELECT *
  FROM table AS t1
  ```

  == Exemple

  === Renommer une colonne

  Imaginons un site d'e-commerce qui possède une table de produits avec des noms de colonnes techniques (suffixes de langue, etc.) :

  ```sql
  SELECT id, nom_fr AS nom, description_fr AS description, prix
  FROM produit
  ```

  #h4[Résultat :]

  #table(
    columns: 4,
    [*id*], [*nom*], [*description*], [*prix*],
    [1], [Ecran], [Ecran de grandes tailles.], [399.99],
    [2], [Clavier], [Clavier sans fil.], [27],
    [3], [Souris], [Souris sans fil.], [24],
    [4], [Ordinateur portable], [Grande autonomie et sacoche offerte.], [700],
  )

  Comme nous pouvons le constater les colonnes ont été renommées.

  === Renommer une ou plusieurs tables

  La requête ci-dessous renomme la table `produit` en `p` et la table `produit_categorie` en `pc` (plus court et donc plus rapide à écrire) :

  ```sql
  SELECT p.id, p.nom, pc.id, pc.nom
  FROM produit AS p
  LEFT JOIN produit_categorie AS pc ON p.categorie_id = pc.id
  ```

  Cette astuce est encore plus pratique lorsqu'il y a des noms de tables encore plus compliqués et lorsqu'il y a beaucoup de jointures.

]

#section("where", "WHERE")[

  La commande `WHERE` dans une requête SQL permet d'extraire les lignes d'une base de données qui respectent une condition.

  == Syntaxe

  ```sql
  SELECT nom_colonnes
  FROM nom_table
  WHERE condition
  ```

  == Exemple

  Imaginons une base de données appelée « clients\_commandes » qui contient le nom des clients, le nombre de commandes qu'ils ont effectuées et leur ville.

  #table(
    columns: 4,
    [*id*], [*nom*], [*nbr\_commande*], [*ville*],
    [1], [Paul], [3], [Paris],
    [2], [Maurice], [0], [Rennes],
    [3], [Joséphine], [1], [Toulouse],
    [4], [Gérard], [7], [Paris],
  )

  Pour obtenir seulement la liste des clients qui habitent à Paris :

  ```sql
  SELECT *
  FROM clients_commandes
  WHERE ville = 'Paris'
  ```

  #h4[Résultat :]

  #table(
    columns: 4,
    [*id*], [*nom*], [*nbr\_commande*], [*ville*],
    [1], [Paul], [3], [Paris],
    [4], [Gérard], [7], [Paris],
  )

  #note[*Attention :* les comparaisons sont sensibles aux majuscules/minuscules. Si on avait par exemple écrit `WHERE ville = 'paris'`, aucun résultat n'aurait été retourné.]

]

#section("operateurs", "Opérateurs de comparaison")[

  Il existe plusieurs opérateurs de comparaison. La liste ci-jointe présente quelques-uns des opérateurs les plus couramment utilisés :

  #table(
    columns: 2,
    [*Opérateur*], [*Description*],
    [`=`], [Égal],
    [`<>`], [Pas égal],
    [`!=`], [Pas égal],
    [`>`], [Supérieur à],
    [`<`], [Inférieur à],
    [`>=`], [Supérieur ou égal à],
    [`<=`], [Inférieur ou égal à],
    [`IN`], [Liste de plusieurs valeurs possibles],
    [`BETWEEN … AND …`], [Valeur comprise dans un intervalle donné (utile pour les nombres ou dates)],
    [`LIKE`], [Recherche en spécifiant le début, milieu ou fin d'un mot],
    [`IS NULL`], [Valeur est nulle],
    [`IS NOT NULL`], [Valeur n'est pas nulle],
  )

  On peut comparer une colonne avec une valeur (par exemple `age >= 18` ou `ville = 'genève'`).

  On peut aussi comparer deux colonnes entre elles (par exemple `recettes > dépenses`).

  Comparer deux valeurs entre elles n'est pas utile (par exemple la condition `'A' = 'B'` n'est jamais satisfaite, et la requête retournera toujours un résultat vide).

]

#section("and-or", "AND & OR")[

  Une requête SQL peut être restreinte à l'aide de la condition `WHERE`. Les opérateurs logiques `AND` et `OR` peuvent être utilisés pour combiner plusieurs conditions.

  == Syntaxe d'utilisation des opérateurs AND et OR

  L'opérateur `AND` permet de s'assurer que la condition1 ET la condition2 sont vraies :

  ```sql
  SELECT colonnes FROM table
  WHERE condition1 AND condition2
  ```

  L'opérateur `OR` vérifie quant à lui que la condition1 OU la condition2 sont vraies :

  ```sql
  SELECT colonnes FROM table
  WHERE condition1 OR condition2
  ```

  Ces opérateurs peuvent être combinés à l'infini et mélangés :

  ```sql
  SELECT nom_colonnes FROM nom_table
  WHERE condition1 AND (condition2 OR condition3)
  ```

  #note[*Attention :* il faut penser à utiliser des parenthèses lorsque c'est nécessaire. Cela permet d'éviter les erreurs et facilite la lecture de la requête.]

  == Exemple de données

  Pour illustrer les prochaines commandes, nous allons considérer la table « produits » suivante :

  #table(
    columns: 5,
    [*id*], [*nom*], [*categorie*], [*stock*], [*prix*],
    [1], [ordinateur], [informatique], [5], [950],
    [2], [clavier], [informatique], [32], [35],
    [3], [souris], [informatique], [16], [30],
    [4], [crayon], [fourniture], [147], [2],
  )

  == Opérateur AND

  ```sql
  SELECT * FROM produits
  WHERE categorie = 'informatique' AND stock < 20
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*categorie*], [*stock*], [*prix*],
    [1], [ordinateur], [informatique], [5], [950],
    [3], [souris], [informatique], [16], [30],
  )

  == Opérateur OR

  Pour filtrer les données pour avoir uniquement les données sur les produits « ordinateur » ou « clavier » :

  ```sql
  SELECT * FROM produits
  WHERE nom = 'ordinateur' OR nom = 'clavier'
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*categorie*], [*stock*], [*prix*],
    [1], [ordinateur], [informatique], [5], [950],
    [2], [clavier], [informatique], [32], [35],
  )

  == Combiner AND et OR

  Les opérateurs peuvent être combinés pour effectuer de puissantes recherches :

  ```sql
  SELECT * FROM produits
  WHERE (categorie = 'informatique' AND stock < 20)
     OR (categorie = 'fourniture' AND stock < 200)
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*categorie*], [*stock*], [*prix*],
    [1], [ordinateur], [informatique], [5], [950],
    [3], [souris], [informatique], [16], [30],
    [4], [crayon], [fourniture], [147], [2],
  )

  #note[Noter l'utilisation de parenthèses pour contrôler l'ordre d'application des opérateurs `AND` et `OR`.]

]

#section("in", "IN")[

  L'opérateur logique `IN` dans SQL s'utilise avec la commande `WHERE` pour vérifier si une colonne est égale à une des valeurs d'une liste.

  == Syntaxe

  ```sql
  SELECT colonne FROM table
  WHERE colonne IN (valeur1, valeur2, valeur3, ...)
  ```

  Entre les parenthèses il n'y a pas de limite du nombre d'arguments.

  == Compacité de l'opérateur IN

  L'opérateur `IN` permet d'écrire des requêtes plus compactes qu'avec une suite de `OR` :

  === Requête avec plusieurs OR

  ```sql
  SELECT prenom FROM utilisateur
  WHERE prenom = 'Maurice' OR prenom = 'Marie' OR prenom = 'Thimoté'
  ```

  === Requête équivalente avec l'opérateur IN

  ```sql
  SELECT prenom FROM utilisateur
  WHERE prenom IN ('Maurice', 'Marie', 'Thimoté')
  ```

  == Exemple

  Imaginons une table « adresse » qui contient une liste d'adresses associées à des utilisateurs d'une application.

  #table(
    columns: 5,
    [*id*], [*id\_utilisateur*], [*addr\_rue*], [*addr\_code\_postal*], [*addr\_ville*],
    [1], [23], [35 Rue Madeleine Pelletier], [25250], [Bournois],
    [2], [43], [21 Rue du Moulin Collet], [75006], [Paris],
    [3], [65], [28 Avenue de Cornouaille], [27220], [Mousseaux-Neuville],
    [4], [67], [41 Rue Marcel de la Provoté], [76430], [Graimbouville],
    [5], [68], [18 Avenue de Navarre], [75009], [Paris],
  )

  Pour obtenir les enregistrements des adresses de Paris et de Graimbouville :

  ```sql
  SELECT * FROM adresse
  WHERE addr_ville IN ('Paris', 'Graimbouville')
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*id\_utilisateur*], [*addr\_rue*], [*addr\_code\_postal*], [*addr\_ville*],
    [2], [43], [21 Rue du Moulin Collet], [75006], [Paris],
    [4], [67], [41 Rue Marcel de la Provoté], [76430], [Graimbouville],
    [5], [68], [18 Avenue de Navarre], [75009], [Paris],
  )

  == Exclure avec NOT IN

  À l'inverse, pour exclure les adresses de Paris et Graimbouville :

  ```sql
  SELECT * FROM adresse
  WHERE addr_ville NOT IN ('Paris', 'Graimbouville')
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*id\_utilisateur*], [*addr\_rue*], [*addr\_code\_postal*], [*addr\_ville*],
    [1], [23], [35 Rue Madeleine Pelletier], [25250], [Bournois],
    [3], [65], [28 Avenue de Cornouaille], [27220], [Mousseaux-Neuville],
  )

]

#section("between", "BETWEEN … AND …")[

  L'opérateur `BETWEEN` est utilisé dans une requête SQL pour sélectionner un intervalle de données dans une requête utilisant `WHERE`.

  == Syntaxe

  ```sql
  SELECT * FROM table
  WHERE colonne BETWEEN 'valeur1' AND 'valeur2'
  ```

  La requête retournera toutes les lignes dont la valeur de la colonne est comprise entre valeur1 et valeur2, *bornes incluses*.

  == Exemple : filtrer entre 2 dates

  Imaginons une table « utilisateurs » qui contient les membres d'une application en ligne.

  #table(
    columns: 5,
    [*id*], [*nom*], [*prenom*], [*date\_inscription*], [*tarif\_total*],
    [1], [Durand], [Maurice], [2012-02-05], [145],
    [2], [Dupond], [Fabrice], [2012-02-07], [65],
    [3], [Durand], [Fabienne], [2012-02-13], [90],
    [4], [Dubois], [Chloé], [2012-02-16], [98],
    [5], [Dubois], [Simon], [2012-02-23], [27],
  )

  Pour obtenir les membres qui se sont inscrits entre le 10 et le 16 février 2012 :

  ```sql
  SELECT * FROM utilisateurs
  WHERE date_inscription BETWEEN '2012-02-10' AND '2012-02-16'
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*prenom*], [*date\_inscription*], [*tarif\_total*],
    [3], [Durand], [Fabienne], [2012-02-13], [90],
    [4], [Dubois], [Chloé], [2012-02-16], [98],
  )

  == Exclure avec NOT BETWEEN

  Pour obtenir tous les résultats dont l'identifiant n'est pas situé entre 2 et 4 :

  ```sql
  SELECT * FROM utilisateurs
  WHERE id NOT BETWEEN 2 AND 4
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*prenom*], [*date\_inscription*], [*tarif\_total*],
    [1], [Durand], [Maurice], [2012-02-05], [145],
    [5], [Dubois], [Simon], [2012-02-23], [27],
  )

  == Bornes incluses dans l'intervalle

  L'opérateur `BETWEEN` inclut les bornes. Cette requête :

  ```sql
  SELECT * FROM table
  WHERE colonne BETWEEN 'valeur1' AND 'valeur2'
  ```

  Est équivalente à :

  ```sql
  SELECT * FROM table
  WHERE colonne >= 'valeur1' AND colonne <= 'valeur2'
  ```

]

#section("like", "LIKE")[

  L'opérateur `LIKE` est utilisé dans la clause `WHERE` des requêtes SQL. Ce mot-clé permet d'effectuer une recherche sur un modèle particulier.

  == Syntaxe

  ```sql
  SELECT * FROM table
  WHERE colonne LIKE modele
  ```

  Le « modèle » ressemble très généralement à l'un des exemples suivants :

  - `LIKE '%er'` : le caractère `%` est un caractère joker qui remplace tous les autres caractères. Ce modèle permet de rechercher tous les enregistrements qui se terminent par « er ».
  - `LIKE 'M%'` : ce modèle permet de rechercher tous les enregistrements qui commencent par un « M ».
  - `LIKE '%et%'` : ce modèle est utilisé pour rechercher tous les enregistrements qui contiennent la séquence « et ».
  - `LIKE 'pa%on'` : ce modèle permet de rechercher les chaînes qui commencent par « pa » et qui se terminent par « on », comme « pantalon » ou « pardon ».

  == Exemple

  Imaginons une table « clients\_villes » :

  #table(
    columns: 4,
    [*identifiant*], [*prenom*], [*nom*], [*ville*],
    [1], [Pierre], [Dupond], [Paris],
    [2], [Sabrina], [Durand], [Nantes],
    [3], [Julien], [Martin], [Lyon],
    [4], [Pierre], [Leroy], [Marseille],
    [5], [Marie], [Leroy], [Nice],
  )

  === Obtenir les résultats qui commencent par « N »

  ```sql
  SELECT * FROM clients_villes
  WHERE ville LIKE 'N%'
  ```

  Avec cette requête, seuls les enregistrements suivants seront retournés :

  #table(
    columns: 4,
    [*id*], [*prenom*], [*nom*], [*ville*],
    [2], [Sabrina], [Durand], [Nantes],
    [5], [Marie], [Leroy], [Nice],
  )

  === Obtenir les résultats qui se terminent par « e »

  ```sql
  SELECT * FROM clients_villes
  WHERE ville LIKE '%e'
  ```

  #h4[Résultat :]

  #table(
    columns: 4,
    [*id*], [*prenom*], [*nom*], [*ville*],
    [4], [Pierre], [Leroy], [Marseille],
    [5], [Marie], [Leroy], [Nice],
  )

]

#section("null", "IS NULL / IS NOT NULL")[

  Dans le langage SQL, l'opérateur `IS` permet de filtrer les résultats qui contiennent la valeur `NULL`. Cet opérateur est indispensable car `NULL` est une valeur spéciale qui ne peut pas être comparée avec `=`.

  == Syntaxe

  Pour filtrer les résultats où les champs d'une colonne sont à `NULL` :

  ```sql
  SELECT * FROM table
  WHERE colonne IS NULL
  ```

  À l'inverse, pour obtenir uniquement les enregistrements qui ne sont pas null :

  ```sql
  SELECT * FROM table
  WHERE colonne IS NOT NULL
  ```

  == Exemple

  Imaginons une application qui possède une table contenant les utilisateurs. Cette table possède 2 colonnes pour associer une adresse de livraison et une adresse de facturation.

  #h4[Table « utilisateurs » :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*date\_inscription*], [*fk\_adresse\_livraison\_id*], [*fk\_adresse\_facturation\_id*],
    [23], [Grégoire], [2013-02-12], [12], [12],
    [24], [Sarah], [2013-02-17], [NULL], [NULL],
    [25], [Anne], [2013-02-21], [13], [14],
    [26], [Frédérique], [2013-03-02], [NULL], [NULL],
  )

  === Exemple 1 : utilisateurs sans adresse de livraison

  ```sql
  SELECT * FROM utilisateurs
  WHERE fk_adresse_livraison_id IS NULL
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*date\_inscription*], [*fk\_adresse\_livraison\_id*], [*fk\_adresse\_facturation\_id*],
    [24], [Sarah], [2013-02-17], [NULL], [NULL],
    [26], [Frédérique], [2013-03-02], [NULL], [NULL],
  )

  Les enregistrements retournés montrent bien que seuls les utilisateurs ayant la valeur NULL pour le champ de l'adresse de livraison sont retournés.

  === Exemple 2 : utilisateurs avec une adresse de livraison

  ```sql
  SELECT * FROM utilisateurs
  WHERE fk_adresse_livraison_id IS NOT NULL
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*date\_inscription*], [*fk\_adresse\_livraison\_id*], [*fk\_adresse\_facturation\_id*],
    [23], [Grégoire], [2013-02-12], [12], [12],
    [25], [Anne], [2013-02-21], [13], [14],
  )

  Les lignes retournées sont exclusivement celles qui n'ont pas une valeur NULL pour le champ de l'adresse de livraison.

]

#section("agregation", "Fonctions d'agrégation")[

  Il existe plusieurs fonctions qui peuvent être utilisées pour calculer une valeur concernant plusieurs enregistrements. Ces fonctions s'appliquent à une colonne et retournent une valeur unique.

  == Exemple d'utilisation

  Prenons en considération une table « achats » qui résume les ventes d'une boutique :

  #table(
    columns: 4,
    [*id*], [*client*], [*prix*], [*date*],
    [1], [Pierre], [102], [2012-10-23],
    [2], [Simon], [47], [2012-10-27],
    [3], [Marie], [18], [2012-11-05],
    [4], [Marie], [20], [2012-11-14],
    [5], [Pierre], [160], [2012-12-03],
  )

  Pour obtenir le montant total pour Pierre :

  ```sql
  SELECT client, SUM(prix)
  FROM achat
  WHERE client = 'Pierre'
  ```

  On obtient :

  #table(
    columns: 2,
    [*Client*], [*SUM(prix)*],
    [Pierre], [262],
  )

  == Liste des fonctions d'agrégation

  Les principales fonctions d'agrégation sont :

  - `COUNT(…)` pour compter le nombre de lignes concernées. Permet par exemple de savoir combien d'achats ont été effectués par un client.
  - `SUM(…)` pour calculer la somme de plusieurs valeurs. Permet par exemple de connaître le total de tous les achats d'un client.
  - `MIN(…)` pour récupérer la plus petite valeur. Utile par exemple pour connaître la date du premier achat d'un client.
  - `MAX(…)` pour récupérer la plus grande valeur. Pratique pour connaître l'achat le plus cher.
  - `AVG(…)` pour calculer la moyenne d'un ensemble de valeurs. Permet de connaître le prix du panier moyen pour chaque client.

]

#section("group-by", "GROUP BY")[

  La commande `GROUP BY` est utilisée en SQL pour grouper plusieurs résultats et utiliser une fonction d'agrégation sur un groupe de résultats.

  == Syntaxe d'utilisation de GROUP BY

  ```sql
  SELECT colonne1, fonction_d_agregation(colonne2)
  FROM table
  GROUP BY colonne1
  ```

  == Exemple d'utilisation

  Prenons en considération une table « achats » :

  #table(
    columns: 4,
    [*id*], [*client*], [*prix*], [*date*],
    [1], [Pierre], [102], [2012-10-23],
    [2], [Simon], [47], [2012-10-27],
    [3], [Marie], [18], [2012-11-05],
    [4], [Marie], [20], [2012-11-14],
    [5], [Pierre], [160], [2012-12-03],
  )

  Pour obtenir le montant total pour chaque client :

  ```sql
  SELECT client, SUM(prix) FROM achat
  GROUP BY client
  ```

  La fonction `SUM()` additionne la valeur de chaque prix pour un même client. Le résultat est :

  #table(
    columns: 2,
    [*client*], [*SUM(prix)*],
    [Pierre], [262],
    [Simon], [47],
    [Marie], [38],
  )

  #note[*Attention* --- Quand on groupe il ne faut plus accéder aux attributs de chaque rangée. Par exemple la requête suivante n'a pas de sens car `prix` va simplement retourner le prix d'_un_ achat arbitraire du client :

    ```sql
    SELECT client, prix FROM achat
    GROUP BY client
    ```]

]

#section("having", "HAVING")[

  La clause `HAVING` en SQL permet de filtrer des groupements. Elle ressemble à la clause `WHERE` (qui filtre des lignes), sauf que `HAVING` filtre des groupes.

  == Syntaxe

  ```sql
  SELECT colonne1, SUM(colonne2) FROM table
  GROUP BY colonne1
  HAVING fonction(colonne2) operateur valeur
  ```

  Cela permet de n'inclure que les groupes pour lesquels la condition `HAVING` est respectée.

  == Exemple

  Imaginons une table « achats » qui contient les achats de différents clients avec le coût du panier pour chaque achat.

  #table(
    columns: 4,
    [*id*], [*client*], [*prix*], [*date\_achat*],
    [1], [Pierre], [102], [2012-10-23],
    [2], [Simon], [47], [2012-10-27],
    [3], [Marie], [18], [2012-11-05],
    [4], [Marie], [20], [2012-11-14],
    [5], [Pierre], [160], [2012-12-03],
  )

  Pour récupérer la liste des clients qui ont commandé plus de 40€ au total :

  ```sql
  SELECT client, SUM(prix) FROM achat
  GROUP BY client
  HAVING SUM(prix) > 40
  ```

  #h4[Résultat :]

  #table(
    columns: 2,
    [*client*], [*SUM(prix)*],
    [Pierre], [262],
    [Simon], [47],
  )

  La cliente « Marie » a cumulé 38€ d'achat (un achat de 18€ et un autre de 20€) ce qui est inférieur à la limite de 40€ imposée par le `HAVING`.

]

#section("order-by", "ORDER BY")[

  La clause `ORDER BY` permet d'ordonner les lignes dans un résultat d'une requête SQL. Il est possible d'ordonner par ordre ascendant (par défaut) ou DESCendant. Il est également possible d'ordonner d'après plusieurs colonnes.

  == Syntaxe

  Une requête avec tri sur une seule colonne :

  ```sql
  SELECT colonne1, colonne2 FROM table
  ORDER BY colonne1
  ```

  Par défaut les résultats sont classés par ordre ascendant. Il est possible d'inverser l'ordre avec `DESC`, et de trier sur plusieurs colonnes :

  ```sql
  SELECT colonne1, colonne2, colonne3 FROM table
  ORDER BY colonne1 DESC, colonne2
  ```

  == Exemples

  Nous allons considérer une base avec une table « utilisateurs » :

  #table(
    columns: 5,
    [*id*], [*nom*], [*prenom*], [*date\_inscription*], [*tarif\_total*],
    [1], [Durand], [Maurice], [2012-02-05], [145],
    [2], [Dupond], [Fabrice], [2012-02-07], [65],
    [3], [Durand], [Fabienne], [2012-02-13], [90],
    [4], [Dubois], [Chloé], [2012-02-16], [98],
    [5], [Dubois], [Simon], [2012-02-23], [27],
  )

  Pour récupérer la liste par ordre alphabétique du nom de famille :

  ```sql
  SELECT *
  FROM utilisateurs
  ORDER BY nom
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*prenom*], [*date\_inscription*], [*tarif\_total*],
    [4], [Dubois], [Chloé], [2012-02-16], [98],
    [5], [Dubois], [Simon], [2012-02-23], [27],
    [2], [Dupond], [Fabrice], [2012-02-07], [65],
    [1], [Durand], [Maurice], [2012-02-05], [145],
    [3], [Durand], [Fabienne], [2012-02-13], [90],
  )

  En spécifiant plusieurs colonnes de tri, les utilisateurs sont triés par nom de famille, puis pour les mêmes noms par date d'inscription décroissante :

  ```sql
  SELECT *
  FROM utilisateurs
  ORDER BY nom, date_inscription DESC
  ```

  #h4[Résultat :]

  #table(
    columns: 5,
    [*id*], [*nom*], [*prenom*], [*date\_inscription*], [*tarif\_total*],
    [5], [Dubois], [Simon], [2012-02-23], [27],
    [4], [Dubois], [Chloé], [2012-02-16], [98],
    [2], [Dupond], [Fabrice], [2012-02-07], [65],
    [3], [Durand], [Fabienne], [2012-02-13], [90],
    [1], [Durand], [Maurice], [2012-02-05], [145],
  )

  On peut aussi ordonner le résultat d'un groupement. Par exemple pour afficher les noms de famille les plus courants en premier :

  ```sql
  SELECT nom, count(*)
  FROM utilisateurs
  GROUP BY nom
  ORDER BY count(*) DESC
  ```

  #h4[Résultat :]

  #table(
    columns: 2,
    [*nom*], [*count(\*)*],
    [Durand], [2],
    [Dubois], [2],
    [Dupond], [1],
  )

  #note[C'est la raison pour laquelle `ORDER BY` vient après des éventuels `GROUP BY` et `HAVING` dans une requête SQL.]

]

#section("jointures", "Jointures SQL")[

  Les jointures en SQL permettent de combiner plusieurs tables dans une même requête. Cela permet d'exploiter la puissance des bases de données relationnelles.

  Les jointures consistent à associer des lignes de 2 tables en associant l'égalité des valeurs d'une colonne d'une première table avec la valeur d'une colonne d'une seconde table.

  On peut imaginer qu'un site web possède une table pour les articles et une autre table pour les commentaires associés à chaque article. Une jointure permettrait d'afficher les articles avec leurs commentaires.

  == Modèle de données

  Imaginons une application qui contient une table utilisateur ainsi qu'une table commande qui contient les commandes effectuées par les utilisateurs.

  #h4[Table utilisateur :]

  #table(
    columns: 4,
    [*id\_utilisateur*], [*prenom*], [*nom*], [*email*],
    [1], [Aimée], [Marechal], [amarechal\@x.co],
    [2], [Esmée], [Lefort], [elefort\@x.co],
    [3], [Marine], [Prevost], [mprevost\@x.co],
    [4], [Luc], [Rolland], [lrolland\@x.co],
  )

  #h4[Table commande :]

  #table(
    columns: 4,
    [*id\_commande*], [*l\_utilisateur*], [*date\_achat*], [*montant*],
    [1], [1], [2013-01-23], [203.14],
    [2], [1], [2013-02-14], [124.00],
    [3], [2], [2013-02-17], [149.45],
    [4], [3], [2013-02-21], [235.35],
    [5], [6], [2013-03-02], [47.58],
  )

]

#section("join", "JOIN")[

  Dans le langage SQL la commande `JOIN` est un type de jointure très commune pour lier plusieurs tables entre elles. Cette commande retourne les enregistrements lorsqu'il y a au moins une correspondance dans les deux tables.

  == Syntaxe

  ```sql
  SELECT colonnes
  FROM table1
  JOIN table2 ON table1.id = table2.fk_id
  ```

  La syntaxe sélectionne les enregistrements des tables table1 et table2 lorsque la colonne `id` de table1 est égale à la colonne `fk_id` de table2.

  == Exemple

  On a les données décrites dans la section Jointures SQL. Pour afficher toutes les commandes associées aux utilisateurs :

  ```sql
  SELECT *
  FROM utilisateur
  JOIN commande ON id_utilisateur = l_utilisateur
  ```

  #h4[Résultat :]

  #pad(x: -0.5cm)[
    #set text(size: 0.85em)
    #table(
      columns: 8,
      table.vline(x: 4, stroke: 2pt),
      [*id\_utilisateur*],
      [*prenom*],
      [*nom*],
      [*email*],
      [*id\_commande*],
      [*l\_utilisateur*],
      [*date\_achat*],
      [*montant*],

      [1], [Aimée], [Marechal], [amarechal\@x.co], [1], [1], [2013-01-23], [203.14],
      [1], [Aimée], [Marechal], [amarechal\@x.co], [2], [1], [2013-02-14], [124.00],
      [2], [Esmée], [Lefort], [elefort\@x.co], [3], [2], [2013-02-17], [149.45],
      [3], [Marine], [Prevost], [mprevost\@x.co], [4], [3], [2013-02-21], [235.35],
    )
  ]

  À gauche toutes les colonnes de la table utilisateur, à droite toutes les colonnes de la table commande. Les tables ont été jointes sur les champs `id_utilisateur` et `l_utilisateur`.

  Noter que :
  - L'utilisateur 1 est affiché deux fois parce qu'il a fait 2 commandes.
  - L'utilisateur 4 n'est pas affiché puisqu'il n'y a pas de commande associée à cet utilisateur.

]

#section("left-join", "LEFT JOIN")[

  Dans le langage SQL, la commande `LEFT JOIN` est un type de jointure entre 2 tables.

  Cela permet de lister tous les résultats de la table de gauche (table1), même s'il n'y a pas de correspondance dans la table de droite (table2).

  == Syntaxe

  ```sql
  SELECT colonnes FROM table1
  LEFT JOIN table2 ON table1.id = table2.fk_id
  ```

  == Exemple

  On a les données décrites dans la section Jointures SQL. Pour lister tous les utilisateurs avec leurs commandes et afficher également les utilisateurs qui n'ont pas effectué de commande :

  ```sql
  SELECT id_utilisateur, prenom, nom, id_commande, date_achat, montant
  FROM utilisateur
  LEFT JOIN commande ON id_utilisateur = l_utilisateur
  ```

  #h4[Résultat :]

  #table(
    columns: 6,
    table.vline(x: 3, stroke: 2pt),
    [*id\_utilisateur*], [*prenom*], [*nom*], [*id\_commande*], [*date\_achat*], [*montant*],
    [1], [Aimée], [Marechal], [1], [2013-01-23], [203.14],
    [1], [Aimée], [Marechal], [2], [2013-02-14], [124.00],
    [2], [Esmée], [Lefort], [3], [2013-02-17], [149.45],
    [3], [Marine], [Prevost], [4], [2013-02-21], [235.35],
    [4], [Luc], [Rolland], [NULL], [NULL], [NULL],
  )

  La dernière ligne montre un utilisateur qui n'a effectué aucune commande. Les informations de la commande sont à `NULL`.

]

#section("right-join", "RIGHT JOIN")[

  En SQL, la commande `RIGHT JOIN` est un type de jointure entre 2 tables qui permet de retourner tous les enregistrements de la table de droite (table2), même s'il n'y a pas de correspondance avec la table de gauche (table1).

  == Syntaxe

  ```sql
  SELECT colonnes FROM table1
  RIGHT JOIN table2 ON table1.id = table2.fk_id
  ```

  == Exemple

  On a les données décrites dans la section Jointures SQL. Pour afficher toutes les commandes avec le nom de l'utilisateur correspondant :

  ```sql
  SELECT id_utilisateur, prenom, nom, id_commande, l_utilisateur, date_achat, montant
  FROM utilisateur
  RIGHT JOIN commande ON id_utilisateur = l_utilisateur
  ```

  #h4[Résultat :]

  #table(
    columns: 7,
    table.vline(x: 3, stroke: 2pt),
    [*id\_utilisateur*], [*prenom*], [*nom*], [*id\_commande*], [*l\_utilisateur*], [*date\_achat*], [*montant*],
    [1], [Aimée], [Marechal], [1], [1], [2013-01-23], [203.14],
    [1], [Aimée], [Marechal], [2], [1], [2013-02-14], [124.00],
    [2], [Esmée], [Lefort], [3], [2], [2013-02-17], [149.45],
    [3], [Marine], [Prevost], [4], [3], [2013-02-21], [235.35],
    [NULL], [NULL], [NULL], [5], [6], [2013-03-02], [47.58],
  )

  La commande 5 est liée à l'utilisateur 6, or cet utilisateur n'existe pas ou n'existe plus. Grâce à `RIGHT JOIN`, la commande est tout de même affichée mais les informations liées à l'utilisateur sont remplacées par `NULL`.

]

#section("full-join", "FULL JOIN")[

  Dans le langage SQL, la commande `FULL JOIN` permet de faire une jointure entre 2 tables. L'utilisation de cette commande permet de sélectionner tous les enregistrements des 2 tables, même s'il n'y a pas de correspondance entre elles.

  == Syntaxe

  ```sql
  SELECT colonnes
  FROM table1
  FULL JOIN table2 ON table1.id = table2.fk_id
  ```

  La condition consiste à lier les tables sur un identifiant, mais la condition peut être définie sur d'autres types de colonnes.

  == Exemple

  On a les données décrites dans la section Jointures SQL. Pour lister tous les utilisateurs ayant effectué ou non une commande, et de lister toutes les commandes, même celles qui ne sont pas associées à un utilisateur existant :

  ```sql
  SELECT id_utilisateur, prenom, nom, id_commande, l_utilisateur, date_achat, montant
  FROM utilisateur
  FULL JOIN commande ON id_utilisateur = l_utilisateur
  ```

  #h4[Résultat :]

  #table(
    columns: 7,
    table.vline(x: 3, stroke: 2pt),
    [*id\_utilisateur*], [*prenom*], [*nom*], [*id\_commande*], [*l\_utilisateur*], [*date\_achat*], [*montant*],
    [1], [Aimée], [Marechal], [1], [1], [2013-01-23], [203.14],
    [1], [Aimée], [Marechal], [2], [1], [2013-02-14], [124.00],
    [2], [Esmée], [Lefort], [3], [2], [2013-02-17], [149.45],
    [3], [Marine], [Prevost], [4], [3], [2013-02-21], [235.35],
    [4], [Luc], [Rolland], [NULL], [NULL], [NULL], [NULL],
    [NULL], [NULL], [NULL], [5], [6], [2013-03-02], [47.58],
  )

  Ce résultat affiche bien l'utilisateur 4 qui n'a effectué aucune commande. Le résultat affiche également la commande 5 qui est associée à un utilisateur qui n'existe pas.

]

#section("auto-jointure", "Auto jointure")[

  Ce type de requête n'est pas si commun mais très pratique dans le cas où une table lie des informations avec d'autres enregistrements de la même table.

  == Syntaxe

  Il n'y a pas de nouvelle syntaxe pour effectuer une auto jointure. On spécifie simplement la même table pour les parties table1 et table2, avec des alias différents :

  ```sql
  SELECT t1.colonne1, t1.colonne2, t2.colonne1, t2.colonne2
  FROM table AS t1
  LEFT JOIN table AS t2 ON t1.id = t2.fk_id
  ```

  Ici la jointure est effectuée avec un `LEFT JOIN`, mais il est aussi possible de l'effectuer avec d'autres types de jointures.

  == Exemple

  Utile quand le modèle de données représente une hiérarchie (un arbre). Cet exemple représente une entreprise dans laquelle des employés ont un supérieur hiérarchique.

  #h4[Table utilisateur :]

  #table(
    columns: 4,
    [*id*], [*prenom*], [*nom*], [*manager\_id*],
    [1], [Sebastien], [Martin], [NULL],
    [2], [Gustave], [Dubois], [NULL],
    [3], [Georgette], [Leroy], [1],
    [4], [Gregory], [Roux], [2],
  )

  Les premiers employés n'ont pas de supérieur (`manager_id` est `NULL`), tandis que les autres ont un supérieur identifié par son `id`. Il est possible de lister sur une même ligne les employés avec leurs supérieurs directs :

  ```sql
  SELECT u1.id AS u1_id, u1.prenom AS u1_prenom, u1.nom AS u1_nom,
         u1.manager_id AS u1_manager_id,
         u2.prenom AS u2_prenom, u2.nom AS u2_nom
  FROM utilisateur AS u1
  LEFT JOIN utilisateur AS u2 ON u1.manager_id = u2.id
  ```

  #h4[Résultat :]

  #table(
    columns: 6,
    table.vline(x: 4, stroke: 2pt),
    [*u1\_id*], [*u1\_prenom*], [*u1\_nom*], [*u1\_manager\_id*], [*u2\_prenom*], [*u2\_nom*],
    [1], [Sebastien], [Martin], [NULL], [NULL], [NULL],
    [2], [Gustave], [Dubois], [NULL], [NULL], [NULL],
    [3], [Georgette], [Leroy], [1], [Sebastien], [Martin],
    [4], [Gregory], [Roux], [2], [Gustave], [Dubois],
  )

]

#section("notation-table-colonne", "Notation table.colonne")[

  La notation `table.colonne` permet de préciser de quelle table provient une colonne dans une requête avec plusieurs tables.

  == Quand c'est optionnel

  Quand les noms de colonnes sont uniques d'une table à l'autre, la notation est optionnelle. Ces deux requêtes sont équivalentes :

  ```sql
  SELECT id_utilisateur, prenom, nom, id_commande, date_achat
  FROM utilisateur
  JOIN commande ON id_utilisateur = l_utilisateur
  ```

  ```sql
  SELECT utilisateur.id_utilisateur, utilisateur.prenom, utilisateur.nom,
         commande.id_commande, commande.date_achat
  FROM utilisateur
  JOIN commande ON utilisateur.id_utilisateur = commande.l_utilisateur
  ```

  == Quand c'est nécessaire

  Quand deux tables ont une colonne du même nom, SQL ne sait pas laquelle utiliser et retourne une erreur. Imaginons une table `artiste` et une table `album`, toutes deux avec une colonne `id` :

  #grid(
    columns: (auto, auto),
    column-gutter: 0pt,
    [
      #pad(right: 8em)[
        #h4[Table artiste :]

        #table(
          columns: 2,
          [*id*], [*nom*],
          [1], [Daft Punk],
          [2], [Björk],
        )
      ]
    ],
    [
      #pad(left: 8em)[
        #h4[Table album :]

        #table(
          columns: 3,
          [*id*], [*titre*], [*l\_artiste*],
          [1], [Discovery], [1],
          [2], [Homework], [1],
          [3], [Vespertine], [2],
        )
      ]
    ],
  )

  ```sql
  -- ERREUR : "id" est ambiguë (dans SELECT et dans ON)
  SELECT id, nom, titre
  FROM artiste
  JOIN album ON id = l_artiste
  ```

  Il faut préciser de quelle table provient `id` :

  ```sql
  SELECT artiste.id, nom, titre
  FROM artiste
  JOIN album ON artiste.id = l_artiste
  ```

  #h4[Résultat :]

  #table(
    columns: 3,
    [*id*], [*nom*], [*titre*],
    [1], [Daft Punk], [Discovery],
    [1], [Daft Punk], [Homework],
    [2], [Björk], [Vespertine],
  )

]

#section("jointure-trois-tables", "Joindre trois tables")[

  Pour joindre trois tables, on ajoute simplement un deuxième `JOIN` après le premier.

  Reprenons les tables `utilisateur` et `commande` de la section Jointures SQL, et ajoutons une table `programme_de_fidelite` qui associe un rabais à certains utilisateurs :

  #h4[Table programme\_de\_fidelite :]

  #table(
    columns: 3,
    [*id\_fidelite*], [*l\_utilisateur*], [*rabais\_pourcent*],
    [1], [1], [10],
    [2], [2], [5],
    [3], [3], [15],
  )

  Pour afficher les commandes avec le rabais de chaque utilisateur :

  ```sql
  SELECT id_utilisateur, prenom, nom,
         id_commande, montant,
         rabais_pourcent
  FROM utilisateur
  JOIN commande ON id_utilisateur = commande.l_utilisateur
  JOIN programme_de_fidelite ON id_utilisateur = programme_de_fidelite.l_utilisateur
  ```

  `l_utilisateur` existe dans les deux tables jointes, donc le préfixe de table est nécessaire dans les deux clauses `ON` (cf. section Notation table.colonne).

  #h4[Résultat :]

  #table(
    columns: 6,
    table.vline(x: 3, stroke: 2pt),
    table.vline(x: 5, stroke: 2pt),
    [*id\_utilisateur*], [*prenom*], [*nom*], [*id\_commande*], [*montant*], [*rabais\_pourcent*],
    [1], [Aimée], [Marechal], [1], [203.14], [10],
    [1], [Aimée], [Marechal], [2], [124.00], [10],
    [2], [Esmée], [Lefort], [3], [149.45], [5],
    [3], [Marine], [Prevost], [4], [235.35], [15],
  )

]

#section("sous-requete", "Sous-requête SQL")[

  Dans le langage SQL une sous-requête (aussi appelée « requête imbriquée » ou « requête en cascade ») consiste à exécuter une requête à l'intérieur d'une autre requête.

  == Syntaxe

  Il y a plusieurs façons d'utiliser les sous-requêtes.

  === Requête imbriquée qui retourne un seul résultat

  ```sql
  SELECT * FROM table
  WHERE colonne = (SELECT valeur FROM table2 LIMIT 1)
  ```

  Cet exemple montre une requête interne (celle sur `table2`) qui renvoie une seule valeur. La requête externe utilise cette valeur dans sa condition `WHERE`. Il est possible d'utiliser n'importe quel opérateur d'égalité tel que `=`, `>`, `<`, `>=`, `<=` ou `<>`.

  === Requête imbriquée qui retourne une colonne

  Une requête imbriquée peut également retourner une colonne entière. Dès lors, la requête externe peut utiliser la commande `IN` :

  ```sql
  SELECT *
  FROM table
  WHERE nom_colonne IN (
    SELECT colonne FROM table2
    WHERE cle_etrangere = 36
  )
  ```

  == Exemple

  Imaginons un site web qui permet de poser des questions et d'y répondre. Un tel site possède une base de données avec une table question et une table reponse.

  #h4[Table « question » :]

  #table(
    columns: 4,
    [*q\_id*], [*q\_date\_ajout*], [*q\_titre*], [*q\_contenu*],
    [1], [2013-03-24], [Comment réparer un ordinateur?], [Bonjour, j'ai mon ordinateur de cassé…],
    [2], [2013-03-26], [Comment changer un pneu?], [Quel est la meilleur méthode…],
    [3], [2013-04-18], [Que faire si un appareil est cassé?], [Est-il préférable de réparer…],
    [4], [2013-04-22], [Comment faire nettoyer un clavier?], [Bonjour, sous mon clavier…],
  )

  #h4[Table « reponse » :]

  #table(
    columns: 4,
    [*r\_id*], [*r\_fk\_question\_id*], [*r\_date\_ajout*], [*r\_contenu*],
    [1], [1], [2013-03-27], [Bonjour. Pouvez-vous expliquer ce qui ne fonctionne pas…],
    [2], [1], [2013-03-28], [Bonsoir, le plus simple consiste à faire appel à un professionnel…],
    [3], [2], [2013-05-09], [Des conseils sont disponibles sur internet sur ce sujet.],
    [4], [3], [2013-05-24], [Bonjour. Ça dépend de vous, de votre budget et de vos préférences…],
  )

  === Requête imbriquée qui retourne un seul résultat

  Pour connaître la question liée à la dernière réponse ajoutée :

  ```sql
  SELECT *
  FROM question
  WHERE q_id = (
    SELECT r_fk_question_id FROM reponse
    ORDER BY r_date_ajout DESC
    LIMIT 1
  )
  ```

  Une telle requête va retourner la ligne suivante :

  #table(
    columns: 4,
    [*q\_id*], [*q\_date\_ajout*], [*q\_titre*], [*q\_contenu*],
    [3], [2013-04-18], [Que faire si un appareil est cassé?], [Est-il préférable de réparer…],
  )

  === Requête imbriquée qui retourne une colonne

  Pour obtenir les questions liées à toutes les réponses comprises entre 2 dates :

  ```sql
  SELECT *
  FROM question
  WHERE q_id IN (
    SELECT r_fk_question_id FROM reponse
    WHERE r_date_ajout BETWEEN '2013-01-01' AND '2013-12-31'
  )
  ```

  #h4[Résultat :]

  #table(
    columns: 4,
    [*q\_id*], [*q\_date\_ajout*], [*q\_titre*], [*q\_contenu*],
    [1], [2013-03-24], [Comment réparer un ordinateur?], [Bonjour, j'ai mon ordinateur de cassé…],
    [2], [2013-03-26], [Comment changer un pneu?], [Quel est la meilleur méthode…],
    [3], [2013-04-18], [Que faire si un appareil est cassé?], [Est-il préférable de réparer…],
  )

  Une telle requête permet donc de récupérer les questions qui ont eu des réponses entre 2 dates.

]

#section("exists", "EXISTS")[

  Dans le langage SQL, la commande `EXISTS` s'utilise dans une clause conditionnelle pour savoir s'il y a une présence ou non de lignes lors de l'exécution d'une sous-requête.

  À noter : cette commande n'est pas à confondre avec la clause `IN`. La commande `EXISTS` vérifie si la sous-requête retourne au moins un résultat (elle ne compare pas des valeurs).

  == Syntaxe

  ```sql
  SELECT colonnes FROM table1
  WHERE EXISTS (
    SELECT colonnes FROM table2
    WHERE condition
  )
  ```

  == Exemple

  Imaginons un système composé d'une table commande et d'une table produit.

  #h4[Table commande :]

  #table(
    columns: 4,
    [*c\_id*], [*c\_date\_achat*], [*c\_produit\_id*], [*c\_quantite\_produit*],
    [1], [2014-01-08], [2], [1],
    [2], [2014-01-24], [3], [2],
    [3], [2014-02-14], [8], [1],
    [4], [2014-03-23], [10], [1],
  )

  #h4[Table produit :]

  #table(
    columns: 4,
    [*p\_id*], [*p\_nom*], [*p\_date\_ajout*], [*p\_prix*],
    [2], [Ordinateur], [2013-11-17], [799.9],
    [3], [Clavier], [2013-11-27], [49.9],
    [4], [Souris], [2013-12-04], [15],
    [5], [Ecran], [2013-12-15], [250],
  )

  Pour afficher les commandes pour lesquelles il y a effectivement un produit correspondant dans la table produit :

  ```sql
  SELECT *
  FROM commande
  WHERE EXISTS (
    SELECT * FROM produit WHERE c_produit_id = p_id
  )
  ```

  #h4[Résultat :]

  #table(
    columns: 4,
    [*c\_id*], [*c\_date\_achat*], [*c\_produit\_id*], [*c\_quantite\_produit*],
    [1], [2014-01-08], [2], [1],
    [2], [2014-01-24], [3], [2],
  )

  Le résultat démontre bien que seules les commandes n°1 et n°2 ont un produit qui se trouve dans la table produit.

]

#section("all", "ALL")[

  Dans le langage SQL, la commande `ALL` permet de comparer une valeur dans l'ensemble de valeurs d'une sous-requête. En d'autres termes, `ALL` permet de vérifier si une condition est vraie pour *tous* les résultats retournés par une sous-requête.

  == Syntaxe

  ```sql
  SELECT *
  FROM table1
  WHERE condition > ALL (
    SELECT * FROM table2 WHERE condition2
  )
  ```

  Les opérateurs conditionnels peuvent être les suivants : `=`, `<`, `>`, `<>`, `!=`, `<=`, `>=`.

  == Exemple

  ```sql
  SELECT colonne1 FROM table1
  WHERE colonne1 > ALL (
    SELECT colonne1 FROM table2
  )
  ```

  Avec cette requête, si nous supposons que dans table1 il y a un résultat avec la valeur 10 :

  - La condition est vraie (TRUE) si table2 contient \{-5, 0, +5\} car toutes les valeurs sont inférieures à 10.
  - La condition est fausse (FALSE) si table2 contient \{12, 6, NULL, -100\} car au moins une valeur est supérieure à 10.
  - La condition est non connue (UNKNOWN) si table2 est vide.

]

#section("any", "ANY / SOME")[

  Dans le langage SQL, la commande `ANY` (ou `SOME`) permet de comparer une valeur avec le résultat d'une sous-requête. Il est vrai si la condition est vérifiée pour *au moins une* des valeurs retournées.

  À noter : le mot-clé `SOME` est un alias de `ANY`, l'un et l'autre des termes peut être utilisé.

  == Syntaxe

  ```sql
  SELECT *
  FROM table1
  WHERE condition > ANY (
    SELECT * FROM table2 WHERE condition2
  )
  ```

  Cette requête peut se traduire de la façon suivante : sélectionner toutes les colonnes de table1, où la condition est satisfaite pour au moins une valeur de la sous-requête.

  Les opérateurs conditionnels peuvent être les suivants : `=`, `<`, `>`, `<>`, `!=`, `<=`, `>=`.

  == Exemple

  ```sql
  SELECT colonne1 FROM table1
  WHERE colonne1 > ANY (
    SELECT colonne1 FROM table2
  )
  ```

  Supposons que table1 possède un seul résultat dans lequel colonne1 est égal à 10 :

  - La condition est vraie (TRUE) si table2 contient \{21, 14, 7\} car il y a au moins une valeur inférieure à 10.
  - La condition est fausse (FALSE) si table2 contient \{20, 10\} car aucune valeur n'est strictement inférieure à 10.
  - La condition est non connue (UNKNOWN) si table2 est vide.

]

#section("commentaires", "Commentaires en SQL")[

  Il peut être intéressant d'insérer des commentaires dans les requêtes SQL pour mieux s'y retrouver lorsqu'il y a de grosses requêtes.

  == Commentaire double tiret : --

  Le double tiret permet de faire un commentaire jusqu'à la fin de la ligne.

  ```sql
  SELECT *         -- tout sélectionner
  FROM commandes   -- dans la table "commandes"

  -- On peut aussi évidemment les écrire seuls sur une ligne
  ```

  == Commentaire multi-ligne : /\* et \*/

  Le commentaire multi-ligne permet d'écrire des commentaires plus longs.

  ```sql
  /* Vous trouverez ci-dessous
     une véritable requête de professionnel
  */
  SELECT *
  FROM commandes
  ```

]
