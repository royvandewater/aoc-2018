:- use_module(move_elf).
:- begin_tests(move_elf).

test(when_initial_state_elf1) :-
  reverse([3, 7, 1, 0], Seq),
  ElfIn = elf{position: 0, value: 3},
  move_elf(Seq, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 0, value: 3}).

test(when_initial_state_elf2) :-
  reverse([3, 7, 1, 0], Seq),
  ElfIn = elf{position: 1, value: 7},
  move_elf(Seq, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 1, value: 7}).

test(when_second_state_elf1) :-
  reverse([3, 7, 1, 0, 1, 0], Seq),
  ElfIn = elf{position: 0, value: 3},
  move_elf(Seq, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 4, value: 1}).

test(when_second_state_elf2) :-
  reverse([3, 7, 1, 0, 1, 0], Seq),
  ElfIn = elf{position: 1, value: 7},
  move_elf(Seq, ElfIn, ElfOut),
  assertion(ElfOut == elf{position: 3, value: 0}).

:- end_tests(move_elf).