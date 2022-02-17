/*---- Exercice 2 ----*/

% 	On commence par prendre des clauses déjà définies dans l'exo 1 :
conc([],L,L).
conc([T|Q],L,[T|QL]) :- conc(Q,L,QL).

inverser([],[]).
inverser([T|Q],L) :- inverser(Q,L1), conc(L1,[T], L).

supprimer(_,[],[]).
supprimer(X,[X|L1],L2) :- supprimer(X,L1,L2).
supprimer(X,[T|L1],[T|L2]) :- supprimer(X,L1,L2), X \= T.


%	-----------------------


%	 Verification de l'appartenance
appartenir(X,[X|_]).
appartenir(X,[_|R]) :- appartenir(X,R).

%	 Transforme une liste en un ensemble
listeEnsemble([],[]).
listeEnsemble([T|Q1],[T|Q2]) :- supprimer(T,Q1,Q), listeEnsemble(Q,Q2).

%	 La relation de sous ensemble E c F
sousEnsemble([],_).
sousEnsemble([T|Q],E) :- appartenir(T,E), sousEnsemble(Q,E).

% 	Egalite entre deux ensembles
equal([],[]).
equal([H1|_], L2) :- appartenir(H1,L2).

% 	Intersection de deux ensembles
intersection([],_,[]).
intersection([T|Q],L,[T|Q1]) :- appartenir(T,L), supprimer(T,L,QL), intersection(Q,QL,Q1).
intersection([T|Q],L,Q1) :- not(ensemble(T,L)), intersection(Q,L,Q1).

% 	Union de deux ensembles
union([],L,L).
union([T|Q],L,[T|Q1]) :- supprimer(T,L,QL), union(Q,QL,Q1).

% 	Différence de deux ensembles
diff([],_,[]).
diff([X|P],L,RR):-not(appartenir(X,L)),diff(P,L,R),RR=[X|R]; diff(P,L,RR).


% 	Complementaire de deux ensembles

% 	Cette clause permet de supprimer toutes les memes ocurences
% 	supprime_plusieurs(ListeElemASupprimer,ListeInitiale,ListeRacourcie)

supprime_plusieurs([P|A],L,LR) :- supprimer(P,L,LP), supprime_plusieurs(A,LP,LR).
supprime_plusieurs([],L,L).

complement(Ens,Espace,Cmplt):-supprime_plusieurs(Ens,Espace,Cmplt).


% 	Différence symétrique

diff_symetrique(S1,S2,Q,X) :- diff(S1,S2,D12), diff(S2,S1,D21), union(D12,D21,D), intersection(D,Q,X).












