:- use_module(stream_instructions).

:- begin_tests(stream_instructions).

test(when_empty, true(X == [])) :-
  open_string("", Stream),
  stream_instructions(Stream, X).

test(when_one_instruction, true(X == [['A', 'B']])) :-
  open_string("Step A must be finished before step B can begin.", Stream),
  stream_instructions(Stream, X).

:- end_tests(stream_instructions).