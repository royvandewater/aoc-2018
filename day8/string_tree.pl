:- module(string_tree, [string_tree/2]).

:- use_module(debug).
:- use_module(split_at).

string_tree("", _) :- !, fail.

string_tree(Str, Tree) :-
  string_numbers(Str, Numbers),
  numbers_tree(Numbers, Tree).

string_numbers(Str, Numbers) :-
  split_string(Str, " ", " ", NumberStrs),
  maplist(atom_number, NumberStrs, Numbers).

numbers_tree(Numbers, Tree) :- read_node(Numbers, Tree, []).

read_node(Numbers, Node, RestNumbers) :-
  [NumNodes, NumMetadata | N1] = Numbers,
  read_nodes(NumNodes, N1, Nodes, N2),
  split_at(NumMetadata, N2, Metadata, N3),
  Node = node(Nodes, Metadata),
  RestNumbers = N3.

read_nodes(NumNodes, Numbers, Nodes, RestNumbers) :- read_nodes(NumNodes, Numbers, Nodes, RestNumbers, []).

read_nodes(0, Numbers, Nodes, RestNumbers, Acc) :- !, RestNumbers = Numbers, reverse(Acc, Nodes).
read_nodes(NumNodes, Numbers, Nodes, RestNumbers, Acc) :-
  read_node(Numbers, Node, N1),
  NewNumNodes is NumNodes - 1,
  read_nodes(NewNumNodes, N1, Nodes, RestNumbers, [ Node | Acc ]).
