:- module(board, [new_board/3]).

:- use_module(delete_node_at).
:- use_module(insert_node_at).
:- use_module(min_node).
:- use_module(nodes_values).
:- use_module(values_nodes).

new_board(Values, Current, Board) :-
  values_nodes(Values, Nodes),
  atom_number(C, Current),
  Board = board{nodes: Nodes, current: C}.

B.export() := X :-
  min_node(B.nodes, B.current, Min),
  nodes_values(B.nodes, Min, X).

B.insert_at(Offset, Value) :=  board{nodes: Nodes, current: V} :-
  atom_number(V, Value),
  insert_node_at(B.nodes, B.current, Offset, V, Nodes).

% Value becomes bound to the item being deleted
B.delete_at(Offset, Value) :=  board{nodes: Nodes, current: Current} :-
  delete_node_at(B.nodes, B.current, Offset, V, Nodes, Current),
  atom_number(V, Value).

