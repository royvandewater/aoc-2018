:- module(sequence_up_to, [sequence_up_to/2]).

:- use_module(debug).
:- use_module(move_elf).

sequence_up_to(0, []) :- !.
sequence_up_to(1, [3]) :- !.
sequence_up_to(2, [3, 7]) :- !.
sequence_up_to(N, Seq) :- sequence_up_to(N, Seq, state{sequence: [7, 3], % sequence is reversed
                                                       elf1: elf{position: 0, value: 3},
                                                       elf2: elf{position: 1, value: 7}}).

sequence_up_to(N, _, _) :- 0 is N mod 1000, debug(N), false.

sequence_up_to(2, Seq, State) :- !, reverse(State.sequence, Seq).
sequence_up_to(N, _, _) :- N < 1, !, domain_error(n_should_not_be_less_than_1, N).
sequence_up_to(1, Seq, State) :-
  !,
  [ _ | Sequence ] = State.sequence,
  sequence_up_to(2, Seq, State.put(sequence, Sequence)).

sequence_up_to(N, Seq, State) :-
  next_state(State, NextState, NumAdded),
  N1 is N - NumAdded,
  sequence_up_to(N1, Seq, NextState).

next_state(State, NextState, NumAdded) :-
  find_next_recipe_values(State, Values),
  append(Values, State.sequence, Seq1),

  move_elf(Seq1, State.elf1, Elf1),
  move_elf(Seq1, State.elf2, Elf2),

  NextState = State.put(sequence, Seq1)
                   .put(elf1, Elf1)
                   .put(elf2, Elf2),

  length(Values, NumAdded).

find_next_recipe_values(State, RecipeValues) :-
  Value is State.elf1.value + State.elf2.value,
  atom_string(Value, ValueStr),
  string_chars(ValueStr, Chars),
  reverse(Chars, RevChars),
  maplist(atom_number, RevChars, RecipeValues).

lpad(Number, Padded) :-
  format(atom(Padded), "~`0t~d~2+", Number).
