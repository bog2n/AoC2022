#!/bin/bash

declare -a packet

while read line; do
	packet=($(fold -w 1 <<< $line))
done

for i in `seq 0 ${#packet[@]}`; do
	a=$(tr ' ' '\n' <<< ${packet[@]:$i:4} | sort | uniq -d | wc -l)
	if [[ $a == 0 ]]; then
		echo $(($i + 4))
		break
	fi
done
