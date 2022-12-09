#!/bin/bash

declare -a grid
h=0
sum=0

while read line; do
	test -z $l && l=${#line}
	grid+=($(sed 's/\(.\)/\1 /g' <<< $line))
	((h+=1))
done

left() {
	for i in $(seq $x); do
		[[ ${grid[$((y * h + (x - $i)))]} -ge $1 ]] && return 1
	done
	((sum+=1))
	return 0
}

right() {
	for i in $(seq $(($l - $x - 1))); do
		[[ ${grid[$((y * h + (x + $i)))]} -ge $1 ]] && return 1
	done
	((sum+=1))
	return 0
}

up() {
	for i in $(seq $y); do
		[[ ${grid[$(((y - $i) * h + x))]} -ge $1 ]] && return 1
	done
	((sum+=1))
	return 0
}

down() {
	for i in $(seq $(($h - $y - 1))); do
		[[ ${grid[$(((y + $i) * h + x))]} -ge $1 ]] && return 1
	done
	((sum+=1))
	return 0
}

for y in $(seq $(($l - 2))); do
	for x in $(seq $(($h - 2))); do
		left ${grid[$((y * h + x))]} && continue
		right ${grid[$((y * h + x))]} && continue
		up ${grid[$((y * h + x))]} && continue
		down ${grid[$((y * h + x))]} && continue
	done
done

((sum+=h * l - ((h - 2) * (l - 2))))
echo $sum
