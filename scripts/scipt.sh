#!/bin/bash

# Function to compile a single test
compile_test() {
  local category="$1"
  local test_name="$2"
  LANG=C.UTF-8 BOARD=native CFLAGS+=" -fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" LINKFLAGS+="-fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" make -C "tests/$category/$test_name/" > /dev/null 2>&1
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

# Function to clean a single test
clean() {
  local category="$1"
  local test_name="$2"
  LANG=C.UTF-8 BOARD=native make -C "tests/$category/$test_name/" clean > /dev/null 2>&1
  echo "Cleaned: $test_name"
}

# Function to clean multiple tests
clean_multi() {
  local category="$1"
  declare -a tests=("${!2}")
  for test_name in ${tests[@]}; do
    clean "$category" "$test_name" &
  done
}
