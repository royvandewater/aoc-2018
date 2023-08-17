:- module(step_order, [step_order/2]).

:- use_module(available_steps).

step_order(Steps, Path) :- walk_tree(Steps, Path, []).

walk_tree([], Path, Acc) :- !, reverse(Acc, Path).
walk_tree(Steps, Path, Acc) :-
  available_steps(Steps, Acc, [ Next | _ ]),
  step( Name, _ ) = Next,
  selectchk(Next, Steps, Rest),
  walk_tree(Rest, Path, [ Name | Acc ]).

step_name(step(Name, _), Name) :- true.
