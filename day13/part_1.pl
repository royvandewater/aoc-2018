:- module(part_1, [part_1/2]).

:- use_module(cart).
:- use_module(collision).
:- use_module(debug).
:- use_module(sort_carts).

% part_1(_, _) :- format(".", []), false.

part_1(State, FirstCollision) :-
  turn(State.turns, State.carts, Carts, Collision),
  var(Collision),
  !,
  part_1(State.put(carts, Carts), FirstCollision).

part_1(State, FirstCollision) :-
  turn(State.turns, State.carts, _, Collision),
  FirstCollision = Collision.

turn(Turns, CartsIn, CartsOut, Collision) :- turn(Turns, CartsIn, CartsOut, Collision, []).

turn(_, [], CartsOut, _, Acc) :- !, sort_carts(Acc, CartsOut).

turn(Turns, [ Cart | Rest ], CartsOut, Collision, Acc) :-
  Cart1 = Cart.advance(Turns),
  append(Rest, Acc, Others),
  (collision(Cart1, Others)
   -> Collision = Cart1.coord
   ;  turn(Turns, Rest, CartsOut, Collision, [ Cart1 | Acc])).
