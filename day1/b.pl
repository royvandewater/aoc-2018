#!/usr/bin/env swipl

:- initialization(main, main).

main :-
  open('input.txt', read, In),
  input_to_adjustments(In, Adjustments),
  % write("Adjustments: "), writeln(Adjustments),
  find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency),
  write("First repeated frequency: "), writeln(FirstRepeatedFrequency),
  close(In).

input_to_adjustments(In, Adjustments) :- input_to_adjustments(In, Adjustments, []).
input_to_adjustments(In, Adjustments, Acc) :-
  (read_line_to_string(In, Line),
  %  write("Line: "), writeln(Line),
   (Line = end_of_file
    -> Adjustments = Acc
    ;  (atom_number(Line, Value),
        append(Acc, [Value], NewAcc),
        input_to_adjustments(In, Adjustments, NewAcc)))).

find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency) :- find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency, [0]).
find_first_repeated_frequency([],          _FirstRepeatedFrequency, _Frequencies) :- writeln("Should be unreachable").
find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency, Frequencies) :-
  ([LastFrequency | _] = Frequencies,
   [Adjustment | Rest] = Adjustments,
   append(Rest, [Adjustment], NewAdjustments),
   Frequency is LastFrequency + Adjustment,
  %  write("Frequencies: "), writeln(Frequencies),
  %  write("Frequency: "), writeln(Frequency),
   (memberchk(Frequency, Frequencies)
    -> FirstRepeatedFrequency = Frequency
    ;  (NewFrequencies = [Frequency | Frequencies],
        find_first_repeated_frequency(NewAdjustments, FirstRepeatedFrequency, NewFrequencies)))).



% find_answer(In, Answer) :-
%   find_answer_r(In, [], Answer).

% find_answer_r(In, Acc, Answer) :-
%   (read_line_to_string(In, Line),
%    write("Acc"), writeln(Acc),
%    (Line = end_of_file
%     -> writeln("EOF, no answer found")
%     ;  (Frequency is compute_frequency()
%         memberchk(Line, Acc)
%         -> Answer = Line
%         ; (append(Acc, [Line], NewAcc),
%            find_answer_r(In, NewAcc, Answer))))).

% compute_frequency(Adjustments, Frequency) :- compute_frequency(Adjustments, Frequency, 0)
% compute_frequency([], Frequency, Acc) :- Frequency = Acc
% compute_frequency(Adjustments, Frequency, Acc) :-
%   ([Head | Rest] = Adjustments,
%    NewAcc is Acc + Head,
%    compute_frequency(Rest, Frequency, NewAcc)).


  %  ;  writeln("No EOF")).
  %  memberchk(Line, Acc)

  %  write("IsMember: "),
  %  writeln(IsMember),
  %  Answer = Line).
  %  -> (write("EOF reached: "),
  %      write(Line),
  %      Answer = "Could not find an answer")
  %  ;  (memberchk(Line, Acc)
  %      -> (Answer = Line,
  %          write("Found an answer: "),
  %          writeln(Line))
  %      ;  (append(Acc, [Line], NewAcc),
  %          find_answer_r(In, NewAcc, Answer)))).