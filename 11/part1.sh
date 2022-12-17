#!/bin/bash

declare -A monkeys
declare -A inspects

runmonkey() {
	operation=${monkeys[$1,operation]}
	check=${monkeys[$1,check]}
	yes=${monkeys[$1,yes]}
	no=${monkeys[$1,no]}
	items=($(cat monkey$1))
	echo -n > monkey$1
	for i in ${items[@]}; do
		((inspects[$1]+=1))
		old=$i
		eval "$operation"
		((new/=3))
		if [[ $((new % check)) != 0 ]]; then
			echo $new >> monkey$no
		else
			echo $new >> monkey$yes
		fi
	done
}

while read -ra line; do
	case ${line[0]} in
		"Monkey") monkey=$(tr -dc '[:digit:]' <<< ${line[1]}) ;;
		"Starting") items=($(tr -d ',' <<< ${line[@]:2})) ;;
		"Operation:") operation="((${line[@]:1}))" ;;
		"Test:") check=$(tr -dc '[:digit:]' <<< ${line[3]}) ;;
		"If")
			if [[ ${line[1]} == "true:" ]]; then
				yes=${line[5]}
			else
				no=${line[5]}
			fi
		;;
	esac
	if [ -z $line ]; then
		echo ${items[@]} > monkey$monkey
		monkeys[$monkey,operation]="$operation"
		monkeys[$monkey,check]="$check"
		monkeys[$monkey,yes]="$yes"
		monkeys[$monkey,no]="$no"
	fi
done
echo ${items[@]} > monkey$monkey
monkeys[$monkey,operation]="$operation"
monkeys[$monkey,check]="$check"
monkeys[$monkey,yes]="$yes"
monkeys[$monkey,no]="$no"

for i in $(seq 20); do
	for i in $(seq 0 $monkey); do
		runmonkey $i
	done
done

rm monkey*

echo $(($(echo ${inspects[@]} | tr ' ' '\n' | sort -n | tail -2 | tr '\n' '*'; echo -e "1")))
