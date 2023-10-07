:- use_module(matches_beginning, [matches_beginning/2]).

:- begin_tests(matches_beginning).

test(when_empty) :- matches_beginning([], []).
test(when_no_match, fail) :- matches_beginning([1], []).
test(when_exact_match) :- matches_beginning([1], [1]).
test(when_partial_match) :- matches_beginning([1], [1, 2]).
test(when_partial_longer_match) :- matches_beginning([1, 2], [1, 2, 3, 4]).

test(when_example_1) :- matches_beginning([9,8,5,1,5], [9,8,5,1,5,4,2,1,0,1,0,1,7,3]).

:- end_tests(matches_beginning).