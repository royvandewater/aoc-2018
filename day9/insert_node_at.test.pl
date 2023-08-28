:- use_module(insert_node_at).

:- begin_tests(insert_node_at).

test(when_one_item) :-
  insert_node_at(nodes{'0': '0'}, '0', 2, '1', N),
  assertion(N == nodes{'0': '1', '1': '0'}).

test(when_two_items) :-
  insert_node_at(nodes{'0': '1', '1': '0'}, '1', 2, '2', N),
  assertion(N == nodes{'0': '2', '2': '1', '1': '0'}).

test(when_one_item_negative) :-
  insert_node_at(nodes{'0': '0'}, '0', -2, '1', N),
  assertion(N == nodes{'0': '1', '1': '0'}).

:- end_tests(insert_node_at).