:- module(nodes_values, [nodes_values/3]).

nodes_values(Nodes, Entry, Values) :-
  nodes_values(Nodes, Entry, Values, []).

nodes_values(nodes{}, _, Values, Acc) :-
  !,
  reverse(Acc, ValueAtoms),
  maplist(atom_number, ValueAtoms, Values).

nodes_values(Nodes, Curr, Values, Acc) :-
  del_dict(Curr, Nodes, _, NodesNext),
  nodes_values(NodesNext, Nodes.get(Curr), Values, [Curr | Acc]).
