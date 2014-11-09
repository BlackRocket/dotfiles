#!/bin/bash
function show_tty()
# copyright 2007 - 2010 Christopher Bratusek
{
	case $1 in
		*help )
			echo -e "\n${ewhite}Usage:\n"
			echo -e "${eorange}show_tty${ewhite}|${egreen} ! no options !\n"
			tput sgr0
		;;
		* )
			TTY=$(tty)
			echo ${TTY:5} | sed -e 's/\//\:/g'
		;;
	esac
}
show_tty