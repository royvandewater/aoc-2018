:- module(serial_grid, [serial_grid/2]).

:- use_module(debug).
:- use_module(power_level).

serial_grid(Serial, Grid) :-
  serial_pairs(Serial, Pairs, c(1, 1), [], []),
  dict_pairs(Grid, _, Pairs).

serial_pairs(_Serial, Pairs, c(X, Y), Keys, Values) :-
  X > 300,
  Y > 299,
  !,
  pairs_keys_values(Pairs, Keys, Values).

serial_pairs(Serial, Pairs, c(X, Y), Keys, Values) :-
  X > 300,
  !,
  Y1 is Y + 1,
  serial_pairs(Serial, Pairs, c(0, Y1), Keys, Values).

serial_pairs(Serial, Pairs, c(X, Y), Keys, Values) :-
  term_to_atom(c(X, Y), Key),
  power_level(Serial, c(X, Y), Value),
  X1 is X + 1,
  serial_pairs(Serial, Pairs, c(X1, Y), [ Key | Keys ], [ Value | Values ]).
