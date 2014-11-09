  #!/bin/bash
  for i in *; do 
    mv -v -- "$i" "$(tr [:lower:] [:upper:] <<< "$i")" ; 
  done
  exit 0