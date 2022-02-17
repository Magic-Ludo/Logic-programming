/*---- Exercice 3 ----*/

/*	Sous - ensemble */
sous_ensemble([], []).

/* 	Ensuite on affiche toutes les combinaison possibles */
sous_ensemble([T|Q], [T|S]) :- sous_ensemble(Q, S).
sous_ensemble([T|Q], S) :- sous_ensemble(Q, S).

/* 	Fermeture par intersection */ 
member(X,[X|R]).
member(X,[Y|R]) :- member(X,R).
fintersection([X|Y],M,[X|Z]) :- member(X,M), fintersection(Y,M,Z).
fintersection([X|Y],M,Z) :- \+ member(X,M), fintersection(Y,M,Z).
fintersection([],M,[]).


/* 	Fermeture par union */
funion([X|Y],Z,W) :- member(X,Z),  funion(Y,Z,W).
funion([X|Y],Z,[X|W]) :- \+ member(X,Z), funion(Y,Z,W).
funion([],Z,Z).
