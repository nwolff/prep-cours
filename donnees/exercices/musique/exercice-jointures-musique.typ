#import "/template-exercices.typ": *

#show: series

#title[Exercice SQL — Requêtes avec jointures]

== Base de données

La base de données _musique.sqlite_ contient des informations sur des artistes, leurs albums et des notes données par des utilisateurs.


#image("schema.svg", width: 100%)

#ex("Langues")[
  Afficher les langues des pays présents dans la base, sans doublons, par ordre alphabétique.

  #an[```sql
  select distinct langue
  from pays
  order by langue;
  ```]
]

#ex("Albums")[
  Afficher tous les albums avec deux colonnes supplémentaires : le nom du style musical et le prénom de l'artiste.

  #an[```sql
  select titre_album, nom_style, prenom_artiste
  from albums
  join styles on le_style = id_style
  join artistes on l_artiste = id_artiste;
  ```]
]

#ex("Styles musicaux")[
  Afficher le nom de chaque style musical avec le nombre d'albums dans ce style. Les styles avec le plus d'albums doivent apparaître en premier.

  #an[```sql
  select nom_style, count(*)
  from styles
  join albums on id_style = le_style
  group by id_style
  order by count(*) desc;
  ```]
]

#ex("Notes par album")[
  Afficher pour chaque album : le titre, le minimum, le maximum et la moyenne des notes obtenues.

  #an[```sql
  select titre_album, min(note), max(note), avg(note)
  from albums
  join notes on id_album = un_album
  group by id_album;
  ```]
]

#ex("Utilisateurs actifs")[
  Afficher le pseudo des utilisateurs ayant noté au moins 50 albums, ainsi que leur nombre de notes.

  _Indice : il faut trouver 139 rangées._

  #an[```sql
  select pseudo, count(*)
  from utilisateurs
  join notes on id_utilisateur = un_utilisateur
  group by id_utilisateur
  having count(*) >= 50;
  ```]
]
