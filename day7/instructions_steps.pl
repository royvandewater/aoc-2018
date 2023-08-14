:- module(instructions_steps, [instructions_steps/2]).

instructions_steps(Instructions, Steps) :-
  instructions_names(Instructions, Names),
  maplist(instructions_step(Instructions), Names, Steps).

instructions_names(Instructions, Names) :-
  flatten(Instructions, NamesWithDuplicates),
  sort(NamesWithDuplicates, Names).

instructions_step(Instructions, Name, Step) :-
  findall(Req, member([ Req, Name ], Instructions), Reqs),
  Step = step(Name, Reqs).
