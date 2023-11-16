#!/bin/bash
source ./scripts/scipt.sh

cd ../RIOT
echo compiling and testing sema

tests=(sema sema_inv)

compile_tests sys tests[@]

echo results:
gcovr -r . -s -f "(.+/)?sema(_inv)?\.(c|h)$" --html --html-details -o ../RIOT_coverage/data/sema/complete.html > ../RIOT_coverage/data/sema/ausgabe.txt

echo cleaning sema

clean_multi sys tests[@]

echo done sema
