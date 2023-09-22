:- module(input_plants_rules, [input_plants_rules/3]).

:- use_module(debug).

input_plants_rules(Input, Plants, Rules) :-
  trim(Input, Trimmed),
  string_lines(Trimmed, [ Line, _ | RuleLines ]),
  line_plants(Line, Plants),
  lines_rules(RuleLines, Rules).

line_plants(Line, Plants) :-
  split_string(Line, ":", "\s\t\n", [ _, PlantsStr ]),
  string_chars(PlantsStr, PlantsChars),
  chars_plants(PlantsChars, Plants).

chars_plants(Chars, Plants) :- chars_plants(Chars, Plants, [], 0).

chars_plants([], Plants, Acc, _) :- !, reverse(Plants, Acc).

chars_plants([ '.' | Rest ], Plants, Acc, N) :-
  N1 is N + 1,
  chars_plants(Rest, Plants, Acc, N1).

chars_plants([ '#' | Rest ], Plants, Acc, N) :-
  N1 is N + 1,
  chars_plants(Rest, Plants, [ N | Acc ], N1).

lines_rules(Lines, Rules) :-
  findall(Rule, (member(Line, Lines), valid_rule(Line), line_rule(Line, Rule)), Rules).

valid_rule(Line) :- split_string(Line, ">", "\s\t\n", [ _, "#" ]).

line_rule(Line, Rule) :-
  split_string(Line, "=", "\s\t\n", [ RuleStr | _ ]),
  atom_string(Rule, RuleStr).

trim(In, Out) :- split_string(In, "", "\s\t\n", [Out]).