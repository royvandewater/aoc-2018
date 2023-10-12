:- use_module(next_state).
:- begin_tests(next_state).

test(broken_example_1) :-
  State = state{count: 8,
                elf1: elf{position:7,value:2},
                elf2: elf{position:7,value:2},
                mutdict: mutdict{0:3,1:7,2:0,3:1,4:0,5:1,6:1,7:2},
                sequence: [2,1,0,1,0,1,7,3]}
  next_state(State, NextState, NumAdded),
  assertion(NumAdded == 1),
  assertion(NextState.sequence == [5,4,2,1,0,1,0,1,7,3]).

test(broken_example_2) :-
  State = state{count:9,
                elf1:elf{position:1,value:7},
                elf2:elf{position:1,value:7},
                mutdict:mutdict{0:3,1:7,2:0,3:1,4:0,5:1,6:1,7:2,8:4},
                sequence:[4,2,1,0,1,0,1,7,3]},
  next_state(State, NextState, NumAdded),
  assertion(NumAdded == 1),
  assertion(NextState.sequence == [5,4,2,1,0,1,0,1,7,3]).

:- end_tests(next_state).