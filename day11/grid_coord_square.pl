:- module(grid_coord_square, [grid_coord_square/3]).

:- use_module(debug).
:- use_module(power_level).

grid_coord_square(Grid, Coord, Square) :-
  coord_square_coords(Coord, SquareCoords),
  maplist(get_power(Grid), SquareCoords, PowerLevels),
  sum_list(PowerLevels, Power),
  Square = square(Power, Coord).

coord_square_coords(Coord, SquareCoords) :-
  c(X, Y) = Coord,
  Xmax is X + 2,
  Ymax is Y + 2,
  findall(c(Xc, Yc), (between(X, Xmax, Xc), between(Y, Ymax, Yc)), SquareCoords).

get_power(Grid, Coord, Power) :-
  term_to_atom(Coord, Key),
  Power = Grid.get(Key).
