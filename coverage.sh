#!/bin/bash
source ./scripts/scipt.sh

Output_sum() {
  cat ../Projekt/$1/ausgabe.txt | sed "s/lines: /$1;/" | sed "s/branches: //" | sed "s/% (/;/" | sed "s/ out of /;/"| sed "s/)//" | sed "s/0.0;0;0/100.0;0;0/" | tr '\n' ';'| sed 's/.$//' >> daten.txt
  echo "" >> daten.txt
}

#create folders for results
if [ ! -d data ]; then
  echo creating data folders
  mkdir data
  mkdir data/cond
  mkdir data/event
  mkdir data/evtimer
  mkdir data/msg
  mkdir data/mutex
  mkdir data/sema
  mkdir data/threadflags
fi

echo Starting coverage

./scripts/mutex.sh
./scripts/sema.sh
./scripts/cond.sh
./scripts/event.sh
./scripts/evtimer.sh
./scripts/msg.sh
./scripts/threadflag.sh


echo done coverage

