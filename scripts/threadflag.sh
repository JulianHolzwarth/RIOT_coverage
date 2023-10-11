source ./scripts/scipt.sh

cd ../RIOT
echo compiling and testing threadflags

tests=(thread_flags_xtimer thread_flags)

compile_tests core tests[@]

wait
echo results:
gcovr -r . -s -f "(.+/)?thread_flags\.(c|h)$" --html --html-details -o ../RIOT_coverage/data/threadflags/complete.html > ../RIOT_coverage/data/threadflags/ausgabe.txt

echo cleaning threadflags

clean_multi core tests[@]

echo done threadflags
