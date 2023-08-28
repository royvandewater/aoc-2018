:- module(min_node, [min_node/3]).

min_node(Nodes, Entry, Min) :-
  atom_number(Entry, E),
  min_node(Nodes, Entry, Min, E).

min_node(nodes{}, _Curr, Min, Acc) :- !, atom_number(Min, Acc).

min_node(Nodes, Curr, Min, Acc) :-
  atom_number(Curr, C),
  AccNext is min(Acc, C),
  del_dict(Curr, Nodes, _, NodesNext),
  min_node(NodesNext, Nodes.get(Curr), Min, AccNext).

