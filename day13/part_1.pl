:- module(part_1, [part_1/2]).

:- use_module(debug).

part_1(State, FirstCollision) :-
  [ Cart | Rest ] = State.carts,
  advance_cart(Cart, Cart1),
  no_collisions(Cart1, Rest),
  !,
  append(Rest, [ Cart1 ], Carts),
  State1 = State.put(carts, Carts),
  part_1(State1, FirstCollision).

part_1(State, FirstCollision) :-
  [ Cart | _ ] = State.carts,
  advance_cart(Cart, Cart1),
  cart(Coord, _) = Cart1,
  FirstCollision = Coord.

no_collisions(Needle, Haystack) :- \+ collisions(Needle, Haystack).

collisions(_, []) :- !, false.
collisions(Needle, [ Item | Rest ]) :-
  cart(C1, _) = Needle,
  cart(C2, _) = Item,

  C1 == C2 ; collisions(Needle, Rest).


advance_cart(cart(c(X, Y), east), Out) :-
  !,
  X1 is X + 1,
  Out = cart(c(X1, Y), east).

advance_cart(cart(c(X, Y), west), Out) :-
  !,
  X1 is X - 1,
  Out = cart(c(X1, Y), west).

advance_cart(cart(c(X, Y), south), Out) :-
  !,
  Y1 is Y + 1,
  Out = cart(c(X, Y1), south).

advance_cart(cart(c(X, Y), north), Out) :-
  !,
  Y1 is Y - 1,
  Out = cart(c(X, Y1), north).


