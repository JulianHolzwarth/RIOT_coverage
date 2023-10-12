#!/bin/bash
source ./scripts/scipt.sh

cd ../RIOT
echo compiling and testing msg

tests_core=(msg_avail msg_queue_capacity msg_queue_print msg_send_receive msg_try_receive thread_msg thread_msg_block_race thread_msg_block_w_queue thread_msg_block_wo_queue thread_msg_bus thread_msg_seq thread_cooperation)
tests_sys=(xtimer_msg xtimer_msg_receive_timeout ztimer_msg ztimer64_msg)

compile_tests core tests_core[@]
compile_tests sys tests_sys[@]

wait
echo results:
gcovr -r . -s -f "(.+/)?msg\.(c|h)$" --html --html-details -o ../RIOT_coverage/data/msg/complete.html > ../RIOT_coverage/data/msg/ausgabe.txt

echo cleaning msg

clean_multi core tests_core[@]
clean_multi sys tests_sys[@]

wait
echo done msg