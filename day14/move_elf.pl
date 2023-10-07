:- module(move_elf, [move_elf/3]).

move_elf(Seq, InElf, OutElf) :-
  length(Seq, Length),
  Position is (1 + InElf.position + InElf.value) mod Length,
  Index is Length - Position,
  nth1(Index, Seq, Value),
  OutElf = elf{ position: Position, value: Value }.