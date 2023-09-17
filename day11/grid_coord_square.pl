:- module(grid_coord_square, [grid_coord_square/4]).

:- use_module(debug).
:- use_module(power_level).

grid_coord_square(Grid, Size, Coord, Square) :-
  coord_square_coords(Coord, Size, SquareCoords),
  maplist(get_power(Grid), SquareCoords, PowerLevels),
  sum_list(PowerLevels, Power),
  Square = square(Power, Coord, Size).

coord_square_coords(Coord, Size, SquareCoords) :-
  c(X, Y) = Coord,
  Xmax is X + Size - 1, % - 1 because between is inclusive
  Ymax is Y + Size - 1,
  findall(c(Xc, Yc), (between(X, Xmax, Xc), between(Y, Ymax, Yc)), SquareCoords).

get_power(Grid, Coord, Power) :-
  term_to_atom(Coord, Key),
  Power = Grid.get(Key).
