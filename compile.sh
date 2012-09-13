#!/bin/bash

# recibiendo la variable
POSPAR1="$1"

ext=$(echo ${1}|awk -F\. '{print $2}')

if [ ${ext} == "cpp" ]; then
  clear 
  # compile
  g++ $1 -o app
  # execute
  ./app
fi

# clear 
# compile
# g++ $1 -o app
# execute
# ./app

# http://stackoverflow.com/questions/4627701/vim-how-to-execute-automatically-execute-a-shell-command-after-saving-a-file
# :autocmd BufWritePost * !run_tests.sh <afile>
