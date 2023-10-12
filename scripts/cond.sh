#!/bin/bash
source ./scripts/scipt.sh

cd ../RIOT
echo compiling and testing cond

tests=(cond_order)

compile_tests core tests[@]

wait
echo results:
gcovr -r . -s -f "(.+/)?cond\.(c|h)$" --html --html-details -o ../RIOT_coverage/data/cond/complete.html > ../RIOT_coverage/data/cond/ausgabe.txt

echo cleaning cond

clean_multi core tests[@]

wait
echo done cond
