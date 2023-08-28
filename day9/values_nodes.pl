:- module(values_nodes, [values_nodes/2]).

values_nodes([], nodes{}) :- !.

values_nodes(Values, Nodes) :-
  [ V0 | _ ] = Values,
  atom_number(N0, V0),
  values_nodes(Values, Nodes, N0, nodes{}).

values_nodes([ V ], Nodes, N0, Acc) :-
  !,
  atom_number(N, V),
  Nodes = Acc.put(N, N0).

values_nodes([ V | Vs ], Nodes, N0, Acc) :-
  [ V1 | _ ] = Vs,
  atom_number(N, V),
  atom_number(N1, V1),
  values_nodes(Vs, Nodes, N0, Acc.put(N, N1)).