:- module(exists_step_less_than, [exists_step_less_than/2]).

% exists_step_less_than returns true if there exists at least one
% step who's destination is less than the destination of the current step
% in alphabetical order
%
% exists_step_less_than(Step, OtherSteps)
exists_step_less_than([ _, A ], OtherSteps) :-
  member([ _, B ], OtherSteps),
  char_code(A, Acode),
  char_code(B, Bcode),
  Bcode < Acode.

