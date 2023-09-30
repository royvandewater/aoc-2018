:- module(input_state, [input_state/2]).

input_state(Input, State) :-
  string_lines(Input, Lines),
  lines_state(Lines, State, state{carts: []}, 0).

lines_state([], State, Acc, _) :-
  reverse(Acc.carts, Carts),
  State = Acc.put(carts, Carts),
  !.

lines_state([ Line | Rest ], State, Acc, Y) :-
  line_state(Line, Acc, Acc1, Y),
  Y1 is Y + 1,
  lines_state(Rest, State, Acc1, Y1).

line_state(Line, State, StateNext, Y) :-
  string_chars(Line, Chars),
  chars_state(Chars, State, StateNext, Y, 0).

chars_state([], State, StateNext, _, _) :- StateNext = State, !.

chars_state([ '-' | Rest ], State, StateNext, Y, X) :-
  !,
  X1 is X + 1,
  chars_state(Rest, State, StateNext, Y, X1).

chars_state([ '>' | Rest ], State, StateNext, Y, X) :-
  !,
  direction_chars_state(east, Rest, State, StateNext, Y, X).

chars_state([ '<' | Rest ], State, StateNext, Y, X) :-
  !,
  direction_chars_state(west, Rest, State, StateNext, Y, X).

chars_state([ 'v' | Rest ], State, StateNext, Y, X) :-
  !,
  direction_chars_state(south, Rest, State, StateNext, Y, X).

chars_state([ '^' | Rest ], State, StateNext, Y, X) :-
  !,
  direction_chars_state(north, Rest, State, StateNext, Y, X).

direction_chars_state(Direction, Rest, State, StateNext, Y, X) :-
  X1 is X + 1,
  Carts1 = [ cart(c(X, Y), Direction) | State.carts ],
  State1 = State.put(carts, Carts1),
  chars_state(Rest, State1, StateNext, Y, X1).
