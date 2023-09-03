:- use_module(nodes_values).
:- begin_tests(nodes_values).

test(when_one_item) :-
  nodes_values(nodes{'0': node{next: '0'}}, '0', X),
  assertion(X == [0]).

test(when_two_items) :-
  nodes_values(nodes{'0': node{next: '1'},
                     '1': node{next: '0'}}, '0', X),
  assertion(X == [0, 1]).

test(when_two_items_different_entry) :-
  nodes_values(nodes{'0': node{next:'1'},
                     '1': node{next:'0'}}, '1', X),
  assertion(X == [1, 0]).

test(when_one_item_extra_capacity) :-
  nodes_values(nodes{'0': none,
                     '1': node{next: '1',prev: '1'}}, '1', X),
  assertion(X == [1]).

:- end_tests(nodes_values).