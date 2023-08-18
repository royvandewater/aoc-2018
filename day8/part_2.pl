:- module(part_2, [part_2/2]).

:- use_module(debug).

part_2(Node, Result) :- node_value(Node, Result).

node_value(Node, Value) :-
  node([], Metadata) = Node, !,
  sum_list(Metadata, Value).

node_value(Node, Value) :-
  node(Nodes, Metadata) = Node,
  sum_indicies(Nodes, Metadata, Value).

sum_indicies(Nodes,  Indicies, Result) :- sum_indicies(Nodes, Indicies, Result, 0).
sum_indicies(_Nodes, [],       Result, Acc) :- !, Result = Acc.
sum_indicies(Nodes,  Indicies, Result, Acc) :-
  [ Index | Rest ] = Indicies,
  nth1(Index, Nodes, Node),
  !,
  node_value(Node, Value),
  NewAcc is Acc + Value,
  sum_indicies(Nodes, Rest, Result, NewAcc).

sum_indicies(Nodes, Indicies, Result, Acc) :-
  [ Index | Rest ] = Indicies,
  not(nth1(Index, Nodes, _)),
  sum_indicies(Nodes, Rest, Result, Acc).


