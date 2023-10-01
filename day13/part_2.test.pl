:- use_module(part_2).
:- use_module(input_state).

:- begin_tests(part_2).

test(one_cart) :-
  input_state(">", State),
  part_2(State, X),
  assertion(X == c(0, 0)).

test(one_cart_moved_over) :-
  input_state("->", State),
  part_2(State, X),
  assertion(X == c(1, 0)).

test(three_carts_left_two_collide) :-
  input_state("><>", State),
  part_2(State, X),
  assertion(X == c(3, 0)).

test(example_1) :-
  Input ="\
/>-<O
|   |
| /<+-O
| | | v
O>+</ |
  |   ^
  O<->/
",
  input_state(Input, State),
  part_2(State, X),
  assertion(X == c(6,4)).

:- end_tests(part_2).