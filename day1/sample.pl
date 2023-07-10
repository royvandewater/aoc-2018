magicNumber(7).
magicNumber(9).
magicNumber(42).

nearby(X, Y) :- X = Y, !.
nearby(X, Y) :- X is Y + 1, !.
nearby(X, Y) :- X is Y - 1.

nearbychk(X,Y) :- X = Y, !.
nearbychk(X,Y) :- Y is X+1, !.
nearbychk(X,Y) :- Y is X-1.

nearby2(X,Y) :- nonvar(X), X = Y.
nearby2(X,Y) :- nonvar(X), Y is X+1.
nearby2(X,Y) :- nonvar(X), Y is X-1.
nearby2(X,Y) :- var(X), nonvar(Y), nearby2(Y,X).


countTo(X) :- countUpTo(1,X).
countUpTo(Value, Limit) :- Value = Limit, writeln(Value), !.
countUpTo(Value, Limit) :- Value \= Limit, writeln(Value),
    NextValue is Value+1,
    countUpTo(NextValue, Limit).
