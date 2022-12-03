#!/bin/bash

# 0x41 - 0x5A - Uppercase
# 0x61 - 0x71 - Lowercase

sum=0
team=0
all=

while read line; do
	priority=0
	team=$((team + 1))

	line=`echo $line | fold -w 1 | sort | uniq | tr -d '\n'`
	if [[ $team == 1 ]]; then
		prev=$line
	fi

	if [[ $team == 2 ]]; then
		prev=`echo $line$prev | fold -w 1 | sort | uniq -d | tr -d '\n'`
	fi

	if [[ $team == 3 ]]; then
		item=`echo $prev$line | fold -w 1 | sort | uniq -d`
		priority=$((`echo -n 0x; echo $item | tr -d '\n' | xxd -p` - 38))
		if [[ $priority > 52 ]]; then
			priority=$((priority - 58))
		fi
		sum=$((sum + priority))
		team=0
		all=""
	fi
done

echo $sum
