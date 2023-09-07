:- module(stream_steps, [stream_steps/2]).

:- use_module(stream_instructions).
:- use_module(instructions_steps).

stream_steps(Stream, Steps) :-
  stream_instructions(Stream, Instructions),
  instructions_steps(Instructions, Steps).