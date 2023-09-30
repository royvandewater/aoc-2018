:- use_module(input_state).

:- begin_tests(input_state).

test(one_cart_east) :-
  input_state(">", X),
  assertion(X.carts == [ cart(c(0, 0), east) ]).

test(one_cart_south) :-
  input_state("v", X),
  assertion(X.carts == [ cart(c(0, 0), south) ]).

test(one_cart_west) :-
  input_state("<", X),
  assertion(X.carts == [ cart(c(0, 0), west) ]).

test(one_cart_north) :-
  input_state("^", X),
  assertion(X.carts == [ cart(c(0, 0), north) ]).

test(one_cart_further_east) :-
  input_state("->", X),
  assertion(X.carts == [ cart(c(1, 0), east) ]).

test(two_carts_east_west) :-
  input_state("><", X),
  assertion(X.carts == [ cart(c(0, 0), east),
                         cart(c(1, 0), west) ]).

test(two_carts_south_north) :-
  input_state("\
v
^", X),

  assertion(X.carts == [ cart(c(0, 0), south),
                         cart(c(0, 1), north) ]).


test(one_corner_wn_es) :- % west-north & east-south
  input_state("/", X),
  assertion(X.turns.turn(c(0,0)) == corner_wn_es).

test(one_corner_ws_en) :- % west-south & east-north
  input_state("\\", X),
  assertion(X.turns.turn(c(0,0)) == corner_ws_en).

test(one_intersection) :-
  input_state("+", X),
  assertion(X.turns.turn(c(0,0)) == intersection).

:- end_tests(input_state).
