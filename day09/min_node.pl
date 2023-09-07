:- module(min_node, [min_node/3]).

:- use_module(nodes_values).

min_node(Nodes, Entry, Min) :-
  nodes_values(Nodes, Entry, Values),
  min_list(Values, MinValue),
  atom_number(Min, MinValue).

