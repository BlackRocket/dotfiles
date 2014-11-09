#!/bin/bash

_OLDPATH=`pwd`
_LASTCODE="1"
_OLDIFS=`echo "$IFS"`
IFS=""

if [ ${#@} -gt 0 ]; then
	for i in $@;
		do
			if test -d "$i"; then
				_PLAYLISTNAME="00-`basename ${i} | tr '[:upper:]' '[:lower:]'`.m3u"
				cd "$i" 2>/dev/null && find -depth -type f -regextype egrep -iregex '.*?\.(mp1|mp2|mp3|mp4|ogg|ra|wma|m4a|aac|wav|flac|aif|aiff|asf)$' \
				-exec echo {} \; | sort | perl -pe 's#^\./##g' > "${_PLAYLISTNAME}" && cd "$_OLDPATH"
				let _LASTCODE="$?"
				if [ "$_LASTCODE" -eq "0" ]; then
					printf "\033[1m\033[32m\x3d\x3d\x3e\033\1330m Playlist wurde erfolgreich in Verzeichnis \"${i}\" als Datei \"${_PLAYLISTNAME}\" erstellt.\n"
				else
					printf "\033[1m\033[31m\x3d\x3d\x3e\033\1330m Playlist konnte nicht in Verzeichnis \"${i}\" erstellt werden.\n" >&2
				fi
			else
				printf "\033[33m\x3d\x3d\x3e\033\1330m Das Verzeichnis \"$i\" existiert nicht.\n"
			fi
		done
else
	_PLAYLISTNAME="00-`basename $PWD | tr '[:upper:]' '[:lower:]'`.m3u"
	find -depth -type f -regextype egrep -iregex '.*?\.(mp1|mp2|mp3|mp4|ogg|ra|wma|m4a|aac|wav|flac|aif|aiff|asf)$' \
	-exec echo {} \; | sort | perl -pe 's#^\./##g' > "${_PLAYLISTNAME}"
	_LASTCODE="$?"
	if [ "$_LASTCODE" -eq "0" ]; then
		printf "\033[1m\033[32m\x3d\x3d\x3e\033\1330m Playlist wurde erfolgreich in Verzeichnis \"${PWD}\" als Datei \"${_PLAYLISTNAME}\" erstellt.\n"
	else
		printf "\033[1m\033[31m\x3d\x3d\x3e\033\1330m Playlist konnte nicht in Verzeichnis \"${PWD}\" erstellt werden.\n" >&2
	fi
fi

cd "$_OLDPATH"

IFS="${_OLDIFS}"
exit $_LASTCODE

