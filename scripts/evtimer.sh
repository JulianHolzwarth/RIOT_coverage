source ./scripts/scipt.sh

cd ../RIOT
echo compiling and testing evtimer

tests=(evtimer_msg evtimer_mbox evtimer_underflow)

compile_tests sys tests[@]

wait
echo results:
gcovr -r . -s -f "(.+/)?evtimer/(.+/)?"  --html --html-details -o ../RIOT_coverage/data/evtimer/complete.html > ../RIOT_coverage/data/evtimer/ausgabe.txt

echo cleaning evtimer

clean_multi sys tests[@]

wait
echo done evtimer

