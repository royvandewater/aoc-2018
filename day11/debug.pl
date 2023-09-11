:- module(debug, [debug/1, debug/2]).

debug(Str) :- debug(Str, []).
debug(Str, Data) :- format(Str, Data), nl.