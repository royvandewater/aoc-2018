:- use_module(delete_node_at).
:- use_module(values_nodes).

:- begin_tests(delete_node_at).

test(when_two_items) :-
  values_nodes([0, 1], Nodes),
  delete_node_at(Nodes, '1', -7, V, N, C),
  assertion(V == '0'),
  assertion(N == nodes{'1': '1'}),
  assertion(C == '1').

test(when_three_items) :-
  values_nodes([0, 2, 1], Nodes),
  delete_node_at(Nodes, '2', -1, V, N, C),
  assertion(V == '0'),
  assertion(N == nodes{'1': '2', '2': '1'}),
  assertion(C == '2').

test(when_three_items_negative_two) :-
  values_nodes([0, 2, 1], Nodes),
  delete_node_at(Nodes, '2', -2, V, N, C),
  assertion(V == '1'),
  assertion(N == nodes{'0': '2', '2': '0'}),
  assertion(C == '0').

test(when_22_items_negative_7) :-
  Nodes = nodes{'0':'16', '1':'12', '10':'21', '11':'1', '12':'6', '13':'3', '14':'7', '15':'0', '16':'8', '17':'4', '18':'9', '19':'2', '2':'20', '20':'10', '21':'5', '22':'11', '3':'14', '4':'18', '5':'22', '6':'13', '7':'15', '8':'17', '9':'19'},
  delete_node_at(Nodes, '22', -7, V, _N, C),
  assertion(V == '9'),
  assertion(C == '19').



:- end_tests(delete_node_at).