#!/bin/bash

gendir() {
	while read -a line; do
		if [[ ${line[0]} == "$" ]]; then
			if [[ ${line[1]} == "ls" ]]; then
				cmd=ls
				continue
			elif [[ ${line[1]} == "cd" ]]; then
				cmd=cd
				if [[ ${line[2]} == "/" ]]; then
					mkdir files
					sudo mount -t ramfs ramfs files
					sudo chown $USER:$USER files
					cd files 
					continue
				fi
				cd ${line[2]}
			fi
		fi
		if [[ $cmd == ls ]]; then
			if [[ ${line[0]} == dir ]]; then
				mkdir ${line[1]}
			else
				dd if=/dev/zero of=${line[1]} bs=${line[0]} count=1 &> /dev/null
			fi
		fi
	done
}

p=$PWD
[ -d files ] || gendir
cd $p

remove=$((`du -bs files | awk '{print $1}'` - 40000000))
for i in $(du -b files | awk '{print $1}' | sort -n); do
	if [[ $(($remove - $i)) -lt 0 ]]; then
		echo $i
		break
	fi
done

sudo umount files
rmdir files
