#!/bin/bash
	case $1 in
		*help )
			echo -e "\n${ewhite}Usage:\n"
			echo -e "${eorange}show_cpu_load${ewhite} |${egreen} ! no options !\n"
			tput sgr0
		;;
		* )
			NICE_IGNORE=20
			t="0"
			while read cpu ni; do
				if [[ $ni == *-* || $ni -le $NICE_IGNORE ]]; then
					t="$t + $cpu"
				fi
				if [[ ${cpu%%.*} -eq 0 ]]; then
					break
				fi
			done < <(ps -Ao "%cpu= ni="| sort -r)
			cpu=$(echo "$t" | bc)
			if [[ ! "${cpu#.}x" = "${cpu}x" ]]; then
				cpu="0${cpu}"
			fi
			cpu=${cpu%%.*}
			if [[ $cpu -gt 100 ]]; then
				cpu=100
			fi
			if [[ $cpu -lt 16 ]]; then
				color=${eiceblue}
			elif [[ $cpu -lt 26 ]]; then
				color=${eturqoise}
			elif [[ $cpu -lt 41 ]]; then
				color=${esmoothgreen}
			elif [[ $cpu -lt 61 ]]; then
				color=${egreen}
			elif [[ $cpu -lt 81 ]]; then
				color=${eyellow}
			else	color=${ered}
			fi
			if [[ $cpu -lt 10 ]]; then
				prepend=00
			elif [[ $cpu -lt 100 ]]; then
				prepend=0
			fi
			if [[ $enabcol == true ]]; then
				echo -e "$color$prepend$cpu"
			else	echo $prepend$cpu
			fi
		;;
	esac