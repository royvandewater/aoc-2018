:- use_module(part_1).

:- begin_tests(part_1).

test(when_0) :-
  part_1(0, X),
  assertion(X == "3710101245").

% test(when_1) :-
%   part_1(1, X),
%   assertion(X == "7101012451").

% test(example_1) :-
%   part_1(9, X),
%   assertion(X == "5158916779").

:- end_tests(part_1).