:- module(turns, []).

T.get_turn(c(X,Y)) := Turn :-
  term_to_atom(c(X,Y), Key),
  Turn = T.get(Key).

T.put_turn(c(X,Y), Turn) := Turns :-
  term_to_atom(c(X,Y), Key),
  Turns = T.put(Key, Turn).
