:- module(part_1, [part_1/2]).

:- use_module(simplify).

part_1(Input, Answer) :-
  simplify(Input, Simple),
  string_length(Simple, Answer).