 #!/bin/bash
  find . -name "* *"|while read i
  do
    target=`echo "$i"|tr -s ' ' '_'`
    mv -v "$i" "$target"
  done
  exit 0