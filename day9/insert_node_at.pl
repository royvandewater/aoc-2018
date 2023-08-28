:- module(insert_node_at, [insert_node_at/5]).


insert_node_at(Nodes, Current, 1, Value, NodesOut) :-
  !,
  Next = Nodes.get(Current),
  NodesOut = Nodes.put(Current, Value).put(Value, Next).

insert_node_at(Nodes, Current, Offset, Value, NodesOut) :-
  Offset < 1, !,
  nodes_length(Nodes, Length),
  NewOffset is Offset + Length,
  insert_node_at(Nodes, Current, NewOffset, Value, NodesOut).

insert_node_at(Nodes, Current, Offset, Value, NodesOut) :-
  Offset > 1, !,
  Next = Nodes.get(Current),
  NewOffset is Offset - 1,
  insert_node_at(Nodes, Next, NewOffset, Value, NodesOut).

nodes_length(Nodes, Length) :-
  dict_pairs(Nodes, _, Pairs),
  length(Pairs, Length).