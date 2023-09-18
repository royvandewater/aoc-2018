:- module(debug, [debug/1, debug/2]).

debug(Str) :- string(Str), debug(Str, []), !.
debug(Val) :- debug("~w", [Val]).
debug(Str, Data) :- format(Str, Data), nl.