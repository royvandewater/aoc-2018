:- module(join, [join/2]).

join(Atoms, Answer) :- join(Atoms, Answer, "").
join([], Answer, Answer) :- !.
join([ X | Rest ], Answer, Acc) :-
  string_concat(Acc, X, Acc1),
  join(Rest, Answer, Acc1).