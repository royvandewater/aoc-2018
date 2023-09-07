:- use_module(delete_node_at).
:- use_module(values_nodes).

:- begin_tests(delete_node_at).

test(when_two_items) :-
  values_nodes([0, 1], 2, Nodes),
  delete_node_at(Nodes, '1', -7, V, N, C),
  assertion(V == '0'),
  assertion(N == nodes{'0': none,
                       '1': node{prev: '1', next: '1'}}),
  assertion(C == '1').

test(when_three_items) :-
  values_nodes([0, 2, 1], 3, Nodes),
  delete_node_at(Nodes, '2', -1, V, N, C),
  assertion(V == '0'),
  assertion(N == nodes{'0': none,
                       '1': node{prev:'2', next: '2'},
                       '2': node{prev:'1', next: '1'}}),
  assertion(C == '2').

test(when_three_items_negative_two) :-
  values_nodes([0, 2, 1], 3, Nodes),
  delete_node_at(Nodes, '2', -2, V, N, C),
  assertion(V == '1'),
  assertion(N == nodes{'0': node{prev:'2', next: '2'},
                       '1': none,
                       '2': node{prev:'0', next: '0'}}),
  assertion(C == '0').

:- end_tests(delete_node_at).