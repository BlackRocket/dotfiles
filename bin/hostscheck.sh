#!/bin/bash
## Check hosts that are online	
if [ -n "$1" ]; then
    net="$1"
else
    net=$(grep `hostname` /etc/hosts | awk -F '.' '{ print $1"."$2"."$3".0/24"}')
fi
sh_info "testing $net for online boxes"
sudo nmap -sP $net | awk '/Host/ && /up/ { print $0; }'
sh_success "done"