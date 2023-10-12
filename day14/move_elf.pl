:- module(move_elf, [move_elf/4]).

:- use_module(mutdict).

move_elf(MutDict, Count, InElf, OutElf) :-
  Position is (1 + InElf.position + InElf.value) mod Count,
  Value = MutDict.retrieve(Position),
  OutElf = elf{ position: Position, value: Value }.