#!/bin/bash

sum=0
while read line; do
	a=($(sed -e 's/,/ /;s/-/ /g' <<< $line))
	if [[ ${a[0]} -le ${a[2]} && ${a[3]} -le ${a[1]} ]]; then
		((sum+=1))
	elif [[ ${a[2]} -le ${a[0]} && ${a[1]} -le ${a[3]} ]]; then
		((sum+=1))
	fi
done
echo $sum
