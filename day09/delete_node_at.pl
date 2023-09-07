:- module(delete_node_at, [delete_node_at/6]).

% Descructively modifies Nodes
delete_node_at(Nodes, Current, 0, ValueOut, NodesOut, CurrentOut) :-
  !,
  Node = Nodes.get(Current),
  b_set_dict(Current, Nodes, none),

  ValueOut = Current,
  CurrentOut = Node.next,

  b_set_dict(next, Nodes.get(Node.prev), Node.next),
  b_set_dict(prev, Nodes.get(Node.next), Node.prev),

  NodesOut = Nodes.

delete_node_at(Nodes, Current, Offset, ValueOut, NodesOut, CurrentOut) :-
  Offset < 0, !,
  Prev = Nodes.get(Current).prev,
  NewOffset is Offset + 1,
  delete_node_at(Nodes, Prev, NewOffset, ValueOut, NodesOut, CurrentOut).

delete_node_at(Nodes, Current, Offset, ValueOut, NodesOut, CurrentOut) :-
  Offset > 0, !,
  Next = Nodes.get(Current).next,
  NewOffset is Offset - 1,
  delete_node_at(Nodes, Next, NewOffset, ValueOut, NodesOut, CurrentOut).

