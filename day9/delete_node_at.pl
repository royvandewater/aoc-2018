:- module(delete_node_at, [delete_node_at/6]).

delete_node_at(Nodes, Current, 1, ValueOut, NodesOut, CurrentOut) :-
  !,
  ValueOut = Nodes.get(Current),
  del_dict(ValueOut, Nodes, CurrentOut, Nodes1),
  NodesOut = Nodes1.put(Current, CurrentOut).

delete_node_at(Nodes, Current, Offset, ValueOut, NodesOut, CurrentOut) :-
  Offset < 1, !,
  nodes_length(Nodes, Length),
  NewOffset is Offset + Length,
  delete_node_at(Nodes, Current, NewOffset, ValueOut, NodesOut, CurrentOut).

delete_node_at(Nodes, Current, Offset, ValueOut, NodesOut, CurrentOut) :-
  Offset > 1, !,
  Next = Nodes.get(Current),
  NewOffset is Offset - 1,
  delete_node_at(Nodes, Next, NewOffset, ValueOut, NodesOut, CurrentOut).

nodes_length(Nodes, Length) :-
  dict_pairs(Nodes, _, Pairs),
  length(Pairs, Length).

