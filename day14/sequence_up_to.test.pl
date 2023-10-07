:- use_module(sequence_up_to).
:- begin_tests(sequence_up_to).

test(when_0, true(X == [])) :- sequence_up_to(0, X).
test(when_1, true(X == [3])) :- sequence_up_to(1, X).
test(when_2, true(X == [3, 7])) :- sequence_up_to(2, X).
test(when_3, true(X == [3, 7, 1])) :- sequence_up_to(3, X).
test(when_4, true(X == [3, 7, 1, 0])) :- sequence_up_to(4, X).
test(when_10, true(X == [3, 7, 1, 0, 1, 0, 1, 2, 4, 5])) :- nl, sequence_up_to(10, X).

%  3  7  1  0 [1] 0  1  2 (4) 5  1  5  8  9  1  6  7  7  9  2

:- end_tests(sequence_up_to).