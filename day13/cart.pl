:- module(cart, []).

Cart.advance(Turns) := OutCart :-
  Coord = Cart.coord,
  Turn = Turns.get_turn(Coord),
  OutCart = Cart.turn(Turn).move_forward(),
  !.

Cart.advance(_) := OutCart :- OutCart = Cart.move_forward().

%%%% move_forward()

Cart.move_forward() := OutCart :-
  Cart.facing = east,
  c(X, Y) = Cart.coord,
  X1 is X + 1,
  OutCart = Cart.put(coord, c(X1, Y)),
  !.

Cart.move_forward() := OutCart :-
  Cart.facing = west,
  c(X, Y) = Cart.coord,
  X1 is X - 1,
  OutCart = Cart.put(coord, c(X1, Y)),
  !.

Cart.move_forward() := OutCart :-
  Cart.facing = north,
  c(X, Y) = Cart.coord,
  Y1 is Y - 1,
  OutCart = Cart.put(coord, c(X, Y1)),
  !.

Cart.move_forward() := OutCart :-
  Cart.facing = south,
  c(X, Y) = Cart.coord,
  Y1 is Y + 1,
  OutCart = Cart.put(coord, c(X, Y1)),
  !.

%%%% turn()

Cart.turn(corner_wn_es) := OutCart :-
  Fin = Cart.facing,
  corner_wn_es(Fin, Fout),
  OutCart = Cart.put(facing, Fout),
  !.

Cart.turn(corner_ws_en) := OutCart :-
  Fin = Cart.facing,
  corner_ws_en(Fin, Fout),
  OutCart = Cart.put(facing, Fout),
  !.

Cart.turn(intersection) := OutCart :-
  Decision = Cart.current_decision(),
  Facing = Cart.apply_decision(Decision),
  OutCart = Cart.put(facing, Facing).put(last_decision, Decision),
  !.

Cart.current_decision() := straight :- Cart.last_decision == left.
Cart.current_decision() := right    :- Cart.last_decision == straight.
Cart.current_decision() := left     :- Cart.last_decision == right.

Cart.apply_decision(left) := north :- Cart.facing == east.
Cart.apply_decision(left) := west  :- Cart.facing == north.
Cart.apply_decision(left) := south :- Cart.facing == west.
Cart.apply_decision(left) := east  :- Cart.facing == south.
Cart.apply_decision(straight) := north :- Cart.facing == north.
Cart.apply_decision(straight) := west  :- Cart.facing == west.
Cart.apply_decision(straight) := south :- Cart.facing == south.
Cart.apply_decision(straight) := east  :- Cart.facing == east.
Cart.apply_decision(right) := north :- Cart.facing == west.
Cart.apply_decision(right) := west  :- Cart.facing == south.
Cart.apply_decision(right) := south :- Cart.facing == east.
Cart.apply_decision(right) := east  :- Cart.facing == north.

% corner symbol: /
corner_wn_es(west, south).
corner_wn_es(south, west).
corner_wn_es(east, north).
corner_wn_es(north, east).

% corner symbol: \
corner_ws_en(west, north).
corner_ws_en(north, west).
corner_ws_en(east, south).
corner_ws_en(south, east).