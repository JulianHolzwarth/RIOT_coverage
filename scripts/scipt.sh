#!/bin/bash

# Function to compile a single test
compile_test() {
  local category="$1"
  local test_name="$2"
  LANG=C.UTF-8 BOARD=native make -C "tests/$category/$test_name/" > /dev/null 2>&1
  echo s | "./tests/$category/$test_name/bin/native/tests_$test_name.elf" > /dev/null 2>&1 &
  pid=$!
  sleep 10
  kill -SIGINT $pid
  echo "Compiled and tested: $test_name"
}

# Function to compile multiple tests
compile_tests() {
  local category="$1"
  declare -a tests=("${!2}")
  for test_name in ${tests[@]}; do
    compile_test "$category" "$test_name" &
  done
}

cleaning() {
  LANG=C.UTF-8 BOARD=native make -C tests/$1/ clean > /dev/null 2>&1
}

# Function to clean a single test
clean() {
  LANG=C.UTF-8 BOARD=native make -C tests/$1/$2/ clean > /dev/null 2>&1
}

# Function to clean multiple tests
clean_multi() {
  declare -a tests=("${!2}")
  for i in ${!tests[@]}; do
    clean $1 ${tests[$i]} &
  done
}
