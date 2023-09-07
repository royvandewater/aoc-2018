:- use_module(input_points).

:- begin_tests(input_points).

test(when_empty) :-
  input_points("", X),
  assertion(X == []).

test(when_one_point) :-
  input_points("position=<     0,      1> velocity=< 5,  1 >", X),
  assertion(X == [point{position: vector(0, 1), velocity: vector(5, 1)}]).

test(when_two_points) :-
  input_points("
    position=<-53868, -10684> velocity=< 5,  1>
    position=<-43043, -43128> velocity=< 4,  4>
  ", X),
  assertion(X == [
    point{position: vector(-53868, -10684), velocity: vector(5, 1)},
    point{position: vector(-43043, -43128), velocity: vector(4, 4)}
  ]).

:- end_tests(input_points).