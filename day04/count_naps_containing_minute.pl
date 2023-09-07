:- module(count_naps_containing_minute, [count_naps_containing_minute/3]).

count_naps_containing_minute(Naps, Minute, Count) :- count_naps_containing_minute(Naps, Minute, Count, 0).
count_naps_containing_minute([], _, Count, Acc) :- !, Count = Acc.
count_naps_containing_minute(Naps, Minute, Count, Acc) :-
  [ Nap | Rest ] = Naps,
  [ Low, High ] = Nap,
  (between_non_inclusive_high(Low, High, Minute)
   -> (NewAcc is Acc + 1, count_naps_containing_minute(Rest, Minute, Count, NewAcc))
   ;  count_naps_containing_minute(Rest, Minute, Count, Acc)).

between_non_inclusive_high(Low, High, Value) :-
  between(Low, High, Value),
  Value \= High.
