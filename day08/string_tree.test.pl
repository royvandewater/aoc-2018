:- use_module(string_tree).
:- begin_tests(string_tree).

test(when_empty, fail) :-
  string_tree("", _).

test(when_one_node_no_metadata) :-
  string_tree("0 0", Tree),
  assertion(Tree == node([], [])).

test(when_one_node_one_metadata) :-
  string_tree("0 1 2", Tree),
  assertion(Tree == node([], [2])).

test(when_two_nodes_no_metadata) :-
  string_tree("1 0 0 0", Tree),
  assertion(Tree == node([node([], [])], [])).

:- end_tests(string_tree).