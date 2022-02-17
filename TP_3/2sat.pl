/*	Importation des bibliothèques */
:- use_module(library(dialect/sicstus/block)).


/*	Saisie de la CNF à vérifier */
sat(Clauses, Vars) :- def_prob(Clauses), elim_var(Vars).

/* 	Vérification et atribution de la véractié */
elim_var([]).
elim_var([V | Vars]) :- elim_var(Vars), (V = true; V = false).

def_prob([]).
def_prob([Clause | Clauses]) :- def_clause(Clause), def_prob(Clauses).


/*	Définition d'une clause */
def_clause([B-V | Pairs]) :- def_surveille(Pairs, V, B).

/*	Définie la surveillance des clauses */
def_surveille([], V, B) :- V = B.
def_surveille([Pol2-Var2 | Pairs], Var1, Pol1) :- surveille(Var1, Pol1, Var2, Pol2, Pairs).

/*	Surveillance des blocks */
:- block surveille(-, ?, -, ?, ?).

surveille(Var1, Pol1, Var2, Pol2, Pairs) :- nonvar(Var1) -> re_surveille(Var1, Pol1, Var2, Pol2, Pairs); re_surveille(Var2, Pol2, Var1, Pol1, Pairs).

re_surveille(Var1, Pol1, Var2, Pol2, Pairs) :- Var1 == Pol1 -> true; def_surveille(Pairs, Var2, Pol2).

%sat([[true-A,true-B],[false-B,true-A],[false-A,false-A]],[A,B]).
%sat([[true-P,false-Q],[true-Q,true-R],[false-R,false-R]],[P,Q,R]).
