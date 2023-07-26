#!/bin/bash

test_command() {
  local consult_stmt
  consult_stmt=""

  for file in $(ls *.test.pl); do
    consult_stmt="$consult_stmt consult('$file'),"
  done

  echo "$consult_stmt run_tests(), halt."
}

main(){
  local flag status;
  flag="$1"

  if [[ $flag == "-w" ]] || [[ $flag == "--watch" ]]; then
    while sleep 0.1; do
      ls *.pl | entr -d -c ./test.sh
      status=$?
      if [[ $status -ne 2 ]]; then
        exit $status
      fi
    done
  else
    swipl -g "$(test_command)"
  fi
}
main "$@"
