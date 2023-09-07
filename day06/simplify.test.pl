:- use_module(simplify).

:- begin_tests(simplify).

test(simplify_when_empty, true( X == "" )) :- simplify("", X).
test(simplify_when_no_cancels, true( X == "ab" )) :- simplify("ab", X).
test(simplify_when_one_immediate_cancel, true( X == "" )) :- simplify("aA", X).
test(simplify_when_first_cancel_reveals_a_second, true( X == "" )) :- simplify("abBA", X).

:- end_tests(simplify).
