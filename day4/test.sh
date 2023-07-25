#!/bin/bash

test_command() {
  local consult_stmt
  consult_stmt=""

  for file in $(ls *.pl); do
    consult_stmt="$consult_stmt consult('$file'),"
  done

  echo "$consult_stmt run_tests(), halt."
}

main(){
  local flag;
  flag="$1"

  if [[ $flag == "-w" ]] || [[ $flag == "--watch" ]]; then
    echo "watching..."
    ls | entr -c swipl -g "$(test_command)"
  else
    swipl -g "$(test_command)"
  fi
}
main "$@"
