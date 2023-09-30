:- use_module(cart).
:- use_module(input_state).

:- begin_tests(cart).

test(intersection) :-
  Input = "\
.|
-+
",

  input_state(Input, State),
  Cart = cart{coord: c(1, 1), facing: east, last_decision: right},
  X = Cart.advance(State.turns),
  assertion(X == cart{coord: c(1, 0), facing: north, last_decision: left}).

:- end_tests(cart).