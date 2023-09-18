:- use_module(grid_sum_table).
:- use_module(debug).

:- begin_tests(grid_sum_table).

test(when_size_1) :-
  dict_pairs(Grid, _, ['c(1,1)'-1]),
  grid_sum_table(Grid, X, 1),
  assertion(X.get('c(1,1)') == 1),
  assertion(X == sum_table{'c(1,1)': 1}).

test(when_size_2) :-
  dict_pairs(Grid, _, ['c(1,1)'-1, 'c(2,1)'-2,
                       'c(1,2)'-3, 'c(2,2)'-4]),
  grid_sum_table(Grid, X, 2),
  assertion(X == sum_table{'c(1,1)': 1, 'c(2,1)': 3,
                           'c(1,2)': 4, 'c(2,2)': 10}).

test(when_size_2_wiki) :-
  nl,
  dict_pairs(Grid, _, ['c(1,1)'-31, 'c(2,1)'-2,
                       'c(1,2)'-12, 'c(2,2)'-26]),
  grid_sum_table(Grid, X, 2),
  assertion(X == sum_table{'c(1,1)': 31, 'c(2,1)': 33,
                           'c(1,2)': 43, 'c(2,2)': 71}).


:- end_tests(grid_sum_table).