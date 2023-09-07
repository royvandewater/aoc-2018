#!/usr/bin/env swipl

:- initialization(main, main).


main(Argv) :-
  [Filename | _] = Argv,
  open(Filename, read, In),
  input_to_adjustments(In, Adjustments),
  find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency),
  write("First repeated frequency: "), writeln(FirstRepeatedFrequency),
  close(In).

% Overload input_to_adjustments to provide the initialization value for the Accumulator (Acc)
input_to_adjustments(In, Adjustments) :- input_to_adjustments(In, Adjustments, []).
input_to_adjustments(In, Adjustments, Acc) :-
  (read_line_to_string(In, Line),
   % IF the line we just read is the EOF char
   (Line = end_of_file
    % THEN our Accumulator contains our entire list of Adjustments
    -> Adjustments = Acc
    % ELSE % convert the line into a number
    ;  (atom_number(Line, Value),
        % append it to the list of adjustments
        append(Acc, [Value], NewAcc),
        % and recurse
        input_to_adjustments(In, Adjustments, NewAcc)))).

find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency) :- find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency, [0]).
find_first_repeated_frequency(Adjustments, FirstRepeatedFrequency, Frequencies) :-
  % The head of Frequencies is always the most recently visited frequency
  ([LastFrequency | _] = Frequencies,
   % Grab the first adjustment
   [Adjustment | OtherAdjustments] = Adjustments,
   % calculate the new frequency by applying the adjustment to the last frequency
   Frequency is LastFrequency + Adjustment,

   % IF we've already seen this frequency
   (memberchk(Frequency, Frequencies)
    % THEN this is the first repeated frequency
    -> FirstRepeatedFrequency = Frequency
    % ELSE
    % add this frequency to the head of the list of known frequencies
    ;  (NewFrequencies = [Frequency | Frequencies],
        % push our current Adjustement to the end of the list of Other Adjustments, treating it like
        % a ring buffer so that we can keep processing them indefinitely
        append(OtherAdjustments, [Adjustment], NewAdjustments),
        % and recurse
        find_first_repeated_frequency(NewAdjustments, FirstRepeatedFrequency, NewFrequencies)))).

