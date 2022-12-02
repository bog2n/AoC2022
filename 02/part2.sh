#!/bin/bash

declare -A win
win[A]=B
win[B]=C
win[C]=A

declare -A draw
draw[A]=A
draw[B]=B
draw[C]=C

declare -A lose
lose[A]=C
lose[B]=A
lose[C]=B

score=0

function move() {
	case "$2" in
		"X")
			act=${lose[$1]}	
		;;
		"Y")
			act=${draw[$1]}	
			score=$((score + 3))
		;;
		"Z")
			act=${win[$1]}	
			score=$((score + 6))
		;;
	esac
	case "$act" in
		"A")
			score=$((score + 1))
		;;
		"B")
			score=$((score + 2))
		;;
		"C")
			score=$((score + 3))
		;;
	esac
}

while read line; do
	move $line
done

echo $score
