:- use_module(finite).

:- begin_tests(finite).

% test(finite_when_empty, fail) :-
%   finite([], position(1, 1)).

% test(finite_when_single_coordinate, fail) :-
%   finite([coordinate(1, 1)], _).

% test(finite_when_one_boxed_in) :-
%   finite([
%     coordinate(1, 0), % top
%     coordinate(1, 2), % bottom
%     coordinate(0, 1), % left
%     coordinate(2, 1), % right
%     coordinate(1, 1)  % boxed in
%   ], coordinate(1, 1)).

% test(finite_when_top_missing, fail) :-
%   finite([
%     coordinate(1, 2), % bottom
%     coordinate(0, 1), % left
%     coordinate(2, 1), % right
%     coordinate(1, 1)  % boxed in
%   ], coordinate(1, 1)).

test(finite_example_1) :-
  finite([
    coordinate(1, 1), % A
    coordinate(1, 6), % B
    coordinate(8, 3), % C
    coordinate(3, 4), % D - finite
    coordinate(5, 5), % E - finite
    coordinate(8, 9)  % F
  ], coordinate(3, 4)).


:- end_tests(finite).