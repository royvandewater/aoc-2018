:- module(stream_instructions, [stream_instructions/2]).

stream_instructions(In, Instructions) :- stream_instructions(In, Instructions, []).

stream_instructions(In, Instructions, Acc) :-
  read_line_to_string(In, Line),
  stream_instructions(In, Instructions, Acc, Line).

stream_instructions(_In, Instructions, Acc, end_of_file) :- !, reverse(Acc, Instructions).

stream_instructions(In, Instructions, Acc, Line) :-
  % Step A must be finished before step K can begin.
  split_string(Line, " ", "", [_, Astr, _, _, _, _, _, Bstr, _, _]),
  atom_string(A, Astr),
  atom_string(B, Bstr),
  stream_instructions(In, Instructions, [ [A, B] | Acc ]).