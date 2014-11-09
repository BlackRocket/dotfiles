#!/bin/bash
###### machine details
echo -e "\n${ered}You are logged onto:$NC " ; hostname
echo -e "\n${ered}Additionnal information:$NC " ; uname -a
echo -e "\n${ered}Users logged on:$NC " ; w -h
echo -e "\n${ered}Current date:$NC " ; date
echo -e "\n${ered}Machine stat:$NC " ; uptime
echo -e "\n${ered}Disk space:$NC " ; df -h
echo -e "\n${ered}Memory stats (in MB):$NC " ; free -m
echo -e "\n${ered}IPs:$NC " ; ips