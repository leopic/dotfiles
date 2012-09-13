#!/bin/bash

# recibiendo la variable
POSPAR1="$1"

# parseando la extension
ext=$(echo ${1}|awk -F\. '{print $2}')

# si la extension es cpp
if [ ${ext} == "cpp" ]; then
  clear
  # compile
  g++ $1 -o app
  # execute
  ./app
fi

# enjoy
