#!/bin/bash

declare -A grid
places=0

hx=0
hy=0
tx=0
ty=0

move() {
	if [[ $((hx - tx)) == 2 ]]; then
		((tx+=1))
		if [[ $((hy - ty)) == 1 ]]; then
			((ty+=1))
		elif [[ $((hy - ty)) == -1 ]]; then
			((ty-=1))
		fi
	elif [[ $((hx - tx)) == -2 ]]; then
		((tx-=1))
		if [[ $((hy - ty)) == 1 ]]; then
			((ty+=1))
		elif [[ $((hy - ty)) == -1 ]]; then
			((ty-=1))
		fi
	elif [[ $((hy - ty)) == 2 ]]; then
		((ty+=1))
		if [[ $((hx - tx)) == 1 ]]; then
			((tx+=1))
		elif [[ $((hx - tx)) == -1 ]]; then
			((tx-=1))
		fi
	elif [[ $((hy - ty)) == -2 ]]; then
		((ty-=1))
		if [[ $((hx - tx)) == 1 ]]; then
			((tx+=1))
		elif [[ $((hx - tx)) == -1 ]]; then
			((tx-=1))
		fi
	fi
	if [ -z ${grid[$tx,$ty]} ]; then
		grid[$tx,$ty]=1
		((places+=1))
	fi
}

while read -a line; do
	for i in $(seq ${line[1]}); do
		case "${line[0]}" in
			R) ((hx+=1)) ;;
			L) ((hx-=1)) ;;
			U) ((hy+=1)) ;;
			D) ((hy-=1)) ;;
		esac
		move
	done
done

echo $places
