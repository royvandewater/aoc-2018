:- module(grid_sum_table, [grid_sum_table/2, grid_sum_table/3]).

:- use_module(debug).

grid_sum_table(Grid, SumTable) :- grid_sum_table(Grid, SumTable, 300).

grid_sum_table(Grid, SumTable, Size) :-
  Limit is Size + 1,
  init_sum_table(Limit, SumTable),
  grid_sum_table(Grid, Limit, c(1,1), SumTable).

grid_sum_table(_Grid, Limit, c(1, Limit), _SumTable) :- !.

grid_sum_table(Grid, Limit, c(Limit, Y), SumTable) :-
  !,
  Y1 is Y + 1,
  grid_sum_table(Grid, Limit, c(1, Y1), SumTable).

grid_sum_table(Grid, Limit, c(X, Y), SumTable) :-
  term_to_atom(c(X, Y), Key),
  grid_coord_sum_value(Grid, SumTable, c(X, Y), Value),
  X1 is X + 1,
  nb_set_dict(Key, SumTable, Value),
  grid_sum_table(Grid, Limit, c(X1, Y), SumTable).

grid_coord_sum_value(Grid, SumTable, c(X, Y), Value) :-
  X0 is X - 1,
  Y0 is Y - 1,
  grid_coord_value(Grid, c(X, Y), V0),
  grid_coord_value(SumTable, c(X, Y0), V1),
  grid_coord_value(SumTable, c(X0, Y), V2),
  grid_coord_value(SumTable, c(X0, Y0), V3),
  % debug("(~w, ~w), V0: ~w, V1: ~w, V2: ~w, V3: ~w", [X, Y, V0, V1, V2, V3]),
  Value is V0 + V1 + V2 - V3.

grid_coord_value(_Grid, c(0, _), 0) :- !.
grid_coord_value(_Grid, c(_, 0), 0) :- !.
grid_coord_value(Grid, Coord, Value) :-
  term_to_atom(Coord, Key),
  Value = Grid.get(Key).

init_sum_table(Limit, SumTable) :-
  init_sum_table_pairs(Limit, Pairs, c(1,1), [], []),
  dict_pairs(SumTable, sum_table, Pairs).

init_sum_table_pairs(Limit, Pairs, c(1, Limit), Keys, Values) :-
  !,
  pairs_keys_values(Pairs, Keys, Values).

init_sum_table_pairs(Limit, Pairs, c(Limit, Y), Keys, Values) :-
  !,
  Y1 is Y + 1,
  init_sum_table_pairs(Limit, Pairs, c(1, Y1), Keys, Values).

init_sum_table_pairs(Limit, Pairs, c(X, Y), Keys, Values) :-
  term_to_atom(c(X, Y), Key),
  X1 is X + 1,
  init_sum_table_pairs(Limit, Pairs, c(X1, Y), [ Key | Keys ], [ none | Values ]).