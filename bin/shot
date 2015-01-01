#!/bin/bash
#####################################################################
#
# This script takes screenshots of a movie
# Depends on mplayer and imagemagick
#
# Made by	Starlite	<http://starl1te.wordpress.com/>
#
# This script is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
#####################################################################

usage="Type shot -h for help"
_help(){
echo -e "\nusage: shot [options] [file] ... [fileN]\n
 Options:
  -t <time> - Set time (in minutes) between screenshots; the number of screenshots is calculated automatically.
  -n <number> - Set a fixed number of screenshots to take.
  -r <percent> - Change the size of the output image. Less than 40% is recommended.
  -s - Seed mode. Gives extra video and audio information. Removes spaces.
  -h - Display this help message\n

If you don't like taken screenshots, try to run the script once more.
This script depends on Mplayer and ImageMagic.\n
Usage example:
shot -n 25 -r 35% ~/films/film.avi\n"
}

shot(){
# Making screenshots...
for i in `seq 1 $shots_number`;
do
  randomiser=$RANDOM; let "randomiser %= 25"
  hop=`echo $[$shot_time*60*$i+$randomiser]`
  mplayer -ss $hop -noautosub -frames 1 -ao null -vo png "$file_path" > /dev/null 2>&1
  mv 00000001.png /tmp/shots/$i.png
  echo -ne "Taking screenshot #${i} \r"
done
  echo "Taking screenshots...           [OK]"
}


# ====== first step is here! ;-) ========
# Checking options...
while getopts ":t:n:r:sh" option
	do
		case $option in
		t ) shot_time=$OPTARG; opt=_time;;
		n ) shots_number=$OPTARG; opt=_num;;
		h ) _help; opt=1; exit 1;;
		s ) seed=1;;
		r ) res=$OPTARG;;
		: ) echo "No argument given"; opt=1; exit 1;;
		* ) echo "Unknown option"; echo $usage; opt=1; exit 1;;
		esac
	done

if [ "$res" == "" ]; then res=35%; fi
if [ "$opt" == "" ]; then echo "No option given!"; echo $usage; exit 1; fi
shift $(($OPTIND - 1))
if [ "$1" == "" ]; then echo "No file given!"; echo $usage; exit 1; fi
mkdir /tmp/shots

# Parsing files...
while [ "$1" != "" ]
do
  file_path=$1
  file_name_ext=${file_path##*/}
  file_name=`echo "$file_name_ext" | sed '$s/....$//'`
  randomiser=0
  quality=87
  movdir=`dirname "$file_path"`
	if [ "$movdir" == "." ]; then
	movdir=`pwd`
	file_path=$movdir/$file_path
	fi
  cd "$movdir"
echo "Processing file $file_name_ext..."

# Getting movie length...
length=`mplayer -identify "$file_path" -frames 1 -ao null -vo null 2>/dev/null \
| grep LENGTH | sed -e 's/^.*=//' -e 's/[.].*//'`

if [ "$length" == "" ]; then echo "Error! Can't get the length of the movie."; exit 1; fi

if [ "$opt" == "_time" ]; then
	shots_number=`echo $[$length/60/$shot_time]`
	shot
elif [ "$opt" == "_num" ]; then
	shot_time=`echo $[$length/$shots_number/60]`
	shot
fi

# Placing all taken screenshots in one picture...
echo -n "Putting screenshots together..."
cd /tmp/shots/
montage -geometry +2+2 `ls *.png | sort -n` "$file_name".jpg
mogrify -resize $res "$file_name".jpg
echo " [OK]"
echo -n "Getting video info..."
size=`stat -c%s "$file_path"`
size=`echo $[$size/1024/1024]`
format=`mplayer -frames 1 -ao null -vo null -identify 2>/dev/null "$file_path" | grep VIDEO: | cut -d " " -f 5`
length=`echo $[$length/60]`
# It's a tricky code here, it adds some info about the movie to the output image.
echo -e "File name: $file_name_ext\nSize: $size Mb\nResolution: $format\nDuration: $length min." | convert -pointsize 16 -trim +repage text:- text.jpg
convert "$file_name".jpg -quality $quality -splice 0x80 -draw 'image over 5,5 0,0 text.jpg' "$movdir/$file_name".jpg
echo "           [OK]"; echo
cd "$movdir"
    if [ "$seed" == "1" ]; then
	VIDEO=`mplayer -frames 1 -ao null -vo null -identify 2>/dev/null "$file_path" | grep VIDEO:`
	AUDIO=`mplayer -frames 1 -ao null -vo null -identify 2>/dev/null "$file_path" | grep AUDIO: | cut -d "(" -f 1`
	echo -e "LENGTH: $length min.\n$VIDEO\n$AUDIO"; echo
	file_name_sp=`echo "$file_name" | sed 's/ /_/g'`
	mv "$file_name".jpg "$file_name_sp".jpg 2>/dev/null
    fi
shift
done

rm -r /tmp/shots
echo "Done"
