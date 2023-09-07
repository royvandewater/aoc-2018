:- use_module(part_1).

:- begin_tests(part_1).

test(part_1_when_empty, fail) :-
  part_1([], _).

test(part_1_when_one_coordinate_boxed_in, true(X == 1)) :-
  part_1([
    coordinate(1, 0), % top
    coordinate(1, 2), % bottom
    coordinate(0, 1), % left
    coordinate(2, 1), % right
    coordinate(1, 1)  % boxed in
  ], X).

test(part_1_when_one_coordinate_boxed_in_more_room, true(X == 9)) :-
  part_1([
    coordinate(0, 0), % top left
    coordinate(3, 0), % top center             % AabBbcC
    coordinate(6, 0), % top right              % aabbbcc
    coordinate(0, 3), % middle left            % ddxxxee
    coordinate(3, 3), % boxed in <-- target    % DdxXxeE <- X is the only one boxed in and has 9 positions
    coordinate(6, 3), % middle right           % ddxxxee
    coordinate(0, 6), % bottom left            % ffggghh
    coordinate(3, 6), % bottom center          % FfgGghH
    coordinate(6, 6)  % bottom right
  ], X).

test(part_1_example_1, true(X == 17)) :-
  part_1([
    coordinate(1, 1),
    coordinate(1, 6),
    coordinate(8, 3),
    coordinate(3, 4),
    coordinate(5, 5),
    coordinate(8, 9)
  ], X).

:- end_tests(part_1).

