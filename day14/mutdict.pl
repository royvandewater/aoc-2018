:- module(mutdict, []).

:- use_module(debug).

M.retrieve(Key) := Value :-
  V = M.get(Key),
  V \= none,
  Value = V.

M.insert(Key, Value) := MutDict :-
  _ = M.get(Key),
  !,
  b_set_dict(Key, M, Value),
  MutDict = M.

M.insert(Key, Value) := MutDict :-
  dict_pairs(M, mutdict, Pairs),
  gen_pairs(Key, NewPairs),
  append(NewPairs, Pairs, CombinedPairs),
  dict_pairs(NewDict, mutdict, CombinedPairs),
  MutDict = NewDict.insert(Key, Value).

M.insert_all(_, []) := MutDict :-
  !,
  MutDict = M.

M.insert_all(Key, [ Value | Rest ]) := MutDict :-
  NextKey is Key + 1,
  MutDict = M.insert(Key, Value)
             .insert_all(NextKey, Rest).

gen_pairs(Key, Pairs) :-
  Max is Key + 0,
  findall(K, between(Key, Max, K), Keys),
  maplist(to_none, Keys, Values),
  pairs_keys_values(Pairs, Keys, Values).

to_none(_, none).

