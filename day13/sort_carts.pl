:- module(sort_carts, [sort_carts/2]).

sort_carts(Carts, Sorted) :- predsort(comp, Carts, Sorted).

comp('=', A, B) :- A.coord = B.coord, !.

comp('<', A, B) :-
  c(_, Ya) = A.coord,
  c(_, Yb) = B.coord,
  Ya < Yb, !.

comp('<', A, B) :-
  c(Xa, Ya) = A.coord,
  c(Xb, Yb) = B.coord,
  Ya = Yb,
  Xa < Xb, !.

comp('>', A, B) :-
  c(_, Ya) = A.coord,
  c(_, Yb) = B.coord,
  Ya > Yb, !.

comp('>', A, B) :-
  c(Xa, Ya) = A.coord,
  c(Xb, Yb) = B.coord,
  Ya = Yb,
  Xa > Xb, !.