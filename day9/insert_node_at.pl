:- module(insert_node_at, [insert_node_at/5]).

insert_node_at(Nodes, Prev, 1, Value, NodesOut) :-
  !,
  PrevNode = Nodes.get(Prev),
  Next = PrevNode.next,

  Nodes0 = Nodes.put(Prev, PrevNode.put(next, Value))
                .put(Value, node{prev: Prev, next: Next}),

  NextNode = Nodes0.get(Next), % broken out for the case where Next = Prev
  NodesOut = Nodes0.put(Next, NextNode.put(prev, Value)).

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
