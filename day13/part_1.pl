:- module(part_1, [part_1/2]).

:- use_module(cart).
:- use_module(debug).

% part_1(State, _) :-
%   debug("Turns: ~w, Carts: ~w", [State.turns, State.carts]),
%   false.

part_1(State, FirstCollision) :-
  [ Cart | Rest ] = State.carts,
  Cart1 = Cart.advance(State.turns),
  no_collisions(Cart1, Rest),
  !,
  append(Rest, [ Cart1 ], Carts),
  State1 = State.put(carts, Carts),
  part_1(State1, FirstCollision).

part_1(State, FirstCollision) :-
  [ Cart | _ ] = State.carts,
  Cart1 = Cart.advance(State.turns),
  Coord = Cart1.coord,
  FirstCollision = Coord.

no_collisions(Needle, Haystack) :- \+ collisions(Needle, Haystack).

collisions(_, []) :- !, false.
collisions(Needle, [ Item | Rest ]) :-
  C1 = Needle.coord,
  C2 = Item.coord,

  C1 == C2 ; collisions(Needle, Rest).
