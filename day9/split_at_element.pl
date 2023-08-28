:- module(split_at_element, [split_at_element/4]).

split_at_element(Element, List, FirstN, Rest) :-
  append(FirstN,[ Element | Tail ], List),
  Rest = [ Element | Tail ], !.