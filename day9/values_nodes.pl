:- module(values_nodes, [values_nodes/3]).

values_nodes([], Capacity, Nodes) :-
  !,
  init_nodes(Capacity, Nodes).

values_nodes(Values, Capacity, Nodes) :-
  [ V0 | _ ] = Values,
  init_nodes(Capacity, EmptyNodes),

  atom_number(N0, V0),
  forward_nodes(Values, ForwardNodes, N0, EmptyNodes),

  last(Values, LastValue),
  atom_number(LastIndex, LastValue),
  backward_nodes(ForwardNodes, LastIndex, N0, Nodes).

init_nodes(Capacity, Nodes) :-
  init_pairs(Capacity, Pairs),
  dict_pairs(Nodes, nodes, Pairs).

init_pairs(Capacity, Pairs) :-
  init_keys(Capacity, Keys),
  init_values(Capacity, Values),
  pairs_keys_values(Pairs, Keys, Values).

init_keys(N, Keys) :- init_keys(N, Keys, []).
init_keys(0, Keys, Acc) :- !, Keys = Acc.
init_keys(N, Keys, Acc) :-
  N0 is N - 1,
  atom_number(Key, N0),
  init_keys(N0, Keys, [ Key | Acc ]).

init_values(N, Keys) :- init_values(N, Keys, []).
init_values(0, Values, Acc) :- !, Values = Acc.
init_values(N, Values, Acc) :-
  N0 is N - 1,
  init_values(N0, Values, [ none | Acc ]).




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