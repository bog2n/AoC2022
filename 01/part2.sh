#!/bin/bash

mkfifo a

while read line; do
	if [ -z "$line" ]; then
		echo "$sum" > a &
		sum=0
	else
		sum=$(($sum + $line))
	fi
done

echo $((`(cat a | sort -n | tail -3; echo -n 0) | tr '\n' '+'`))
rm a
