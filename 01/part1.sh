#!/bin/bash
max=0

while read line; do
	if [ -z "$line" ]; then
		if [ $sum -gt $max ]; then
			max=$sum
		fi
		sum=0
	else
		sum=$(($sum + $line))
	fi
done

echo $max
