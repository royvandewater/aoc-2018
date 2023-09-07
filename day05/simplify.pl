:- module(simplify, [simplify/2]).

simplify(In, Out) :-
  string_chars(In, InChars),
  reverse(InChars, InCharsRev),

  simplify(InCharsRev, Out, []).

simplify([], Out, Acc) :- !, string_chars(Out, Acc).

simplify(In, Out, []) :- !,
  [ LastIn | InRest ] = In,
  simplify(InRest, Out, [LastIn]).

simplify(In, Out, Acc) :-
  [ LastIn | InRest ] = In,
  [ AccFirst| AccRest ] = Acc,

  string_lower(LastIn, LastInLower),
  string_lower(AccFirst, AccFirstLower),

  (
    ( LastIn \== AccFirst, LastInLower == AccFirstLower )
    -> simplify(InRest, Out, AccRest)
    ;  (NewAcc = [ LastIn | Acc ],
        simplify(InRest, Out, NewAcc))
  ).