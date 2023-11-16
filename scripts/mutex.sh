#!/bin/bash
source ./scripts/scipt.sh

cd ../RIOT
echo compiling and testing mutex

tests_core=(mutex_order mutex_cancel mutex_unlock_and_sleep rmutex rmutex_cpp)
tests_sys=(ztimer_mutex_lock_timeout cpp11_mutex)

compile_tests core tests_core[@]
compile_tests sys tests_sys[@]

echo shell mutex
LANG=C.UTF-8 BOARD=native CFLAGS+=" -fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" LINKFLAGS+="-fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" make -C tests/sys/xtimer_rmutex_lock_timeout > /dev/null 2>&1
echo -e "t1\n t2\n t3\n t4\n t5\n"| ./../RIOT/tests/sys/xtimer_rmutex_lock_timeout/bin/native/tests_xtimer_rmutex_lock_timeout.elf > /dev/null 2>&1

LANG=C.UTF-8 BOARD=native CFLAGS+=" -fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" LINKFLAGS+="-fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" make -C tests/sys/xtimer_mutex_lock_timeout > /dev/null 2>&1
echo -e "mutex_timeout_long_unlocked\n mutex_timeout_long_locked\n mutex_timeout_long_locked_low\n mutex_timeout_short_unlocked\n mutex_timeout_short_locked\n" | ./tests/sys/xtimer_mutex_lock_timeout/bin/native/tests_xtimer_mutex_lock_timeout.elf > /dev/null 2>&1

LANG=C.UTF-8 BOARD=native CFLAGS+=" -fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" LINKFLAGS+="-fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC" make -C tests/sys/ztimer_rmutex_lock_timeout > /dev/null 2>&1
echo -e "t1\n t2\n t3\n t4\n t5\n"| ./../RIOT/tests/sys/ztimer_rmutex_lock_timeout/bin/native/tests_ztimer_rmutex_lock_timeout.elf > /dev/null 2>&1

echo results:
gcovr -r . -s -f "(.+/)?r?mutex\.(c|h)$" --html --html-details -o ../RIOT_coverage/data/mutex/complete.html > ../RIOT_coverage/data/mutex/ausgabe.txt
echo cleaning mutex

clean_multi core tests_core[@]
clean_multi sys tests_sys[@]
clean sys xtimer_mutex_lock_timeout &
clean sys xtimer_rmutex_lock_timeout &

wait
echo done mutex
