:- use_module(move_elf).
:- use_module(mutdict).
:- use_module(debug).

:- begin_tests(move_elf).


test(when_initial_state_elf1) :-
  % sequence 3710
  MutDict = mutdict{}.insert_all(0, [3, 7, 1, 0]),
  Count = 4,
  ElfIn = elf{position: 0, value: 3},

  move_elf(MutDict, Count, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 0, value: 3}).

test(when_initial_state_elf2) :-
  % sequence 3710
  MutDict = mutdict{}.insert_all(0, [3, 7, 1, 0]),
  Count = 4,
  ElfIn = elf{position: 1, value: 7},

  move_elf(MutDict, Count, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 1, value: 7}).

test(when_second_state_elf1) :-
  MutDict = mutdict{}.insert_all(0, [3, 7, 1, 0, 1, 0]),
  debug("MutDict: ~w", [MutDict]),
  Count = 6,
  ElfIn = elf{position: 0, value: 3},

  move_elf(MutDict, Count, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 4, value: 1}).

test(when_second_state_elf2) :-
  MutDict = mutdict{}.insert_all(0, [3, 7, 1, 0, 1, 0]),
  Count = 6,
  ElfIn = elf{position: 1, value: 7},

  move_elf(MutDict, Count, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 3, value: 0}).

:- end_tests(move_elf).