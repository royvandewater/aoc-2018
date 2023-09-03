:- module(debug, [debug/1, debug/2]).

debug(Str) :- nl, format(Str), nl.
debug(Str, Data) :- nl, format(Str, Data), nl.