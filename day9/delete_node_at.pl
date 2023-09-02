:- module(delete_node_at, [delete_node_at/6]).

delete_node_at(Nodes, Current, 0, ValueOut, NodesOut, CurrentOut) :-
  !,
  Node = Nodes.get(Current),
  del_dict(Current, Nodes, _, Nodes1),

  ValueOut = Current,
  CurrentOut = Node.next,

  Prev     = Nodes1.get(Node.prev),
  Nodes2   = Nodes1.put(Node.prev, Prev.put(next, Node.next)),
  Next     = Nodes2.get(Node.next),
  NodesOut = Nodes2.put(Node.next, Next.put(prev, Node.prev)).

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

