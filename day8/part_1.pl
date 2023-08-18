:- module(part_1, [part_1/2]).

part_1(Node, Result) :-
  node(Nodes, Metadata) = Node,
  sum_list(Metadata, SumMetadata),
  maplist(part_1, Nodes, NodesSums),
  sum_list([ SumMetadata | NodesSums ], Result).
