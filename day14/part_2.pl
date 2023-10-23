:- module(part_2, [part_2/2]).

:- use_module(debug).
:- use_module(matches_beginning).
:- use_module(mutdict).
:- use_module(next_state).

part_2(Input, Answer) :-
  string_chars(Input, Chars),
  reverse(Chars, CharsRev),
  maplist(atom_number, CharsRev, Match),

  State = state{sequence: [7, 3], % sequence is reversed
                elf1: elf{position: 0, value: 3},
                elf2: elf{position: 1, value: 7},
                mutdict: mutdict{}.insert_all(0, [3, 7]),
                count: 2},

  advance_until_match(Match, State, Answer).

advance_until_match(Chars, State, Answer) :-
  length(Chars, MatchLength),
  TailIndex is State.count - MatchLength + 1,
  Tail = State.mutdict.sequence(TailIndex),
  Chars == Tail,
  !,
  length(State.mutdict.sequence(), SeqLength),
  Answer is SeqLength - MatchLength.

advance_until_match(Chars, State, Answer) :-
  length(Chars, MatchLength),
  TailIndex is State.count - (MatchLength + 1),
  Tail = State.mutdict.sequence(TailIndex),
  drop_last(Tail, Tail1),
  % debug("~w : ~w", [Tail, Tail1]),
  Chars == Tail1,
  !,
  length(State.mutdict.sequence(), SeqLength),
  Answer is SeqLength - MatchLength.

advance_until_match(Chars, State, Answer) :-
  next_state(State, NextState, _),
  !,
  advance_until_match(Chars, NextState, Answer).

drop_last(L1, L2) :- drop_last_step(L1, L2, []).
drop_last_step([ _Item ], L2, Acc) :- reverse(L2, Acc), !.
drop_last_step([ Item | Rest ], L2, Acc) :- drop_last_step(Rest, L2, [ Item | Acc ]).

