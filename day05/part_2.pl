:- module(part_2, [part_2/2]).

:- use_module(part_1).


part_2(In, Out) :-
  Alphabet = [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z],

  aggregate_all(
    min(Count),
    (member(Char, Alphabet), count_simplified_without_char(In, Char, Count)),
    Out
  ).

count_simplified_without_char(In, Char, Count) :-
  re_replace(Char/gi, "", In, InWithoutChar),
  part_1(InWithoutChar, Count).



