:- module(insert_node_at, [insert_node_at/5]).

insert_node_at(Nodes, Prev, 1, Value, NodesOut) :-
  !,
  PrevNode = Nodes.get(Prev),
  Next = PrevNode.next,
  NextNode = Nodes.get(Next),

  b_set_dict(next, PrevNode, Value),
  b_set_dict(prev, NextNode, Value),
  b_set_dict(Value, Nodes, node{prev: Prev, next: Next}),
  NodesOut = Nodes.

insert_node_at(Nodes, Current, Offset, Value, NodesOut) :-
  Offset < 1, !,
  Prev = Nodes.get(Current).prev,
  NewOffset is Offset + 1,
  insert_node_at(Nodes, Prev, NewOffset, Value, NodesOut).

insert_node_at(Nodes, Current, Offset, Value, NodesOut) :-
  Offset > 1, !,
  Next = Nodes.get(Current).next,
  NewOffset is Offset - 1,
  insert_node_at(Nodes, Next, NewOffset, Value, NodesOut).
