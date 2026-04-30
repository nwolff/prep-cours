#import "/template-exercices.typ": *

#show: series

#title[Exercice SQL — Requêtes avec jointures]

== Base de données

La base de données _musique.sqlite_ contient des informations sur des artistes, leurs albums et des notes données par des utilisateurs.


#image("schema.svg", width: 100%)

#ex("Langues")[
  Afficher les langues des pays présents dans la base, sans doublons, par ordre alphabétique.

  #an[```sql
  SELECT DISTINCT langue
  FROM pays
  ORDER BY langue
  ```]
]

#ex("Albums")[
  Afficher tous les albums avec deux colonnes supplémentaires : le nom du style musical et le prénom de l'artiste.

  #an[```sql
  SELECT titre_album, nom_style, prenom_artiste
  FROM albums
  JOIN styles ON le_style = id_style
  JOIN artistes ON l_artiste = id_artiste
  ```]
]

#ex("Styles musicaux")[
  Afficher le nom de chaque style musical avec le nombre d'albums dans ce style. Les styles avec le plus d'albums doivent apparaître en premier.

  #an[```sql
  SELECT nom_style, COUNT(*)
  FROM styles
  JOIN albums ON id_style = le_style
  GROUP BY id_style
  ORDER BY COUNT(*) DESC
  ```]
]

#ex("Notes par album")[
  Afficher pour chaque album : le titre, le minimum, le maximum et la moyenne des notes obtenues.

  #an[```sql
  SELECT titre_album, MIN(note), MAX(note), AVG(note)
  FROM albums
  JOIN notes ON id_album = un_album
  GROUP BY id_album
  ```]
]

#ex("Utilisateurs actifs")[
  Afficher le pseudo des utilisateurs ayant noté au moins 50 albums, ainsi que leur nombre de notes.

  _Indice : il faut trouver 139 rangées._

  #an[```sql
  SELECT pseudo, COUNT(*)
  FROM utilisateurs
  JOIN notes ON id_utilisateur = un_utilisateur
  GROUP BY id_utilisateur
  HAVING COUNT(*) >= 50
  ```]
]
