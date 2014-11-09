#!/bin/bash
## Move filenames to lowercase
for file in *; do
	filename=${file##*/}
    case "$filename" in
    	*/* ) dirname==${file%/*} ;;
    	* ) dirname=.;;
    esac
    nf=$(echo $filename | tr A-Z a-z)
    newname="${dirname}/${nf}"
    if [[ "$nf" != "$filename" ]]; then
        mv "$file" "$newname"
        echo "lowercase: $file --> $newname"
    else
        echo "lowercase: $file not changed."
    fi
done
exit 0