#!/bin/bash
	# copyright 2007 - 2010 Christopher Bratusek
	case $1 in
		*help )
			echo -e "\n${ewhite}Usage:\n"
			echo -e "${eorange}show_uptime${ewhite} |${egreen} ! no options !\n"
			tput sgr0
		;;
		* )
			uptime=$(</proc/uptime)
			timeused=${uptime%%.*}
			if (( timeused > 86400 )); then
			((
				daysused=timeused/86400,
				hoursused=timeused/3600-daysused*24,
				minutesused=timeused/60-hoursused*60-daysused*60*24,
				secondsused=timeused-minutesused*60-hoursused*3600-daysused*3600*24
			))
				if (( hoursused < 10 )); then
					hoursused=0${hoursused}
				fi
				if (( minutesused < 10 )); then
					minutesused=0${minutesused}
				fi
				if (( secondsused < 10 )); then
					secondsused=0${secondsused}
				fi
				output="${daysused}d ${hoursused}h:${minutesused}m:${secondsused}s"
			elif (( timeused < 10 )); then
				output="0d 00h:00m:0$(timeused)s"
			elif (( timeused < 60 )); then
				output="0d 00h:00m:${timeused}s"
			elif (( timeused < 3600 )); then
			((
				minutesused=timeused/60,
				secondsused=timeused-minutesused*60
			))
				if (( minutesused < 10 )); then
					minutesused=0${minutesused}
				fi
				if (( secondsused < 10 )); then
					secondsused=0${secondsused}
				fi
				output="0d 00h:${minutesused}m:${secondsused}s"
			elif (( timeused < 86400 )); then
			((
				hoursused=timeused/3600,
				minutesused=timeused/60-hoursused*60,
				secondsused=timeused-minutesused*60-hoursused*3600
			))
				if (( hoursused < 10 )); then
					hoursused=0${hoursused}
				fi
				if (( minutesused < 10 )); then
					minutesused=0${minutesused}
				fi
				if (( secondsused < 10 )); then
					secondsused=0${secondsused}
				fi
				output="0d ${hoursused}h:${minutesused}m:${secondsused}s"
			fi
			echo "$output"
		;;
	esac