:- module(values_nodes, [values_nodes/2]).

values_nodes([], nodes{}) :- !.

values_nodes(Values, Nodes) :-
  [ V0 | _ ] = Values,
  atom_number(N0, V0),
  forward_nodes(Values, ForwardNodes, N0, nodes{}),

  last(Values, LastValue),
  atom_number(LastIndex, LastValue),
  backward_nodes(ForwardNodes, LastIndex, N0, Nodes).

forward_nodes([ V ], Nodes, N0, Acc) :-
  !,
  atom_number(N, V),
  Nodes = Acc.put(N, node{prev: none, next: N0}).

forward_nodes([ V | Vs ], Nodes, N0, Acc) :-
  [ V1 | _ ] = Vs,
  atom_number(N, V),
  atom_number(N1, V1),
  forward_nodes(Vs, Nodes, N0, Acc.put(N, node{prev: none, next: N1})).


backward_nodes(ForwardNodes, Prev, Curr, Nodes) :-
  ForwardNodes.get(Curr).prev == Prev,
  !,
  Nodes = ForwardNodes.

backward_nodes(ForwardNodes, Prev, Curr, Nodes) :-
  Node = ForwardNodes.get(Curr),
  ForwardNodes1 = ForwardNodes.put(Curr, Node.put(prev, Prev)),
  backward_nodes(ForwardNodes1, Curr, Node.next, Nodes).

last([ V ], V) :- !.
last([ _ | Vs ], V) :- last(Vs, V).