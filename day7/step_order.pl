:- module(step_order, [step_order/2]).

step_order(Steps, Path) :- walk_tree(Steps, Path, []).

walk_tree([], Path, Acc) :- !, reverse(Acc, Path).
walk_tree(Steps, Path, Acc) :-
  include(requirements_met(Acc), Steps, ReqsMet),
  % nl, format("Steps: ~w, PathSoFar: ~w, ReqsMet: ~w", [Steps, Acc, ReqsMet]), nl,
  sort(ReqsMet, [ Next | _ ]),
  step( Name, _ ) = Next,
  selectchk(Next, Steps, Rest),
  walk_tree(Rest, Path, [ Name | Acc ]).

requirements_met(Path, Step) :-
  step( _, Reqs) = Step,
  % nl, format("requirements_met Reqs: ~w", [Reqs]), nl,
  maplist(requirement_met(Path), Reqs).

requirement_met(Path, Req) :- member(Req, Path).

step_name(step(Name, _), Name) :- true.
