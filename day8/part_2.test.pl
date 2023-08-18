:- use_module(part_2).

:- begin_tests(part_2).

test(when_empty) :-
  part_2(node([], []), X),
  assertion(X == 0).

test(when_one_metadata) :-
  part_2(node([], [1]), X),
  assertion(X == 1).

test(when_child_node_with_metadata) :-
  % the outer node has at least one child, so the metadata indicates which child indexes
  % count towards its value.  The inner node has no children, so its value is the sum
  % of its metadata.
  part_2(node([node([], [2])], [1]), X),
  assertion(X == 2).

test(when_metadata_isnt_valid_index) :-
  % when the metadata is not a valid index of a child node, the index is skipped,
  part_2(node([node([], [2])], [2]), X),
  assertion(X == 0).

:- end_tests(part_2).