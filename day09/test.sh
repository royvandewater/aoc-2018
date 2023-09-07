#!/bin/bash

test_command() {
  local consult_stmt
  local files_pattern
  files_pattern="$1"
  consult_stmt=""

  if [[ -z $files_pattern ]]; then
    files_pattern="*.test.pl"
  fi

  for file in $(ls $files_pattern); do
    consult_stmt="$consult_stmt consult('$file'),"
  done

  echo "$consult_stmt run_tests(), halt."
}

main(){
  local flag files_pattern status;

  flag="$1"

  if [[ $flag == "-w" ]] || [[ $flag == "--watch" ]]; then
    files_pattern="$2"
    while sleep 0.1; do
      ls *.pl | entr -d -c ./test.sh "$files_pattern"
      status=$?
      if [[ $status -ne 2 ]]; then
        exit $status
      fi
    done
  else
    files_pattern="$1"
    swipl -g "$(test_command "$files_pattern")"
  fi
}
main "$@"
