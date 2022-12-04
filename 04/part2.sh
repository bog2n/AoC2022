#!/bin/bash

sum=0

while read line; do
	a=($(sed -e 's/,/ /;s/-/ /g' <<< $line))
	if [[ ${a[2]} -ge ${a[0]} && ${a[2]} -le ${a[1]} || \
	      ${a[3]} -ge ${a[0]} && ${a[3]} -le ${a[1]} ]]; then
		((sum+=1))
	elif [[ ${a[0]} -ge ${a[2]} && ${a[0]} -le ${a[3]} || \
	        ${a[1]} -ge ${a[2]} && ${a[1]} -le ${a[3]} ]]; then
		((sum+=1))
	fi
done
echo $sum
