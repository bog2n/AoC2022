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

calcsum() {
	sum=0
	while read -a line; do
		[[ ${line[0]} -lt 100000 ]] && ((sum+=${line[0]}))
	done
	echo $sum
}

p=$PWD
[ -d files ] || gendir
cd $p
find files -type d -exec du -bs {} \; | calcsum

sudo umount files
rmdir files
