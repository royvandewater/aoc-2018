:- module(part_2, [part_2/3]).

:- use_module(apply_rules_n_times).

part_2(Plants, Rules, Answer) :-
  % I ended up plugging every value 0 - 200 into Google Sheets, found that
  % the progression stabilized into a linear increase of 46 per generation after
  % generation 104. I then was able to do: `((5Billion - 104) * 46) + ValueAtGen104`
  % to compute the answer. I had an off by one error, so I did 5BillionMinus1 instead and
  % it got the correct answer of 2300000000006
  apply_rules_n_times(Plants, Rules, 2000, NthPlants),
  sum_list(NthPlants, Answer).
