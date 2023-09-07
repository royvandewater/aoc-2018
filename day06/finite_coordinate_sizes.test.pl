:- use_module(finite_coordinate_sizes).

:- begin_tests(finite_coordinate_sizes).

test(finite_coordinate_sizes_when_empty, true(X == [])) :-
  finite_coordinate_sizes([], [], X).

test(finite_coordinate_sizes_when_boxed_in, true(X == [1])) :-
  finite_coordinate_sizes(
    [
      coordinate(1, 0), % top
      coordinate(1, 2), % bottom
      coordinate(0, 1), % left
      coordinate(2, 1), % right
      coordinate(1, 1)  % boxed in
    ],
    [coordinate(1, 1)],
    X
  ).

test(finite_coordinate_sizes_when_one_coordinate_boxed_in_more_room, true(X == [9])) :-
  finite_coordinate_sizes(
    [
      coordinate(0, 0), % top left
      coordinate(3, 0), % top center             % AabBbcC
      coordinate(6, 0), % top right              % aabbbcc
      coordinate(0, 3), % middle left            % ddxxxee
      coordinate(3, 3), % boxed in <-- target    % DdxXxeE <- X is the only one boxed in and has 9 positions
      coordinate(6, 3), % middle right           % ddxxxee
      coordinate(0, 6), % bottom left            % ffggghh
      coordinate(3, 6), % bottom center          % FfgGghH
      coordinate(6, 6)  % bottom right
    ],
    [coordinate(3, 3)],
    X
  ).

:- end_tests(finite_coordinate_sizes).