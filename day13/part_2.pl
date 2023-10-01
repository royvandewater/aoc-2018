:- module(part_2, [part_2/2]).

:- use_module(cart).
:- use_module(collision).
:- use_module(debug).
:- use_module(sort_carts).

part_2(State, LastCartCoord) :-
  [ Cart ] = State.carts,
  !,
  LastCartCoord = Cart.coord.

part_2(State, LastCartCoord) :-
  turn(State.turns, State.carts, Carts),
  part_2(State.put(carts, Carts), LastCartCoord).

turn(Turns, CartsIn, CartsOut) :- turn(Turns, CartsIn, CartsOut, []).

turn(_, [], CartsOut, Acc) :-
  !,
  sort_carts(Acc, CartsOut).

turn(Turns, [ Cart | Rest ], CartsOut, Acc) :-
  Cart1 = Cart.advance(Turns),
  append(Rest, Acc, Others),
  no_collision(Cart1, Others),
  !,
  turn(Turns, Rest, CartsOut, [ Cart1 | Acc]).

turn(Turns, [ Cart | Rest ], CartsOut, Acc) :-
  Cart1 = Cart.advance(Turns),
  append(Rest, Acc, Others),
  collision(Cart1, Others),
  !,
  remove_carts(Cart1.coord, Rest, Rest1),
  remove_carts(Cart1.coord, Acc, Acc1),
  turn(Turns, Rest1, CartsOut, Acc1).

remove_carts(Coord, CartsIn, CartsOut) :-
  findall(Cart, (member(Cart, CartsIn), Cart.coord \= Coord), CartsOut).

