/*---- Exercice 1 ----*/

/* Trouver le premier element */
premier([T|_],T).

/* Trouver le dernier element */
dernier([D],D).
dernier([_|R],D) :- dernier(R,D).

/* Inserer un element au debut de la liste */
addhead(X, L, [X|L]).

/* Inserer a  la fin */
addlast(X, [], [X]).
addlast(X, [R|L], [R|L1]):- addlast(X, L, L1).

/* Supprimer un element*/
supprimer(_,[],[]).
supprimer(X,[X|L1],L2) :- supprimer(X, L1, L2).
supprimer(X,[T|L1],[T|L2]) :- supprimer(X, L1, L2), X \= T.

/* Inverser les elements d'une liste */
inverse([],[]).
inverse([H|T],L) :- inverse(T,B),conc(B,[H],L).

/* Verifier qu'une liste est miroir */
miroir(X) :- inverse(X,X).

/* Fusion*/
fusion([],[],[]).
fusion([T|[Q|L]], [T|L1], [Q|L2]) :- fusion(L, L1, L2).

/* Elements pairs d'une liste */
even([], []).
even([X],[X]).
even([X,Y|L1], [X| L2]) :- even(L1,L2).

/* Fibonacci */

:- dynamic(stored/1). % Stockage de la donnée

memo(But) :-
    stored(But) -> true;
    But, assertz(stored(But)).

fibo(1,1) :- !, write('1, ').
fibo(2,1) :- !, write('1, ').
fibo(N,F) :-
    N1 is N-1, memo(fibo(N1,F1)), 
    N2 is N-2, memo(fibo(N2,F2)), 
    F is F1 + F2,
    write(F), write(', ').

/* Concatene 2 listes*/
conc([],L,L).
conc([X|Y],L,[X|RL]) :- conc(Y,L,RL).
