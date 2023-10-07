:- module(next_state, [next_state/3]).

:- use_module(move_elf).

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