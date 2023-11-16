#!/bin/bash
source ./scripts/scipt.sh

Output_sum() {
  cat ../Projekt/$1/ausgabe.txt | sed "s/lines: /$1;/" | sed "s/branches: //" | sed "s/% (/;/" | sed "s/ out of /;/"| sed "s/)//" | sed "s/0.0;0;0/100.0;0;0/" | tr '\n' ';'| sed 's/.$//' >> daten.txt
  echo "" >> daten.txt
}

echo Starting coverage


./scripts/mutex.sh
./scripts/sema.sh
./scripts/cond.sh
./scripts/event.sh
./scripts/evtimer.sh
./scripts/msg.sh
./scripts/threadflag.sh


echo done coverage

