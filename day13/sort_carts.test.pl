:- use_module(sort_carts).
:- begin_tests(sort_carts).

test(empty) :-
  sort_carts([], X),
  assertion(X == []).

test(one_cart) :-
  C1 = cart{coord: c(0,0)},
  sort_carts([C1], X),
  assertion(X == [C1]).

test(one_cart_in_wrong_order) :-
  C1 = cart{coord: c(0,1)},
  C2 = cart{coord: c(0,0)},
  sort_carts([C1, C2], X),
  assertion(X == [C2, C1]).

:- end_tests(sort_carts).