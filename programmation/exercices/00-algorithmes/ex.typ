#import "/template-exercices.typ": *

#show: series

#title[Algorithmique -- Introduction]


#ex("Zéro(s) d'une fonction quadratique")[
  On a l'équation: $a x^2 + b x + c = 0$

  Appliquez la méthode que vous avez apprise à l'école (méthode du discriminant ou formule de Viète) pour
  résoudre les équations du second degré.

  Décrivez les *différents cas* qui peuvent se présenter quand on résout cette équation (ne rentrez pas
  dans les détails des calculs, on veut surtout savoir combien de solutions il y a).

  #a3[
    - Si $Delta > 0$ : deux solutions distinctes
    - Si $Delta = 0$ : une seule solution (racine double)
    - Si $Delta < 0$ : aucune solution réelle
  ]
]


#ex("Plus grand nombre dans une liste")[
  On cherche le plus grand nombre de cette liste:

  6609;9449;3597;1345;1349;5898;80298;3427;4014;2967;4167;2244;8035;7232;4382;5799;2977;
  5882;2534;2052;78;7679;1258;8717;(12FFF)₁₆;3227;5960;315;1334;7320;2659;5503;7275;
  4699;9926;41621;120;8939;3876;4322;3671;611;5947;6181;30;7634;5884;2208;7626;5954;51949;
  2543;5388;457;221;6649;3129;8879;8022;3065;1072;8738;9586;9171;(26D4)₁₆;4423;3921;
  1774;2140;9150;5636;1207;3082;7159;7897;9707;1758;524;7789;81121;1281;1373;1131;3883;8550;(13CDE)₁₆;5890;3569;3301;9334;934;9488;9014;9939;6133

  (Pour convertir les nombres hexadécimaux vous pouvez utiliser https://ri.nwolff.info/ )

  *a)* Trouver le plus grand nombre de cette liste.

  Vous allez partager le travail avec votre voisin·e de table:
  Au milieu de la tâche, vous annotez la feuille avec les informations nécessaires pour continuer le travail, puis vous échangez votre feuille avec votre
  voisin·e. Chacun·e termine le travail de l'autre.


  *b)* Décrire comment il faut faire (comme si vous vous adressiez à une autre personne)

  #a2[
    On compare les deux premiers deux à deux, on se souvient du plus grand.
    On continue en comparant « le plus grand trouvé jusqu'à maintenant » avec le nombre suivant.
    À la fin on a le plus grand nombre de la liste.
  ]

  *c)* Combien d'étapes avez-vous dû faire pour trouver la réponse ?
  #a1[88 -- autant que d'éléments dans la liste]

  *d)* Quel rapport entre le nombre d'étapes et la taille de la liste ?
  #a1[Proportionnel : autant de comparaisons que d'éléments dans la liste]

  *e)* Quelle(s) chose(s) avez-vous dû marquer/annoter sur la feuille avant de passer le reste du travail à votre voisin·e ?

  #a1[
    - Le plus grand nombre trouvé jusqu'à maintenant
    - L'endroit où on en est (le prochain nombre à traiter)
  ]
]


#ex("Somme de nombres")[
  Calculer $6609 + 9449 + 3597 + 1345 + 1349 + 5898$ à l'aide de la calculatrice (la vraie, pas celle de l'ordi). Vous allez procéder par étapes, car la calculatrice ne fait  qu'*une opération à la fois*.

  *a)* Noter ce que vous tapez dans la calculatrice, et ce qu'elle affiche à chaque étape.

  _La première ligne est déja remplie pour montrer comment on commence._

  #table(
    columns: (1fr, 1fr, 1fr),
    align: (right, right, right),
    [*Nombre*], [*Opérateur*], [*Affichage calculatrice*],
    [6609], [+], [6609],
    [#strut #an[9449]], [#an[+]], [#an[16058]],
    [#strut #an[3597]], [#an[+]], [#an[19655]],
    [#strut #an[1345]], [#an[+]], [#an[21000]],
    [#strut #an[1349]], [#an[+]], [#an[22349]],
    [#strut #an[5898]], [#an[=]], [#an[28247]],
  )

  *b)* Décrire ce que la calculatrice affiche sur la ligne 3. Pas le nombre, une explication
  de ce que ce nombre représente.

  #a2[
    La somme partielle des trois premiers nombres : $6609 + 9449 + 3597$.
  ]

  *c)* Réécrire l'expression de la donnée en ajoutant des parenthèses pour décrire dans quel ordre on a fait le calcul.

  #a2[
    $((((6609 + 9449) + 3597) + 1345) + 1349) + 5898$
  ]
]


