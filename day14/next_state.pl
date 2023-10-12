:- module(next_state, [next_state/3]).

:- use_module(debug).
:- use_module(move_elf).
:- use_module(mutdict).

next_state(State, NextState, NumAdded) :-
  debug("State: ~w", [State]),
  find_next_recipe_values(State, Values),
  debug("NextValues: ~w", [Values]),
  append(Values, State.sequence, Seq1),

  length(Values, NumAdded),
  MutDict = State.mutdict.insert_all(State.count, Values),
  Count1 is State.count + NumAdded,

  move_elf(MutDict, Count1, State.elf1, Elf1),
  move_elf(MutDict, Count1, State.elf2, Elf2),

  NextState = State.put(sequence, Seq1)
                   .put(elf1, Elf1)
                   .put(elf2, Elf2)
                   .put(mutdict, MutDict)
                   .put(count, Count1).

find_next_recipe_values(State, RecipeValues) :-
  Value is State.elf1.value + State.elf2.value,
  atom_string(Value, ValueStr),
  string_chars(ValueStr, Chars),
  reverse(Chars, RevChars),
  maplist(atom_number, RevChars, RecipeValues).