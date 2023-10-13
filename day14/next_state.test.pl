:- use_module(next_state).
:- begin_tests(next_state).

test(broken_step_1) :-
  State = state{ elf1: elf{position:0,value:3},
                 elf2: elf{position:1,value:7},
                 count: 2,
                 sequence: [7,3],
                 mutdict: mutdict{}.upsert_reverse_sequence([7,3]) },
  next_state(State, NextState, _),
  assertion(NextState.elf1 == elf{position:0,value:3}),
  assertion(NextState.elf2 == elf{position:1,value:7}),
  assertion(NextState.mutdict.sequence() == [0,1,7,3]).

test(broken_step_2) :-
  State = state{ elf1: elf{position:0,value:3},
                 elf2: elf{position:1,value:7},
                 count: 4,
                 sequence: [0,1,7,3],
                 mutdict: mutdict{}.upsert_reverse_sequence([0,1,7,3]) },
  next_state(State, NextState, _),
  assertion(NextState.elf1 == elf{position:4,value:1}),
  assertion(NextState.elf2 == elf{position:3,value:0}),
  assertion(NextState.mutdict.sequence() == [0,1,0,1,7,3]).

% State: state{elf1:elf{position:0,value:3},elf2:elf{position:1,value:7},sequence:[0,1,7,3]}
% NextState: state{elf1:elf{position:4,value:1},elf2:elf{position:3,value:0},sequence:[0,1,0,1,7,3]}

% test(broken_example_1) :-
%   State = state{count: 8,
%                 elf1: elf{position:7,value:2},
%                 elf2: elf{position:7,value:2},
%                 mutdict: mutdict{0:3,1:7,2:0,3:1,4:0,5:1,6:1,7:2},
%                 sequence: [2,1,0,1,0,1,7,3]},
%   next_state(State, NextState, NumAdded),
%   assertion(NumAdded == 1),
%   assertion(NextState.mutdict.sequence() == [5,4,2,1,0,1,0,1,7,3]).

% test(broken_example_2) :-
%   State = state{count:9,
%                 elf1:elf{position:1,value:7},
%                 elf2:elf{position:1,value:7},
%                 mutdict:mutdict{0:3,1:7,2:0,3:1,4:0,5:1,6:1,7:2,8:4},
%                 sequence:[4,2,1,0,1,0,1,7,3]},
%   next_state(State, NextState, NumAdded),
%   assertion(NumAdded == 1),
%   assertion(NextState.mutdict.sequence() == [5,4,2,1,0,1,0,1,7,3]).


% State: state{elf1:elf{position:4,value:1},elf2:elf{position:3,value:0},sequence:[0,1,0,1,7,3]}
% NextState: state{elf1:elf{position:6,value:1},elf2:elf{position:4,value:1},sequence:[1,0,1,0,1,7,3]}
% State: state{elf1:elf{position:6,value:1},elf2:elf{position:4,value:1},sequence:[1,0,1,0,1,7,3]}
% NextState: state{elf1:elf{position:0,value:3},elf2:elf{position:6,value:1},sequence:[2,1,0,1,0,1,7,3]}
% State: state{elf1:elf{position:0,value:3},elf2:elf{position:6,value:1},sequence:[2,1,0,1,0,1,7,3]}
% NextState: state{elf1:elf{position:4,value:1},elf2:elf{position:8,value:4},sequence:[4,2,1,0,1,0,1,7,3]}
% State: state{elf1:elf{position:4,value:1},elf2:elf{position:8,value:4},sequence:[4,2,1,0,1,0,1,7,3]}
% NextState: state{elf1:elf{position:6,value:1},elf2:elf{position:3,value:0},sequence:[5,4,2,1,0,1,0,1,7,3]}

:- end_tests(next_state).