#!/bin/bash
###### example: pskill firefox-bin
# copyright 2007 - 2010 Christopher Bratusek
psgrep() {
	if [[ $1 == "-u" ]]; then
		ps aux | grep -v grep | grep $2 | awk '{ print $2 " : " $11}' | tee .temp
		CMDS=$(cat .temp)
	elif [[ $1 != "" ]]; then
		ps aux | grep -v grep | grep "$1" | awk '{ print $11 " : " $2 " : " $1 }' | tee .temp
		CMDS=$(cat .temp)
	fi
	if [[ $CMDS == "" ]]; then
		echo "no matching process"
	fi
	rm -f .temp
}

if [[ $1 ]]; then
	psgrep $1
		shift
	if [[ $CMDS != "" ]]; then
		echo -e "\nenter process number to kill:\n"
		read ID
		if [[ ! $ID == 0 || ! $ID == "" ]]; then
			kill $@ $ID
		fi
	fi
fi