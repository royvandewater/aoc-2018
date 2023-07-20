#!/usr/bin/env swipl

:- initialization(main, main).

% A = 1, B = 2, X = 3, format('A: ~d, B: ~d, X: ~d', [A, B, X]), nl.

% main() :- main("input.txt").
main(Argv) :-
  [Filename | _] = Argv,
  open(Filename, read, In),
  input_to_list(In, List),
  list_claims(List, Claims),
  number_of_overlapping_pixels(Claims, Count),
  log("Count", Count),
  close(In).

log(Label, Value) :- write(Label), write(": "), writeln(Value).

input_to_list(In, List) :- input_to_list(In, List, []).
input_to_list(In, List, Acc) :-
  (read_line_to_string(In, Line),
   (Line = end_of_file
    -> List = Acc
    ; (append(Acc, [Line], NewAcc),
    input_to_list(In, List, NewAcc)))).

list_claims(List, Claims) :- list_claims(List, Claims, []).
list_claims([], Claims, Acc) :- Claims = Acc.
list_claims(List, Claims, Acc) :-
  [ Head | Rest ] = List,
  split_string(Head, " ", "", Parts),
  [ IdStr, _, CoordsStr, DimensionsStr ] = Parts,
  str_id(IdStr, Id),
  str_coords(CoordsStr, Coords),
  str_dimensions(DimensionsStr, Dimensions),
  Claim = [Id, Coords, Dimensions],
  append(Acc, [Claim], NewAcc),
  list_claims(Rest, Claims, NewAcc).


str_id(Str, Id) :-
  trim(Str, "#", IdStr),
  atom_number(IdStr, Id).

str_coords(CoordsStr, Coords) :-
  split_string(CoordsStr, ",", ":", [LeftStr, TopStr]),
  atom_number(LeftStr, Left),
  atom_number(TopStr, Top),
  Coords = [Left, Top].

str_dimensions(DimensionsStr, Dimensions) :-
  split_string(DimensionsStr, "x", "", [WidthStr, HeightStr]),
  atom_number(WidthStr, Width),
  atom_number(HeightStr, Height),
  Dimensions = [Width, Height].


% Chars is a string containing all the characters to remove from the leading
% and trailing edge.We split on a char that isn't in the string, then use the pad argument to
% get it to strip the leading "#". Not ideal, but whatevs
trim(Str, Chars, Trimmed) :- split_string(Str, "\0", Chars, [ Trimmed | _ ]).

number_of_overlapping_pixels([], 0) :- true, !.
number_of_overlapping_pixels(Claims, Count) :-
  aggregate_all(
    count,
    Pixel,
    (
      member([Id1 | Box1], Claims),
      member([Id2 | Box2], Claims),
      Id1 < Id2,
      Id1 \= Id2,
      pixel_in_boxes(Pixel, Box1, Box2)
    ),
    Count
  ).

number_overlapping_on_two_boxes(Box1, Box2, Count) :-
  aggregate_all(
    count,
    Pixel,
    pixel_in_boxes(Pixel, Box1, Box2),
    Count
  ).

% [Xa, Ya] is the top left coordinate
% [Xb, Yb] is the bottom right coordinate
bounding_box([Position, Dimensions], [[Xa, Ya], [Xb, Yb]]) :-
  [Width, Height] = Dimensions,
  [Xa, Ya] = Position,
  Xb is Xa + Width,
  Yb is Ya + Height.

between_non_inclusive_high(Low, High, Value) :-
  between(Low, High, Value),
  Value \= High.

% Enumerates the pixels that fall within the box
pixel_in_box(_, [_, [0, 0]]) :- false.
pixel_in_box(Pixel, Box) :-
  [X, Y] = Pixel,
  bounding_box(Box, [[Xa, Ya], [Xb, Yb]]),
  Xmin is min(Xa, Xb),
  Xmax is max(Xa, Xb),
  Ymin is min(Ya, Yb),
  Ymax is max(Ya, Yb),
  between_non_inclusive_high(Xmin, Xmax, X),
  between_non_inclusive_high(Ymin, Ymax, Y).

% Enumerate pixels that fall in both boxes
pixel_in_boxes(Pixel, Box1, Box2) :-
  pixel_in_box(Pixel, Box1),
  pixel_in_box(Pixel, Box2).

:- begin_tests(pixel_in_box).

test(pixel_in_box_when_empty, [fail]) :-
  pixel_in_box(_Pixel, [[0, 0], [0, 0]]).

test(pixel_in_box_when_one_pixel, all(X == [[0, 0]])) :-
  pixel_in_box(X, [[0, 0], [1, 1]]).

test(pixel_in_box_when_one_pixel, all(X == [[0, 0], [0, 1], [1, 0], [1, 1]])) :-
  pixel_in_box(X, [[0, 0], [2, 2]]).

:- end_tests(pixel_in_box).

:- begin_tests(number_of_overlapping_pixels).

test(number_of_overlapping_pixels_when_empty, true(X == 0)) :-
  number_of_overlapping_pixels([], X).

test(number_of_overlapping_pixels_when_no_overlap, true(X == 0)) :-
  number_of_overlapping_pixels([
    [1, [1, 1], [1, 1]],
    [2, [2, 2], [1, 1]]
  ], X).

test(number_of_overlapping_pixels_when_total_overlap, true(X == 1)) :-
  number_of_overlapping_pixels([
    [1, [1, 1], [1, 1]],
    [2, [1, 1], [1, 1]]
  ], X).

test(number_of_overlapping_pixels_when_partial_overlap, true(X == 1)) :-
  number_of_overlapping_pixels([
    [1, [0, 0], [3, 3]],
    [2, [1, 1], [1, 1]]
  ], X).

test(number_of_overlapping_pixels_when_more_than_one_pixel_of_overlap, true(X == 4)) :-
  number_of_overlapping_pixels([
    [1, [0, 0], [3, 3]],
    [2, [1, 1], [2, 2]]
  ], X).

test(number_of_overlapping_pixels_when_three_boxes, true(X == 2)) :-
  number_of_overlapping_pixels([
    [1, [0, 0], [2, 2]],
    [2, [0, 0], [1, 1]],
    [3, [1, 1], [1, 1]]
  ], X).

test(number_of_overlapping_pixels_when_pixel_overlapped_thrice, true(X == 1)) :-
  number_of_overlapping_pixels([
    [1, [0, 0], [2, 2]],
    [2, [0, 0], [1, 1]],
    [3, [0, 0], [1, 1]]
  ], X).

:- end_tests(number_of_overlapping_pixels).

:- begin_tests(list_claims).

test(list_claims_when_empty) :-
  list_claims([], []).

test(list_claims_when_one_claim, true(X == [[1, [1,3], [4, 4]]])) :-
  list_claims(["#1 @ 1,3: 4x4"], X).

test(list_claims_when_one_different_claim, true(X==[[2, [3,1], [5, 6]]])) :-
  list_claims(["#2 @ 3,1: 5x6"], X).

test(list_claims_when_two_claims, true(X==[[1, [1,3], [4, 4]], [2, [3,1], [5, 6]]])) :-
  list_claims(["#1 @ 1,3: 4x4", "#2 @ 3,1: 5x6"], X).

:- end_tests(list_claims).
