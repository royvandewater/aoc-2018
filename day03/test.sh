#!/bin/bash

TEST_COMMAND="consult('solution.pl'), run_tests(), halt."

main(){
  local flag;
  flag="$1"


  if [[ $flag == "-w" ]] || [[ $flag == "--watch" ]]; then
    echo "watching..."
    ls | entr -c swipl -g "$TEST_COMMAND"
  else
    swipl -g "$TEST_COMMAND"
  fi
}
main "$@"
