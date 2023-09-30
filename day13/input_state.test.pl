:- use_module(input_state).

:- begin_tests(input_state).

test(one_cart_east) :-
  input_state(">", X),
  assertion(X.carts == [ cart{coord: c(0, 0), facing: east, last_decision: right} ]).

% test(one_cart_south) :-
%   input_state("v", X),
%   assertion(X.carts == [ cart{coord: c(0, 0), facing: south, last_decision: right} ]).

% test(one_cart_west) :-
%   input_state("<", X),
%   assertion(X.carts == [ cart{coord: c(0, 0), facing: west, last_decision: right} ]).

% test(one_cart_north) :-
%   input_state("^", X),
%   assertion(X.carts == [ cart{coord: c(0, 0), facing: north, last_decision: right} ]).

% test(one_cart_further_east) :-
%   input_state("->", X),
%   assertion(X.carts == [ cart{coord: c(1, 0), facing: east, last_decision: right} ]).

% test(two_carts_east_west) :-
%   input_state("><", X),
%   assertion(X.carts == [ cart{coord: c(0, 0), facing: east, last_decision: right},
%                          cart{coord: c(1, 0), facing: west, last_decision: right} ]).

% test(two_carts_south_north) :-
%   input_state("\
% v
% ^", X),

%   assertion(X.carts == [ cart{coord: c(0, 0), facing: south, last_decision: right},
%                          cart{coord: c(0, 1), facing: north, last_decision: right} ]).


% test(one_corner_wn_es) :- % west-north & east-south
%   input_state("/", X),
%   assertion(X.turns.get_turn(c(0,0)) == corner_wn_es).

% test(one_corner_ws_en) :- % west-south & east-north
%   input_state("\\", X),
%   assertion(X.turns.get_turn(c(0,0)) == corner_ws_en).

% test(one_corner_ws_en_alternate) :- % for writing easier test cases
%   input_state("O", X),
%   assertion(X.turns.get_turn(c(0,0)) == corner_ws_en).

% test(one_intersection) :-
%   input_state("+", X),
%   assertion(X.turns.get_turn(c(0,0)) == intersection).

:- end_tests(input_state).
