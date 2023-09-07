:- module(generate_scores, [generate_scores/2]).

generate_scores(N, Scores) :- generate_scores(N, Scores, []).
generate_scores(0, Scores, Scores) :- !.
generate_scores(N, Scores, Acc) :-
  N1 is N - 1,
  generate_scores(N1, Scores, [ 0 | Acc ]).