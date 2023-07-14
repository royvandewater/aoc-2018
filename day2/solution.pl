#!/usr/bin/env swipl

:- initialization(main, main).

% main() :- main("input.txt").
main(Argv) :-
  [Filename | _] = Argv,
  open(Filename, read, In),
  input_to_list(In, Input),
  checksum(Input, Checksum),
  log("Checksum", Checksum),
  find_common_characters_of_ids_that_differ_by_one(Input, CommonChars),
  log("CommonChars", CommonChars),
  close(In).

log(Label, Value) :- write(Label), write(": "), writeln(Value).

input_to_list(In, List) :- input_to_list(In, List, []).
input_to_list(In, List, Acc) :-
  (read_line_to_string(In, Line),
   (Line = end_of_file
    -> List = Acc
    ; (append(Acc, [Line], NewAcc),
    input_to_list(In, List, NewAcc)))).

checksum([], 0) :- !.
checksum(Input, Checksum) :-
  count_items_with_doubles(Input, Doubles),
  count_items_with_tripples(Input, Tripples),
  Checksum is Doubles * Tripples.


count_items_with_doubles([], 0) :- !.
count_items_with_doubles(List, Count) :-
  aggregate_all(count, (member(X, List), has_double(X)), Count).

count_items_with_tripples([], Count) :- Count = 0, !.
count_items_with_tripples(List, Count) :-
  aggregate_all(count, (member(X, List), has_tripple(X)), Count).

has_double(Input) :- has_n(Input, 2).

differs_by_one_character(A, B) :-
  string_chars(A, AChars),
  string_chars(B, BChars),
  differs_by_one_character(AChars, BChars, false).
  % subtract(AChars, BChars, ANotInB),
  % subtract(BChars, AChars, BNotInA),
  % length(ANotInB, 1),
  % length(BNotInA, 1),
  % log("ANotInB", ANotInB),
  % log("BNotInA", BNotInA),
  % ANotInB \= BNotInA.

differs_by_one_character([], [], true) :- true, !.
differs_by_one_character([], [], false) :- false, !.
differs_by_one_character(AChars, BChars, FoundOne) :-
  [A | ARest] = AChars,
  [B | BRest] = BChars,
  ( A = B
    -> differs_by_one_character(ARest, BRest, FoundOne)
    ;  ( FoundOne
         -> false
         ;  differs_by_one_character(ARest, BRest, true))).

common_characters(A, B, Result) :-
  string_chars(A, AChars),
  string_chars(B, BChars),
  common_characters(A, B, ResultChars, AChars, BChars, []),
  string_chars(Result, ResultChars).

common_characters(_, _, Result, [], [], Acc) :- Result = Acc.
common_characters(_, _, Result, AChars, BChars, Acc) :-
  [A | ARest] = AChars,
  [B | BRest] = BChars,
  ( A = B
    -> (append(Acc, [A], NewAcc),
        common_characters(_, _, Result, ARest, BRest, NewAcc), !)
    ;  common_characters(_, _, Result, ARest, BRest, Acc)).

find_ids_that_differ_by_one(Ids, Result) :-
  member(A, Ids),
  member(B, Ids),
  differs_by_one_character(A, B), !,
  Result = [A, B].

find_common_characters_of_ids_that_differ_by_one(Ids, Result) :-
  find_ids_that_differ_by_one(Ids, [A, B]),
  common_characters(A, B, Result).

:- begin_tests(find_common_characters_of_ids_that_differ_by_one).

test(find_common_characters_of_ids_that_differ_by_one_example_1) :-
  find_common_characters_of_ids_that_differ_by_one([
    "abcde",
    "fghij",
    "klmno",
    "pqrst",
    "fguij",
    "axcye",
    "wvxyz"
  ], Result),
  Result = "fgij".

:- end_tests(find_common_characters_of_ids_that_differ_by_one).

:- begin_tests(find_ids_that_differ_by_one).

