:- module(debug, [debug/2]).

debug(Str, Data) :- format(Str, Data), nl.