:- module(minute_with_max_count, [minute_with_max_count/2]).

minute_with_max_count(MinuteNapCounts, MinuteCount) :-
  [ Head | Rest ] = MinuteNapCounts,
  minute_with_max_count(Rest, MinuteCount, Head).

minute_with_max_count([], MinuteCount, Acc) :- !, MinuteCount = Acc.
minute_with_max_count(MinuteNapCounts, MinuteCount, Acc) :-
  [ Head | Rest ] = MinuteNapCounts,
  [ _, HeadCount ] = Head,
  [ _, AccCount ] = Acc,
  (HeadCount > AccCount
   -> minute_with_max_count(Rest, MinuteCount, Head)
   ;  minute_with_max_count(Rest, MinuteCount, Acc)).