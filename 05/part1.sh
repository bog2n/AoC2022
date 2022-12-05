#!/bin/bash

declare -a crate1
declare -a crate2
declare -a crate3
declare -a crate4
declare -a crate5
declare -a crate6
declare -a crate7
declare -a crate8
declare -a crate9

declare -a crate

getcrate() {
	# $1 - crate number
	# $2 - action - pop,push,s(et),g(et)
	# $3 - argument (only for s and push)
	if [[ "$2" == g ]]; then
		case "$1" in
			1) crate=(${crate1[@]});;
			2) crate=(${crate2[@]});;
			3) crate=(${crate3[@]});;
			4) crate=(${crate4[@]});;
			5) crate=(${crate5[@]});;
			6) crate=(${crate6[@]});;
			7) crate=(${crate7[@]});;
			8) crate=(${crate8[@]});;
			9) crate=(${crate9[@]});;
		esac
	elif [[ "$2" == s ]]; then
		name=$3[@]
		a=("${!name}")
		case "$1" in
			1) crate1=(${a[@]});;
			2) crate2=(${a[@]});;
			3) crate3=(${a[@]});;
			4) crate4=(${a[@]});;
			5) crate5=(${a[@]});;
			6) crate6=(${a[@]});;
			7) crate7=(${a[@]});;
			8) crate8=(${a[@]});;
			9) crate9=(${a[@]});;
		esac
	elif [[ "$2" == pop ]]; then
		case "$1" in
			1) crate=(${crate1[@]});;
			2) crate=(${crate2[@]});;
			3) crate=(${crate3[@]});;
			4) crate=(${crate4[@]});;
			5) crate=(${crate5[@]});;
			6) crate=(${crate6[@]});;
			7) crate=(${crate7[@]});;
			8) crate=(${crate8[@]});;
			9) crate=(${crate9[@]});;
		esac
		i=$((${!crate} - 1))
		t=${crate[$i]}
		unset "crate[$i]"
		getcrate $1 s crate
		crate=$t
	elif [[ "$2" == push ]]; then
		case "$1" in
			1) crate=(${crate1[@]});;
			2) crate=(${crate2[@]});;
			3) crate=(${crate3[@]});;
			4) crate=(${crate4[@]});;
			5) crate=(${crate5[@]});;
			6) crate=(${crate6[@]});;
			7) crate=(${crate7[@]});;
			8) crate=(${crate8[@]});;
			9) crate=(${crate9[@]});;
		esac
		crate+=($3)
		getcrate $1 s crate
	fi
}

move() {
	for i in $(seq $2); do
		getcrate $4 pop
		getcrate $6 push $crate
	done
}

while IFS= read line; do
	[[ $(cut -c 2 <<< "$line") == 1 ]] && break
	for i in {1..9}; do
		offset=$((-2 + i * 4 ))
		getcrate $i g
		currentcrate=(${crate[@]} $(cut -c $offset <<< "$line"))
		getcrate $i s currentcrate
	done
done

for i in {1..9}; do
	getcrate $i g
	rcrate=($(rev <<< "${crate[@]}"))
	getcrate $i s rcrate
done

while read line; do
	[ ! -z "$line" ] && move $line
done

for i in {1..9}; do
	getcrate $i pop
	echo -n $crate
done
echo
