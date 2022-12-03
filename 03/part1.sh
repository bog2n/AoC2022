#!/bin/bash

# 0x41 - 0x5A - Uppercase
# 0x61 - 0x71 - Lowercase

sum=0
while read line; do
	priority=0
	l=$(((`echo $line | wc -c`-1)/2))
	p1=`echo $line | fold -w $l | head -1 | fold -w 1 | sort | uniq | tr -d '\n'`
	p2=`echo $line | fold -w $l | tail -1 | fold -w 1 | sort | uniq | tr -d '\n'`
	item=`(echo $p1; echo $p2) | fold -w 1 | sort | uniq -d | tr -d '\n'`
	priority=$((`echo -n 0x; echo $item | tr -d '\n' | xxd -p` - 38))
	if [[ $priority > 52 ]]; then
		priority=$((priority - 58))
	fi
	sum=$((sum + priority))
done

echo $sum
