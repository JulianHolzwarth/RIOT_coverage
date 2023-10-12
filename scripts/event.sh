#!/bin/bash
source ./scripts/scipt.sh

cd ../RIOT
echo compiling and testing event

tests=(event_periodic_callback event_source event_wait_timeout event_wait_timeout_ztimer event_ztimer events event_thread_shared event_threads)

compile_tests sys tests[@]

wait
echo results:
gcovr -r . -s -f "(.+/)?event/(.+/)?"  --html --html-details -o ../RIOT_coverage/data/event/complete.html > ../RIOT_coverage/data/event/ausgabe.txt

echo cleaning event

clean_multi sys tests[@]

wait
echo done event
