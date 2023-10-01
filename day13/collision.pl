:- module(collision, [collision/2, no_collision/2]).

no_collision(Needle, Haystack) :- \+ collision(Needle, Haystack).

collision(_, []) :- !, false.
collision(Needle, [ Item | Rest ]) :-
  C1 = Needle.coord,
  C2 = Item.coord,

  C1 == C2 ; collision(Needle, Rest).
