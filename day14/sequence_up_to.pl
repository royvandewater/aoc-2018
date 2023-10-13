:- module(sequence_up_to, [sequence_up_to/2]).

:- use_module(debug).
:- use_module(move_elf).
:- use_module(mutdict).
:- use_module(next_state).

sequence_up_to(0, []) :- !.
sequence_up_to(1, [3]) :- !.
sequence_up_to(2, [3, 7]) :- !.
sequence_up_to(N, Seq) :- sequence_up_to(N, Seq, state{sequence: [7, 3], % sequence is reversed
                                                       elf1: elf{position: 0, value: 3},
                                                       elf2: elf{position: 1, value: 7},
                                                       mutdict: mutdict{}.insert_all(0, [3, 7]),
                                                       count: 2}).

sequence_up_to(2, Seq, State) :- !, reverse(State.mutdict.sequence(), Seq).
sequence_up_to(N, _, _) :- N < 1, !, domain_error(n_should_not_be_less_than_1, N).
sequence_up_to(1, Seq, State) :-
  !,
  [ _ | Sequence ] = State.mutdict.sequence(),
  reverse(Sequence, Seq).

sequence_up_to(N, Seq, State) :-
  next_state(State, NextState, NumAdded),
  N1 is N - NumAdded,
  sequence_up_to(N1, Seq, NextState).
