#!/bin/bash
# Usage: 
# 0 = Default; wird bei -f = 1 gesetzt
usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }
VERSION="0.5.1beta"
MODON= ;
NURF=0
OPTIND=1
while getopts "e:VdmD:s:p:vyz" o; do
        case "${o}" in
        e)      # File extension
                EXT=".${OPTARG}"
                ;;
        V)      # show Version
                echo "RAM v${VERSION}"
                exit 0
                ;;
        d)      # Set date
                DATE=`date +%F`"_"
                ;;
        m)      MODON=1
                ;;
        D)      # move DIR
                NEWDIR="${OPTARG}/"
                ;;
        s)      SUFFIX="_${OPTARG}"
                ;;
        p)      PREFIX="${OPTARG}_"
                ;;
        v)      VERBOSE="-v "
                ;;     
        \?)     echo "Unbekannte Option \"-$OPTARG\"." >&2
                usage
                exit 1
                ;;
        #:)      echo "Option \"-$OPTARG\" benötigt ein Argument." >&2
        #        exit 1
        #        ;;
        esac
done
shift $((OPTIND-1))

for i in *${EXT}; do
    ext=${i#*.}; 
    bn="${i##*/}"
    if [[ ! -z $MODON ]] 
     then
        DATE="_"`date -r "${i}" +%F`;
    fi
    #new="$PWD/${i} ${NEWDIR}${PREFIX}${DATE}${bn%.*}${SUFFIX}.${ext}"
    #echo "$new"
   mv ${VERBOSE}"$PWD/${i}" ${NEWDIR}"${PREFIX}${bn%.*}${DATE}${SUFFIX}.${ext}"; 
done  
exit 0