:- module(positions_string, [positions_string/2]).

:- use_module(bounds_coords).
:- use_module(debug).

positions_string([], "") :- !.

positions_string(Positions, OutStr) :-
  positions_bounds(Positions, [Xmin, Xmax, _, _]),
  NumCols is Xmax - Xmin,
  NumCols > 100,
  !,
  format_string("More than 100 columns (~w), skipping", [NumCols], OutStr).

positions_string(Positions, OutStr) :-
  positions_bounds(Positions, [_, _, Ymin, Ymax]),
  NumRows is Ymax - Ymin,
  NumRows > 100,
  !,
  format_string("More than 100 rows (~w), skipping", [NumRows], OutStr).

positions_string(Positions, OutStr) :-
  positions_bounds(Positions, Bounds),
  positions_dict(Positions, Dict),
  bounds_coords(Bounds, Coords),
  maplist(format_row(Dict), Coords, Rows),
  atomics_to_string(Rows, '\n', OutStr).

format_row(Dict, Row, Out) :-
  maplist(format_point(Dict), Row, Chars),
  string_chars(Out, Chars).

positions_bounds(Positions, [Xmin, Xmax, Ymin, Ymax]) :-
  maplist(position_x, Positions, Xs),
  min_list(Xs, Xmin),
  max_list(Xs, Xmax),
  maplist(position_y, Positions, Ys),
  min_list(Ys, Ymin),
  max_list(Ys, Ymax).

position_x(vector(X, _), X).
position_y(vector(_, Y), Y).

format_point(Dict, Coord, Pixel) :-
  position_key(Coord, Key),
  Dict.get(Key)
  -> Pixel = '#'
  ;  Pixel = '.'.

positions_dict(Positions, Dict) :- positions_dict(Positions, Dict, positions{}).
positions_dict([], Dict, Dict) :- !.
positions_dict([ Position | Rest ], Dict, Acc) :-
  position_key(Position, Key),
  positions_dict(Rest, Dict, Acc.put(Key, true)).

position_key(Position, Key) :-
  vector(X, Y) = Position,
  format_string("~w,~w", [X, Y], String),
  atom_string(Key, String).

format_string(Format, Data, String) :- with_output_to(string(String), format(Format, Data)).