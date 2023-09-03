:- module(nodes_values, [nodes_values/3]).

nodes_values(Nodes, Entry, Values) :-
  nodes_values(Nodes, Entry, Values, []).


nodes_values(Nodes, Curr, Values, Acc) :-
  Next = Nodes.get(Curr).next,
  !,
  del_dict(Curr, Nodes, _, NodesNext),
  nodes_values(NodesNext, Next, Values, [Curr | Acc]).

% We have gotten here if Nodes did not contain Curr
nodes_values(_Nodes, _Curr, Values, Acc) :-
  reverse(Acc, ValueAtoms),
  maplist(atom_number, ValueAtoms, Values).
