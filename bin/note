#!/bin/bash
# Usage: 
VERSION="1.0.1"
OPTIND=1

usage() { echo "Usage: note [-n <NOTENAME>] [-l] [-r <NOTENAME>] [-v]" 1>&2; exit 1; }
note() { $EDITOR $HOME/Dropbox/notes/"$*".txt; }
listnotes() { tree -CR --noreport $HOME/Dropbox/notes | awk '{ if ((NR > 1) gsub(/.txt/,"")); if (NF==1) print $1; else if (NF==2) print $2; else if (NF==3) printf "  %s\n", $3 }'; }
rmnote() { rm $HOME/.notes/"$*".txt ; }

while getopts "n:lr:v" o; do
        case "${o}" in
        n)      # open note
                note "${OPTARG}"
                ;;
        l)      # list notes
                listnotes
                ;;
        r)      # remove note
                rmnote "${OPTARG}"
                ;;
        v)      # show Version
                echo "BNote v${VERSION}"
                exit 0
                ;;
        \?)     echo "Unbekannte Option \"-$OPTARG\"." >&2
                usage
                ;;
        :)      echo "Option \"-$OPTARG\" benötigt ein Argument." >&2
                usage
                ;;
        *)      echo "Es ist eine Option notwendig." >&2
                usage
                ;;
        esac
done
shift $((OPTIND-1))