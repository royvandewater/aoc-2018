:- module(input_state, [input_state/2]).

:- use_module(turns).

input_state(Input, State) :-
  string_lines(Input, Lines),
  lines_state(Lines, State, state{carts: [], turns: turns{}}, 0).

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

chars_state([ '>' | Rest ], State, StateNext, Y, X) :- !, direction_chars_state(east, Rest, State, StateNext, Y, X).
chars_state([ '<' | Rest ], State, StateNext, Y, X) :- !, direction_chars_state(west, Rest, State, StateNext, Y, X).
chars_state([ 'v' | Rest ], State, StateNext, Y, X) :- !, direction_chars_state(south, Rest, State, StateNext, Y, X).
chars_state([ '^' | Rest ], State, StateNext, Y, X) :- !, direction_chars_state(north, Rest, State, StateNext, Y, X).

chars_state([ '/'  | Rest ], State, StateNext, Y, X) :- !, turn_chars_state(corner_wn_es, Rest, State, StateNext, Y, X).
chars_state([ '\\' | Rest ], State, StateNext, Y, X) :- !, turn_chars_state(corner_ws_en, Rest, State, StateNext, Y, X).
chars_state([ '+'  | Rest ], State, StateNext, Y, X) :- !, turn_chars_state(intersection, Rest, State, StateNext, Y, X).

chars_state([ _ | Rest ], State, StateNext, Y, X) :-
  !,
  X1 is X + 1,
  chars_state(Rest, State, StateNext, Y, X1).

turn_chars_state(Turn, Rest, State, StateNext, Y, X) :-
  X1 is X + 1,
  Turns1 = State.turns.put_turn(c(X,Y), Turn),
  State1 = State.put(turns, Turns1),
  chars_state(Rest, State1, StateNext, Y, X1).


direction_chars_state(Direction, Rest, State, StateNext, Y, X) :-
  X1 is X + 1,
  Carts1 = [ cart(c(X, Y), Direction) | State.carts ],
  State1 = State.put(carts, Carts1),
  chars_state(Rest, State1, StateNext, Y, X1).