#ex("Labyrinthe")[
  Trouver un chemin depuis l'entrée (en haut) vers la sortie (en bas).
  Vous vous mettez à la place d'une personne qui est dans le labyrinthe, et ne voit que son entourage direct.

  #grid(
    columns: (auto, auto),
    column-gutter: 1em,
    align: top,
    image("labyritnhe-dessus.png", width: 7cm), image("labyrinthe-dedans.png", width: 5cm),
  )

  *a)* Comment avez-vous procédé ? Décrivez comment il faut faire (comme si vous vous adressiez à une
  autre personne).

  #a2[
    Par exemple, suivre le mur de gauche (ou de droite) sans jamais décoller la main.
    Ou bien : explorer les chemins au hasard, marquer les impasses pour ne pas y retourner (backtracking).
  ]

  *b)* Combien de choses doivent être mémorisées avec votre technique ? Il faut compter les choses que
  vous gardez en tête, et aussi les choses que vous marquez sur la feuille.

  #a2[
    - Suivre un mur : aucune mémorisation nécessaire.
    - Backtracking : autant de cases qu'on a déjà marquées sur la feuille.
  ]
]


#ex("Paires de chaussettes")[
  On a un énorme sac qui contient des chaussettes noires, blanches, et grises.
  On ne voit pas l'intérieur du sac, le sac distribue une chaussette à la fois.
  Vous devez fabriquer des paires de chaussettes de même couleur.
  Une fois que vous avez une paire, vous la jetez dans un grand bac.

  *a)* Décrivez en détails chaque étape de l'algorithme pour fabriquer les paires.

  #a3[
    On tire une chaussette du sac.
    Si on a déjà une chaussette de cette couleur devant soi, on fait une paire et on la jette dans le bac.
    Sinon on pose la chaussette devant soi. On recommence jusqu'à ce que le sac soit vide.
  ]

  *b)* Combien de chaussettes au maximum allez-vous avoir devant vous pendant que vous fabriquez les paires ?

  #a1[
    Au maximum 3 chaussettes (une de chaque couleur). La prochaine tirée sera forcément d'une couleur déjà
    présente et formera une paire.
  ]

  *c)* Quand s'arrête l'algorithme ?

  #a1[
    Quand le sac est vide.
  ]
]


#ex("Différences entre heures")[
  On veut calculer la différence entre deux moments de la journée. Le résultat doit être en heures et minutes.

  _Exemple : Quelle est la durée entre 13h42 et 18h20._

  Décrivez en détails votre technique pour calculer la différence.

  #a4[
    On convertit les deux heures en minutes totales, on soustrait, puis on reconvertit en heures et minutes.

    Ex : 13h42 = 822 min, 18h20 = 1100 min. Différence : 1100 − 822 = 278 min = 4h38.
  ]
]


#ex("Équipes de sport de force équivalente")[
  *a)* Décrivez en détails la méthode qu'utilisent les profs de sports pour créer deux équipes de foot de
  force équivalente, sans faire eux-mêmes le choix des membres des équipes (ils font seulement un petit
  choix au début).

  #a4[
    Le prof désigne deux chefs d'équipe. À tour de rôle, chaque chef choisit une personne parmi celles
    qui restent, jusqu'à ce qu'il ne reste plus personne.
  ]

  *b)* Quand s'arrête l'algorithme ?

  #a1[
    Quand il ne reste plus personne à choisir.
  ]

  *c)* Pourquoi est-ce que ça permet de faire des équipes de force équivalente ?

  #a2[
    Les chefs choisissent alternativement le meilleur restant, ce qui donne les joueurs classés
    1, 3, 5, 7... dans une équipe et 2, 4, 6, 8... dans l'autre -- de force à peu près équivalente.
  ]
]


#ex("Jeu du morpion")[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 2em,
    align: top,
    image("morpion.png", width: 4cm),
    [
      Pouvez-vous décrire une technique qui permette de *gagner à tous les coups* si vous commencez ?

      #a2[
        Non, ce n'est pas possible. Avec un jeu parfait des deux côtés, le morpion se termine toujours en match nul.
      ]

      Pouvez-vous décrire une technique qui permette de *ne pas perdre* si vous jouez en deuxième ?

      #a2[
        Oui : jouer au centre si disponible, puis aux coins, et bloquer systématiquement les alignements adverses.
      ]
    ],
  )
]
