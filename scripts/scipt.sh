
compile_test() {
  LANG=C.UTF-8 BOARD=native make -C tests/$1/$2/ > /dev/null 2>&1
  #LANG=C.UTF-8 BOARD=native make -C tests/$1/ test > /dev/null 2>&1
  echo s | ./tests/$1/$2/bin/native/tests_$2.elf > /dev/null 2>&1 &
  pid=$!
  sleep 10
  kill -SIGINT $pid
  echo $2
}

compile_tests() {
  declare -a tests=("${!2}")
  for i in ${!tests[@]}; do
    compile_test $1 ${tests[$i]} &
  done
}

cleaning() {
  LANG=C.UTF-8 BOARD=native make -C tests/$1/ clean > /dev/null 2>&1
}

clean() {
  LANG=C.UTF-8 BOARD=native make -C tests/$1/$2/ clean > /dev/null 2>&1
}

clean_multi() {
  declare -a tests=("${!2}")
  for i in ${!tests[@]}; do
    clean $1 ${tests[$i]} &
  done
}

#ps -aux | grep .elf | awk '{print $2}' | kill -9
#cat ausgabe.txt | sed "s/.*: //" |sed "s/%.*(/;/" | sed "s/ out of /;/"| sed "s/)/;/" | tr '\n' ' '
