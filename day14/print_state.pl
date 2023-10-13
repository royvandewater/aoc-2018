:- module(print_state, [print_state/1]).

:- use_module(debug).
:- use_module(join).

print_state(State) :-
  nl,
  debug("State:"),
  debug("Elf1 ~w: ~w", [State.elf1.position, State.elf1.value]),
  debug("Elf2 ~w: ~w", [State.elf2.position, State.elf2.value]),
  reverse(State.sequence, Seq),
  join(Seq, SeqStr),
  debug("Sequence: ~w", [SeqStr]).