#!/usr/bin/env swipl

:- initialization(main, main).

main :-
  open('input.txt', read, In),
  compute_frequency(In, Frequency),
  write("Answer: "), writeln(Frequency),
  close(In).

compute_frequency(In, Frequency) :-
  compute_frequency_r(In, 0, Frequency).

compute_frequency_r(In, Acc, Frequency) :-
  (  read_line_to_string(In, Line),
     atom_number(Line, Value),
     NewAcc is Acc + Value,

     Line \= end_of_file
     -> compute_frequency_r(In, NewAcc, Frequency)
     ;  Frequency = Acc).