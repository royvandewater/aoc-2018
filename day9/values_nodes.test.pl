:- use_module(values_nodes).

:- begin_tests(values_nodes).

test(when_empty) :-
  values_nodes([], X),
  assertion(X == nodes{}).

test(when_one_item) :-
  values_nodes([0], X),
  assertion(X == nodes{'0': node{prev: '0', next: '0'}}).

test(when_two_items) :-
  values_nodes([0, 1], X),
  assertion(X == nodes{'0': node{prev: '1', next: '1'},
                       '1': node{prev: '0', next: '0'}}).

test(when_three_items) :-
  values_nodes([0, 1, 2], X),
  assertion(X == nodes{'0': node{prev: '2', next: '1'},
                       '1': node{prev: '0', next: '2'},
                       '2': node{prev: '1', next: '0'}}).

:- end_tests(values_nodes).