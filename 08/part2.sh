#!/bin/bash

declare -a grid
h=0

while read line; do
	test -z $l && l=${#line}
	grid+=($(sed 's/\(.\)/\1 /g' <<< $line))
	((h+=1))
done

left() {
	trees=0
	for i in $(seq $x); do
		((trees+=1))
		[[ ${grid[$((y * h + (x - $i)))]} -ge $1 ]] && break
	done
	return $trees
}

right() {
	trees=0
	for i in $(seq $(($l - $x - 1))); do
		((trees+=1))
		[[ ${grid[$((y * h + (x + $i)))]} -ge $1 ]] && break
	done
	return $trees
}

up() {
	trees=0
	for i in $(seq $y); do
		((trees+=1))
		[[ ${grid[$(((y - $i) * h + x))]} -ge $1 ]] && break
	done
	return $trees
}

down() {
	trees=0
	for i in $(seq $(($h - $y - 1))); do
		((trees+=1))
		[[ ${grid[$(((y + $i) * h + x))]} -ge $1 ]] && break
	done
	return $trees
}

sum=0

for y in $(seq $(($l - 2))); do
	for x in $(seq $(($h - 2))); do
		scval=1
		left ${grid[$((y * h + x))]}
		((scval*=$?))
		right ${grid[$((y * h + x))]}
		((scval*=$?))
		up ${grid[$((y * h + x))]}
		((scval*=$?))
		down ${grid[$((y * h + x))]}
		((scval*=$?))
		[[ $scval -gt $max ]] && max=$scval
	done
done

echo $max
