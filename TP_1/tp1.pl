/*---- Exercice 1 ----*/


/*	Predicat personne qui la décrit : prénom, taille, couleur des cheveux et âge
	Une personne sera représentée par son numéro 
*/

personne(1, pistache, 175, violet, 21).
personne(2, matelotte, 170, rose, 25).
personne(3, missouri, 180, noir, 33).
personne(4, lambada, 167, blanc, 26).
personne(5, machate, 165, rose, 24).

/*	Predicat gout qui associe pour chaque personne ses gouts : musique, littérature, sport */

gout(1, rap, policier, basket).
gout(2, pop, roman, foot).
gout(3, pop, roman, foot).
gout(4, jazz, lettre, tenis).
gout(5, jazz, lettre, tenis).

/*	Predicat recherche qui pour chaque personne rentre ses critères : taille, couleur des cheveux et âge */

recherche(1, 170, rose, 25).
recherche(2, 175, violet, 21).
recherche(3, 167, blanc, 26).
recherche(4, 165, rose, 24).
recherche(5, 167, blanc, 26).

/*	Règle convient physiquement si deux personne ont les mêmes recherches physiques */
convientphysiquement(X,Y) :- recherche(X, X1, X2, X3), personne(Y, _, X1, X2, X3).

/*	Règle ont même gouts si les deux personnes ont les mêmes gouts */
ontmemesgouts(X,Y) :- gout(X, X1, X2, X3) , gout(Y, X1, X2, X3).

/*	Une personne convient à une autre si elles ont les mêmes gouts et si elle correspond à ses critères physiques */
convient(X, Y) :- convientphysiquement(X, Y), ontmemesgouts(X, Y).

/*	Deux personnes peuvent former un couple si elles se conviennent toutes les deux */
couple(X,Y) :- convient(X, Y), convient(Y, X).


/*---- Exercice 2 ----*/


couleur(vert).
couleur(jaune).
couleur(rouge).

/*	On exprime la condition ici deux zones contigues ne peuvent pas avoir la même couleur */
contigues(X, Y) :- X \== Y.

/*	Premier predicat qui définit le coloriage : on colorie chaque zone sans conditions */
coloriage(C1, C2, C3, C4) :- couleur(C1), couleur(C2), couleur(C3), couleur(C4).

/*	On effectue dans un second temps le coloriage conforme : deux zones qui se touvhent ne peuvent pas avoir la même couleur */
coloriageconforme(C1, C2, C3, C4) :- coloriage(C1, C2, C3, C4), 
    contigues(C1, C2),
    contigues(C1, C3), 
    contigues(C1, C4), 
    contigues(C2, C3), 
    contigues(C3, C4).


/*---- Exercice 3 ----*/


/*	Trois villes possibles : rome, tunis et londres */
ville(rome).
ville(tunis).
ville(londres).

/*	Prix du transport en fonction de la ville */
transport(rome, 130).
transport(tunis, 300).
transport(londres, 50).
prix(X) :- tranport(Y, X).

/*	Prix pour une semaine - ville, type d hébergement, prix */
catalogue(rome, hotel, 1000).
catalogue(rome, chambre, 700).
catalogue(rome, camping,  600).

catalogue(tunis, hotel, 900).
catalogue(tunis, chambre, 550).
catalogue(tunis, camping, 500).

catalogue(londres, hotel, 950).
catalogue(londres, chambre, 700).
catalogue(londres, camping,  600).

/* 	Durée du séjour */
duree(X).

/* 	Voyage
	Le prix = prix du transport + prix de l'hebergement * la durée du séjour 
*/
voyage(V, D, H, S) :- transport(V, X, _) , catalogue(V, H, Y), S is X + Y*D.

/* Voyage économique */
voyageEco(V, D, H, S, Smax) :- voyage(V, D, H, S), S =<Smax.
