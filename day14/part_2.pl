:- module(part_2, [part_2/2]).

:- use_module(debug).
:- use_module(matches_beginning).
:- use_module(next_state).

part_2(Input, Answer) :-
  string_chars(Input, Chars),
  reverse(Chars, ReverseChars),
  maplist(atom_number, ReverseChars, Match),

  State = state{sequence: [7, 3], % sequence is reversed
                elf1: elf{position: 0, value: 3},
                elf2: elf{position: 1, value: 7}},

  advance_until_match(Match, State, Answer).

advance_until_match(Chars, State, Answer) :-
  matches_beginning(Chars, State.sequence),
  !,
  length(State.sequence, SeqLength),
  length(Chars, MatchLength),
  Answer is SeqLength - MatchLength.

advance_until_match(Chars, State, Answer) :-
  next_state(State, NextState, _),
  advance_until_match(Chars, NextState, Answer).



