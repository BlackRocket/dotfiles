#!/bin/bash
function system_infos()
# copyright 2007 - 2010 Christopher Bratusek
{
	case $1 in
		*cpu)
			echo -e "${ewhite}CPU:\n"
			echo -e "${eorange}Model:${eiceblue} $(grep "model name" /proc/cpuinfo | sed -e 's/.*: //g')"
			echo -e "${eorange}MHz  :${eiceblue} $(grep "cpu MHz" /proc/cpuinfo | sed -e 's/.*: //g')\n"
		;;
		*kernel)
			echo -e "${ewhite}Kernel:\n"
			echo -e "${eorange}Release:${eiceblue} $(uname -r)"
			echo -e "${eorange}Version:${eiceblue} $(uname -v)"
			echo -e "${eorange}Machine:${eiceblue} $(uname -m)\n"
		;;
		*mem | *ram)
			echo -e "${ewhite}RAM:\n"
			echo -e "${eorange}Total:${eiceblue} $(((`showmem --free`) + (`showmem --used`))) MB"
			echo -e "${eorange}Free :${eiceblue} $(showmem --free) MB"
			echo -e "${eorange}Used :${eiceblue} $(showmem --used) MB\n"
		;;
		*partitions)
			echo -e "${ewhite}Partitions:${eorange}\n"
			echo -e "major minor blocks device-node ${eiceblue}\
			\n$(cat /proc/partitions | sed -e '1,2d')" | column -t
			echo ""
		;;
		*pci)
			check_opt lspci systeminfos::pci
			if [[ $? != "1" ]]; then
				echo -e "${ewhite}PCI Devices:\n${eiceblue}"
				lspci -vkmm
				echo ""
			fi
		;;
		*usb)
			check_opt lsusb systeminfos::usb
			if [[ $? != "1" ]]; then
				echo -e "${ewhite}USB Devices:\n${eiceblue}"
				lsusb -v
				echo ""
			fi
		;;
		*mounts)
			echo -e "${ewhite}Mounts:\n${eorange}\
			\ndevice-node on mount-point type filesystem options\n" ${eiceblue} "\n\n$(mount)" | column -t
			echo ""
		;;
		*bios)
			check_opt dmidecode systeminfos::bios
			if [[ $? != "1" && $EUID == 0 ]]; then
				echo -e "${ewhite}SMBIOS/DMI Infos:${eiceblue}\n"
				dmidecode -q
			fi
		;;
		*all)
			system_infos_cpu
			system_infos_kernel
			system_infos_memory
			system_infos_partitions
			# system_infos_pci
			# system_infos_usb
			system_infos_mounts
			# system_infos_bios
		;;
		*)
			echo -e "\n${ewhite}Usage:\n"
			echo -e "${eorange}system_infos ${ewhite}|${egreen} --cpu\t\t${eiceblue}[Display CPU Model and Freq]\
			\n${eorange}system_infos ${ewhite}|${egreen} --kernel\t${eiceblue} 	[Display Kernel Version, Release and Machine]\
			\n${eorange}system_infos ${ewhite}|${egreen} --memory\t${eiceblue} 	[Display Total, Free and Used RAM]\
			\n${eorange}system_infos ${ewhite}|${egreen} --partitions\t${eiceblue}[Display Major, Minor, Blocks and Node for all Paritions]\
			\n${eorange}system_infos ${ewhite}|${egreen} --pci\t\t${eiceblue}[Display Infos about all PCI Devices (and their kernel-module)]\
			\n${eorange}system_infos ${ewhite}|${egreen} --usb\t\t${eiceblue}[Display Infos about all USB Devices (and their kernel-module)]\
			\n${eorange}system_infos ${ewhite}|${egreen} --bios\t${eiceblue} 	[Display SMBIOS DMI Infos]\
			\n${eorange}system_infos ${ewhite}|${egreen} --mounts\t${eiceblue} 	[Display all mounted devices]\n"
			tput sgr0
		;;
	esac
}
system_infos $1
