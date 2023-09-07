:- module(state, []).

S.current() := Current :- atom_number(S.board.current, Current).