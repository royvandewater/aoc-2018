:- use_module(insert_node_at).

:- begin_tests(insert_node_at).

test(when_one_item) :-
  insert_node_at(nodes{'0': node{prev: '0', next: '0'},
                       '1': none},
                 '0', 1, '1', N),
  assertion(N == nodes{'0': node{prev: '1', next: '1'},
                       '1': node{prev: '0', next: '0'}}).

test(when_two_items) :-
  insert_node_at(nodes{'0': node{prev: '1', next: '1'},
                       '2': none,
                       '1': node{prev: '0', next: '0'}
                       }, '1', 2, '2', N),
  assertion(N == nodes{'0': node{prev: '1', next: '2'},
                       '2': node{prev: '0', next: '1'},
                       '1': node{prev: '2', next: '0'}}).

test(when_one_item_negative) :-
  insert_node_at(nodes{'0': node{prev: '0', next: '0'},
                       '1': none},
                 '0', -2, '1', N),
  assertion(N == nodes{'0': node{prev: '1', next: '1'},
                       '1': node{prev: '0', next: '0'}}).

:- end_tests(insert_node_at).