test(find_ids_that_differ_by_one_when_given_two_ids_differing_by_one) :-
  find_ids_that_differ_by_one([
    "abc",
    "abd"
  ], [
    "abc",
    "abd"
  ]).

test(find_ids_that_differ_by_one_when_given_three_ids) :-
  find_ids_that_differ_by_one([
    "def",
    "deg",
    "ccc"
  ], [
    "def",
    "deg"
  ]).

:- end_tests(find_ids_that_differ_by_one).

:- begin_tests(common_characters).

test(common_characters_when_identical) :-
  common_characters("abc", "abc", CommonChars),
  CommonChars = "abc".

test(common_characters_when_different_by_one) :-
  common_characters("abc", "abd", CommonChars),
  CommonChars = "ab".

test(common_characters_when_different_by_one_and_one_char_repeated) :-
  common_characters("aba", "abc", CommonChars),
  CommonChars = "ab".

:- end_tests(common_characters).

:- begin_tests(differs_by_one_character).

test(differs_by_one_character_when_identical, [fail]) :-
  differs_by_one_character("abc", "abc").

test(differs_by_one_character_when_differing_by_one_char) :-
  differs_by_one_character("abc", "abd").

test(differs_by_one_character_when_differing_by_two_chars, [fail]) :-
  differs_by_one_character("abc", "ade").

test(differs_by_one_character_failure_case, [fail]) :-
  differs_by_one_character(
    "oiwcdpbseqgxryfmlpktnupvza",
    "eiwcdpbseqhxryfmlgktnvuvza"
  ).

:- end_tests(differs_by_one_character).

:- begin_tests(checksum).

test(checksum_when_empty) :-
  checksum([], Checksum),
  Checksum =:= 0.

test(checksum_when_one_double_and_one_tripple) :-
  checksum(["aaa", "aa"], Checksum),
  Checksum =:= 1.

:- end_tests(checksum).

:- begin_tests(count_items_with_doubles).

test(count_items_with_doubles_when_empty) :-
  count_items_with_doubles([], Count),
  Count =:= 0.
test(count_items_with_doubles_when_one_item) :-
  count_items_with_doubles(["aa"], Count),
  Count =:= 1.
test(count_items_with_doubles_when_one_item_but_isnt_a_double) :-
  count_items_with_doubles(["ab"], Count),
  Count =:= 0.
test(count_items_with_doubles_when_two_different_doubles) :-
  count_items_with_doubles(["aa", "bb"], Count),
  Count =:= 2.


:- end_tests(count_items_with_doubles).

:- begin_tests(count_items_with_tripples).

test(count_items_with_tripples_when_empty) :-
  count_items_with_tripples([], Count),
  Count =:= 0.
test(count_items_with_tripples_when_one_item) :-
  count_items_with_tripples(["aaa"], Count),
  Count =:= 1.
test(count_items_with_tripples_when_one_item_but_isnt_a_double) :-
  count_items_with_tripples(["abc"], Count),
  Count =:= 0.
test(count_items_with_tripples_with_two_tripples) :-
  count_items_with_tripples(["aaa", "bbb"], Count),
  Count =:= 2.

:- end_tests(count_items_with_tripples).



:- begin_tests(has_double).

test(has_double_when_no_double, [fail]) :- has_double("abcdef").
test(has_double_when_it_has_a_double) :- has_double("abbcde").
test(has_double_when_it_has_a_different_double) :- has_double("affcde").
test(has_double_when_it_has_tripple, [fail]) :- has_double("afffde").

:- end_tests(has_double).

has_tripple(Input) :- has_n(Input, 3).

:- begin_tests(has_tripple).

test(has_tripple_when_no_tripple, [fail]) :- has_tripple("abcdef").
test(has_tripple_when_it_has_a_tripple) :- has_tripple("abbbde").
test(has_tripple_when_it_has_a_different_tripple) :- has_tripple("afffde").

:- end_tests(has_tripple).

has_n(Input, N) :-
  string_chars(Input, Chars),
  member(X, Chars),
  aggregate_all(count, member(X, Chars), Count),
  Count == N, !.