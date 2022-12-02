#!/bin/bash

declare -A win
win[A]=Y
win[B]=Z
win[C]=X

declare -A draw
draw[A]=X
draw[B]=Y
draw[C]=Z

score=0

function move() {
	if [[ ${win[$1]} == $2 ]]; then
		score=$((score + 6))
	elif [[ ${draw[$1]} == $2 ]]; then
		score=$((score + 3))
	fi
	case "$2" in
		"X") score=$((score + 1));;
		"Y") score=$((score + 2));;
		"Z") score=$((score + 3));;
	esac
}

while read line; do
	move $line
done

echo $score
