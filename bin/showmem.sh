#!/bin/bash
function show_mem() {
	# copyright 2007 - 2010 Christopher Bratusek
	case $1 in
		*used )
			used=$(free -m | grep 'buffers/cache' | awk '{print $3}')
			if [[ $used -lt 1000 ]]; then
				echo 0$used
			elif [[ $used -lt 100 ]]; then
				echo 00$used
			else	echo $used
			fi
		;;
		*free )
			free=$(free -m | grep 'buffers/cache' | awk '{print $4}')
			if [[ $free -lt 1000 ]]; then
				echo 0$free
			elif [[ $free -lt 100 ]]; then
				echo 00$ree
			else	echo $free
			fi
		;;
		*used-percent )
			free | {
				read
				read m t u f s b c;
				f=$[$f + $b + $c]
				f=$[100-100*$f/$t]
				if [ $f -gt 100 ]; then
					f=100
				fi
				echo ${f}%
		}
		;;
		*free-percent )
			free | {
				read
				read m t u f s b c;
				f=$[$f + $b + $c]
				f=$[100-100*$f/$t]
				if [ $f -gt 100 ]; then
					f=100
				fi
				echo $((100-${f}))%
				}
		;;
		* )
			echo -e "\n${ewhite}Usage:\n"
			echo -e "\n${eorange}show_mem ${ewhite}|${egreen} --used ${eiceblue}[display used memory in mb]\
			\n${eorange}show_mem ${ewhite}|${egreen} --free ${eiceblue}[display free memory in mb]\
			\n${eorange}show_mem ${ewhite}|${egreen} --percent-used ${eiceblue}[display used memory in %]\
			\n${eorange}show_mem ${ewhite}|${egreen} --percent-free ${eiceblue}[display free memory in %]" | column -t
			echo ""
			tput sgr0
		;;
	esac
}
show_mem $1