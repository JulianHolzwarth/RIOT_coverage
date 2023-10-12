#!/bin/bash
source ./scripts/scipt.sh

cd ..
cd RIOT
echo compiling and testing

#mutex & rmutex
compile_test core mutex_order &
compile_test core mutex_cancel &
compile_test core mutex_unlock_and_sleep &
compile_test core rmutex &
compile_test core rmutex_cpp &
compile_test sys ztimer_mutex_lock_timeout &


#sema & sema_inv
compile_test sys sema &
compile_test sys sema_inv &

#cond
compile_test core cond_order &

#event
compile_test sys event_periodic_callback &
compile_test sys event_source &
compile_test sys event_wait_timeout &
compile_test sys event_wait_timeout_ztimer &
compile_test sys event_ztimer &
compile_test sys events &
compile_test sys event_thread_shared &
compile_test sys event_threads &

#evtimer
compile_test sys evtimer_msg &
compile_test sys evtimer_mbox &
compile_test sys evtimer_underflow &

#msg
compile_test core msg_avail &
compile_test core msg_queue_capacity &
compile_test core msg_queue_print &
compile_test core msg_send_receive &
compile_test core msg_try_receive &
compile_test core thread_msg &
compile_test core thread_msg_block_race &
compile_test core thread_msg_block_w_queue &
compile_test core thread_msg_block_wo_queue &
compile_test core thread_msg_bus &
compile_test core thread_msg_seq &
compile_test core thread_cooperation &
compile_test sys xtimer_msg &
compile_test sys xtimer_msg_receive_timeout &
compile_test sys ztimer_msg &
compile_test sys ztimer64_msg &

#thread flags
compile_test core thread_flags_xtimer &
compile_test core thread_flags &

wait
echo shell
compile_shell_shell3 #sys xtimer_mutex_lock_timeout
compile_shell_shell2 #sys xtimer_rmutex_lock_timeout

echo 
echo result:
gcovr -r . -s --html --html-details -o ../RIOT_coverage/data/complete.html > ../RIOT_coverage/data/ausgabe.txt



echo
echo cleaning

#mutex & rmutex
cleaning core/mutex_order &
cleaning core/mutex_cancel &
cleaning core/unlock_and_sleep &
cleaning core/rmutex &
cleaning core/rmutex_cpp &
cleaning sys/ztimer_mutex_lock_timeout_timeout &
cleaning sys/xtimer_mutex_lock_timeout &
cleaning sys/xtimer_rmutex_lock_timeout &

#sema
cleaning sys/sema &
cleaning sys/sema_inv &

#cond
cleaning core/cond_order &

#event
cleaning sys/event_periodic_callback &
cleaning sys/event_source &
cleaning sys/event_wait_timeout &
cleaning sys/event_wait_timeout_ztimer &
cleaning sys/event_ztimer &
cleaning sys/events &
cleaning sys/event_thread_shared &
cleaning sys/event_threads &

#evtimer
cleaning sys/evtimer_msg &
cleaning sys/evtimer_mbox &
cleaning sys/evtimer_underflow &


#msg
cleaning core/msg_avail &
cleaning core/msg_queue_capacity &
cleaning core/msg_print &
cleaning core/msg_send_receive &
cleaning core/msg_try_receive &
cleaning core/thread_msg &
cleaning core/thread_msg_block_race &
cleaning core/thread_msg_block_w_queue &
cleaning core/thread_msg_block_wo_queue &
cleaning core/thread_msg_bus &
cleaning core/thread_msg_seq &
cleaning core/thread_cooperation &
cleaning sys/xtimer_msg &
cleaning sys/xtimer_msg_receive_timeout &
cleaning sys/ztimer_msg &
cleaning sys/xtimer64_msg &

#thread flags
cleaning core/thread_flags_xtimer &
cleaning core/thread_flags &

wait
echo
echo done
