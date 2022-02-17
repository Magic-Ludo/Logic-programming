<center> <h1>Projet Prolog</h1> </center>
<center> <h3>Licence 2 Informatique - UCA</h3> </center>
<center> ______________________________________ </center>

<br></br>


### Constitution de l'équipe 

- AUROY Alice
- CORCOS Ludovic
- HOUNSA Camille



# Introduction

Il semble que la présentation `Markdown` fonctionne bien sur [Github](http://jbt.github.io/markdown-editor/ "Cliquez-ici !"). Donc importez le fichier pour une plus belle mise en page !

Au fur et à mesure des séances de TP de logique, nous avons appris à coder en `Prolog`, et parfois, nous avons rencontré des difficultés lors de certains exercices, mais nous avons essayé de tous les chercher même si on ne les a pas tous réussi.
Nous allons vous présenter dans ce fichier en `Markdown` les différentes clauses que nous avons mis en place, ainsi que pour certaines, comment les faires fonctionner.

# 1 - Énigmes et modélisation
### Exercice 1 : la fin de la solitude

Nous espérons avoir trouvé des noms suffisament rigolos pour avoir des points bonus !

On part du principe qu'une personne est représenté par son numéro :

```prolog
personne(1, pistache, 175, violet, 21).
personne(2, matelotte, 170, rose, 25).
personne(3, missouri, 180, noir, 33).
personne(4, lambada, 167, blanc, 26).
personne(5, machate, 165, rose, 24).
```
Le prédicat `personne` est défini de la manière suivante :
`personne(I, N, T, C, A)` décrit un(e) inscrit(e). `I` est un identifiant (un nombre entier), `N` est son nom, `T` sa taille, `C` la couleur de ses cheveux et `A` son âge.

De même pour le prédicat `goût` :
`gout(I, M, L, S)` : la personne dont l’identifiant est `I` aime le genre de musique `M`, le genre de littérature `L`, et pratique le sport `S`.

De même encore pour le prédicat `recherche` :
`recherche(I, T, C, A)` : la personne `I` recherche un partenaire de taille `T`, ayant des cheveux de couleur `C` et dont l’âge est `A`.

Nous avons effectués des effectués des tests en fonction des prédicats `Prolog` que nous avons définie :

```prolog
personne(1, X, 175, violet, 21).
X = pistache.

gout(4, jazz, roman, foot).
false.

convientphysiquement(4, 5).
true.

convientphysiquement(1, 2).
true.

ontmemesgouts(1, 2).
false.

ontmemesgouts(2, 3).
true.

ontmemesgouts(4, 5).
true.

convient(2, 3).
false.

convient(4, 5).
true.

convient(5, 4).
true.

couple(4, 5).
true.

couple(1, 3).
false.
```

**Dans notre exemple, les personnes 4 et 5 peuvent former un couple.**

### Exercice 2 : attention à ne pas dépasser !

On commence par définir trois faits, qui sont les trois couleurs données :

```prolog
couleur(vert).
couleur(jaune).
couleur(rouge).
```

Dans un premier temps, on colorie chaque zone conditions, puis, on effectue le coloriage de manière conforme : deux zones qui se touchent ne peuvent pas avoir la même couleur.
Le prédicat `coloriageconforme(C1, C2, C3, C4)` reprend le predicat `coloriage(C1, C2, C3, C4)` ce qui a pour conséquence de ne pas prendre les couleurs définies précédement lors des tests :

```prolog
coloriage(rouge, rouge, rouge, rouge).
true.

coloriage(rouge, jaune, vert, rouge).
true.

coloriage(rouge, rouge, rouge, bleu).
false.
% Ne prend en compte que les couleurs definies precedemment à savoir rouge, jaune et vert.

coloriageconforme(rouge, rouge, vert, jaune).
false.

coloriageconforme(rouge, rouge, rouge, rouge).
false.

coloriageconforme(vert, jaune, vert, rouge).
false.

coloriageconforme(rouge, vert, jaune, vert).
true.
% Dans notre cas les zones 2 et 4 ne sont pas contigues elles peuvent donc avoir la même couleur c'est le seul cas possible.

coloriageconforme(rouge, vert, X, rouge).
false.

coloriageconforme(rouge, vert, X, vert).
X = jaune.

coloriageconforme(rouge, vert, jaune, X).
X = vert.
```

### Exercice 3 : globe-trotter

Dans cet exercice, on commence par définir 3 faits (3 villes possibles).
Puis, d'autres faits, le prix du transport en fonction de la ville, et enfin, le prix pour une semaine.

On pose le prédicat `voyage(V, D, H, S)` qui calcule le prix du voyage en fonction de la durée, de la ville et de l'hebergement (`V` = ville, `D` = durée, `H` = hébergement, `P` = prix).

On continue l'exercice en rajoutant une condition au prédicat précedent : `voyageEco(V, D, H, S, Smax)` le voyage est éconoique si le prix total est inferieur à un budget prédéfini.

Nous avons effectué les tests suivants :
```prolog
trannsport(rome, X).
X = 130.

catalogue(tunis, X, 500).
X = camping.

voyage(londres, 1, camping, X).
X = 650.

voyage(londres, 2, camping, X).
X = 1250.

voyageEco( tunis, 1, chambre, X, 1000).
X = 850.

voyageEco( tunis, 1, hotel, X, 1000).
false.
```

# 2 - Listes, ensembles
### Exercice 1 : listes

Dans cet exercice, nous allons étudier les listes au fur et à mesure de problèmes de difficultés croissantes.
Nous n'allons pas tout détailler dans ce document, mais des définitions sont en commentaires dans le code.

Nous allons voir quelques prédicats précis :
- **Le predicat `supprimer`:**

On cherche à supprimer un élément X d'une liste on va utiliser une règle récursive.
**Initialisation :** si l'on enlève pas d'élément, alors la liste reste la même.

On affichera le résultat dans L2. Si l'élément que l'on veut enlever est la tête de la liste alors cela revient afficher la queue de la liste.
```prolog
supprimer(X,[X|L1],L2) :- supprimer(X, L1, L2).
```
Si l'élément X ne correspond pas à la tête de la liste on fait appel à remove au rang d'avant c'est à dire a la queue de la liste ainsi, on réduit de plus en plus la liste jusqu'à tomber sur le fait que l'élément soit la tête de la liste qui reste.
```prolog
supprimer(X,[T|L1],[T|L2]) :- supprimer(X, L1, L2), X \= T.
```
Nous avons effectué les tests suivants :
```prolog
supprimer(a, [a, b, c], L).
L = [b, c].

supprimer(x, [a, b, c], L).
L = [a, b, c].

supprimer(3, [1, 2, 3], [1, 3]).
false.

supprimer(3, [1, 2, 3], [2, 2]).
true.
```
- **Le predicat `fusion`:**

Fonction récursive qui affiche la fusion de 2 listes dans L. On a un élément sur deux qui appartiennent à chacune des listes.
**Initialisation :** la fusion de deux listes vides donnent une liste vide.

Si les listes ne sont pas vides : on fait un appel à fusion avec les queues des listes en affichant en premier dans L la tête de L1 puis la tête de L2.
Ensuite, on réduit à chaque passage la taille de L1 et de L2 jusqu'à arriver au cas d'arrêt des listes vides.

Nous avons effectué les tests suivants :
```prolog
fusion(X, [1, 2, 3], [a, b, c]).
X = [1, 2, 3, a, b, c]).

fusion(X, [1, 2, 3], [a, b]).
false.
%La fonction marchent seulement si la taille des listes est identique.
```

- **Le predicat `even`:**

Ce prédicat permet d'afficher les élements pairs d'une liste.
On considère que le premier élément de la liste est à l'indice 0 ainsi on affiche le premier élément (la tête de la liste). On fait une fonction récursive qui affichera la liste résultat dans L2.
Si la liste est vide : renvoie une liste vide
Si la liste ne contient qu'un élément : renvoie cet élément
Sinon on affiche la tête puis, un sur deux.

Nous avons effectué les tests suivants :
```prolog
even([pair, impair, pair, impair, pair, impair, pair], A]).
A = [pair, pair, pair, pair].

even([pair, impair, pair], A).
A = [pair, pair]. 

even([1], A).
A = 1.
```

- **Le predicat `fibo`:**

Ce prédicat permet de générer la liste des `n` premiers termes de la suite de Fibonacci.
Dans une première version récursive, nous anvons tenté les prédicats suivants :
```prolog
fib(0, 1) :- !.
fib(1, 1) :- !.
fib(N, Result) :- N1 is N - 1, N2 is N - 2, fib(N1, Result1), fib(N2, Result2), Result is Result1 + Result2.
```
Le soucis est que lors des tests, nous n'obtenions pas une liste :
```prolog
fib(8,L).
L = 34.
% Par exemple.
```

Nous avons donc décidé de construire un autre type de prédicat : une recursivité avec mémorisation.
Un prédicat supplémentaire `memo(But)` est mis en place pour que la première fois que `But` est évaluée, le résultat de son évaluation soit ajouté à la base des faits, et, la fois suivant où il est interrogé, il n'est pas réévalué mais pris comme fait connu.

Après que le prédicat `fibo(N,F)` soit défini de manière récursive, chaque valeur de `N` de `fibo(N,F)` est évalué une seule fois. Avec une telle approche, l'affichage des nombres calculés peut être effectuée immédiatement après leur calcul, sans boucle supplémentaire.

Un resultat du prédicat est :
```prolog
fibo(8,L).
1, 1, 2, 3, 5, 8, 13, 21, 
L = 21.
```

### Exercice 2 : tous ensemble pour les ensembles

Pour cet exercice, on commence par réutiliser les clauses déjà définies dans l'exercice 1 :
```prolog
conc([],L,L). % Concaténation de deux listes
conc([T|Q],L,[T|QL]) :- conc(Q,L,QL).

inverser([],[]).
inverser([T|Q],L) :- inverser(Q,L1), conc(L1,[T], L).

supprimer(_,[],[]).
supprimer(X,[X|L1],L2) :- supprimer(X,L1,L2).
supprimer(X,[T|L1],[T|L2]) :- supprimer(X,L1,L2), X \= T.
```

On peux assimiler les ensembles à des listes donc ils auront le même fonctionnement qu'elle par concequent.

Exemple de test sur certains prédicats :

- **Le predicat `intersection`:**

```prolog
intersection(L, [a, b, c], [b, c]).
L = [b, c] .
```
Ici, le resultatattendu est correct, en effet, l'intersection de deux ensembles va produire en sortie les éléments qui sont présent uniquement dans les deux ensembles.

- **Le predicat `union`:**

```prolog
union([a,b,c],[c,d,e],L).
L = [a, b, c, d, e] .
```
De même pour l'union qui retourne la concaténation des deux ensembles.

- **Le predicat `diff_symetrique`:**

Un prédicat plutot sympathique : la différence symétrique. En effet, la différence symétrique de deux ensemble (ici A et B) est définie selon la formule suivante :

```math
A \Delta B = (A \cup B) - (A \cap B)
```
On constate par conséquent que l'on peut se reservir de ce que nous avons déjà créé précedement : l'union et l'intersection.
Un test que nous avons fait sur un ensemble `[a, b, c, d, e, f]` contenant deux autres ensembles : `[a, b, c]` et `[c, d, a]` nous donne ceci :

```prolog
diff_symetrique([a,b,c],[c,d,a],[a,b,c,d,e,f],L).
L = [b, d].
```
Le prédicat dans notre programme est sous la forme : `diff_symetrique(S1,S2,Q,X)` qui renvoie la différence symétrique entre deux ensembles `S1` et `S2` qui appartiennent à un autre ensemble `Q`. `X` étant la liste correspondant à la différence symétrique qui est renvoyé.


### Exercice 3 : ensembles d’ensembles d’ensembles d’ensembles d’ensembles

Présentation des prédicats de l'exercice :

- **Le predicat `sous_ensemble`:**

Fonction récursive, qui, à partir d'une liste la découpe en sous ensemble, et affiche par la suite toute les possibilitées.
**Initialisation** : le sous ensemble d'une liste vide est une liste vide.

Voyons par l'exemple :
```prolog
sous_ensemble([a, b, c], L).
L = [a, b, c]
L = [a, b]
L = [a, c]
L = [a]
L = [b, c]
L = [b]
L = [c]
L = [].
```

- **Le predicat `fintersection`:**

On s'attaque ici à la fermeture par intersection.

On créé une fonction qui calcule l'intersection entre deux ensemble.
Dans un premier temps on fait une règle `member` qui définit tous les éléments d'une liste.
Cette fonction est récursive : on cherche d'abord si cette élément est la tête de liste, si non on cherche à, savoir si c'est la tête de la queue de la liste.

```prolog
member(a, [a, b, c]).
true.

member(x, [a, b, c]).
false 
```

La règle `fintersection` regarde si un élément est membre des deux listes , si oui, on affiche le résultat dans une autre liste, notée L ici.

```prolog
fintersection([1, 3, 6, 8], [2, 4, 6, 8], L).
L = [6, 8].

fintersection([1, 3, 5, 7], [2, 4, 6, 8], L).
L = [].
```

- **Le predicat `funion`:**

Même principe que pour l'intersection. Les éléments font parti de l'union s'ils font parti, soit d'une liste, soit de l'autre, soit des deux.

```prolog
funion([1, 2, 3], [4, 5, 6], L).
L = [1, 2, 3, 4, 5, 6]).

funion ([1], [2], L).
L = [1, 2].

funion([1, 2], [1, 2], L).
L = [1, 2].
```

# 3 - 2-SAT Solver (plus jamais ça) 

Gros exercice ici, sur lequel on s'est cassé la tête pas mal de temps, mais il semble fonctionner néamoins.

L'obejectif est simple, il fallait trouver un prédicat `sat` qui permet de savoir si une 2 - CNF est satisfiable ou non.

Pour celà, nous allon utiliser quelques bibliothèques de prolog : 
- dialect.pl qui permet d'invoquer SICStus
- SICStus.pl qui va permetre de suspendre des prédicats sur certains modes (grâce à block)
- block.pl qui permet de bloquer des prédicats

Le solveur est appelé avec deux arguments. Le premier représente une formule en 2-CNF comme une liste de listes. Chaque liste représentant une clause. Les termes d'une clause sont représentés par des paires, `B-V`, où `V` est une variable logique et `B` (comme bouléen) est vrai ou faux, indiquant que le terme a une véracité positive ou négative.
Le deuxième argument est une liste des variables intervenant dans le problème.

Le solveur est basé sur le lancement d'un objectif de surveillance pour chaque clause qui surveille deux termes de cette clause.

Puisque la véracité des termes est connue, celà revient à bloquer l'exécution jusqu'à ce que l'une des deux variables non instanciées apparaissant dans la clause soit liée. Le prédicat `surveille` bloque ainsi ses premier et troisième arguments jusqu'à ce que l'un d'eux soit instancié à une valeur de vérité. 

Si le premier argument est lié, le prédicat `re_surveille` diagnostiquera l'action, si besoin, à effectuer en fonction de la véracité de la variable.
Si la valeur de vérité est positive et que la variable est liée à true, la clause a été satisfaite et aucune autre action n'est requise. De même, la clause est satisfaite si la variable est fausse et la valeur de vérité est négative.

La première clause de `def_surveille` gère le cas où il n'y a plus de variables à surveiller.

Si la véracité de la variable est positive, alors la variable est affectée `true`. Inversement, si la véracité est négative, alors la variable est affectée `false`. Une seule unification suffit pour traiter les deux cas. Si `V` et `B` ne sont pas unifiables, les liaisons à `Vars` ne satisferont pas la clause, et donc ne satisfont pas la formule entière.

Le prédicat `elim_var(Vars)` est invoqué pour lier chaque variable de Vars à une valeur de vérité. Le contrôle passe à un objectif de surveillance dès que son premier ou troisième argument est lié.
En effet, les sous-objectifs `(V = true; V = false)` de `elim_vars(Vars)` correspondent aux sous-objectifs de `surveille`, de la configuration du problème.

**Passons maintenant aux exemples :**
```prolog
sat([[true-A,true-B],[false-B,true-A],[false-A,false-A]],[A,B]).
false.

sat([[true-P,false-Q],[true-Q,true-R],[false-R,false-R]],[P,Q,R]).
P = Q, Q = true,
R = false .
```

On constate que la première n'est pas satisfaite (c'est d'ailleur celle donnée en énnoncé, ça tombe bien) car il faudrait à la fois valider `a et non(a).`
