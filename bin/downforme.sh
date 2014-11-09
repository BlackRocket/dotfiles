#!/bin/bash
# Check to see if a site is down for everyone or just me
if [ $# = 0 ]; then
	echo -e "${eyellow}usage:${nocol} downforme website_url"
else
	JUSTYOUARRAY=(`lynx -dump http://downforeveryoneorjustme.com/$1 | grep -o "It's just you"`)
	if [ ${#JUSTYOUARRAY} != 0 ]; then
		echo -e "${esmoothgreen}It's just you. \n${nocol}$1 is up."
	else
		echo -e "${ered}It's not just you! \n${nocol}$1 looks down from here."
	fi
fi