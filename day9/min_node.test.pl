:- use_module(min_node).
:- begin_tests(min_node).

test(when_one_item) :-
  min_node(nodes{'0': '0'}, '0', X),
  assertion(X == '0').

test(when_two_items) :-
  min_node(nodes{'0': '1', '1': '0'}, '0', X),
  assertion(X == '0').

test(when_two_items_different_entry) :-
  min_node(nodes{'0': '1', '1': '0'}, '1', X),
  assertion(X == '0').

test(when_no_zero) :-
  min_node(nodes{'1': '1'}, '1', X),
  assertion(X == '1').

:- end_tests(min_node).