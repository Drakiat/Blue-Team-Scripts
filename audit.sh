#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
#ASCII :)
wget -qO- https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/sec2.txt
echo ""
echo ""
#System Name
echo "hostname: "`hostname` >audit.txt
#internal IP
echo "Internal IP: " `ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'` >> audit.txt
#External IP
echo "External IP: "`dig +short myip.opendns.com @resolver1.opendns.com`>>audit.txt
#OS version
echo "OS version: " `uname -mrs`>> audit.txt
#Purposes
read -p "Purpose of this box(A few words is enough): " purpose
echo "Description: " $purpose >> audit.txt
#Critical Application(s)
read -p "Critical Application(separate with a comma if multiple): " app
echo "Critical Application(s): "$app>>audit.txt
#List of Admin/User/Service Accounts
echo "List of Admin/User/Service Accounts:" `grep '^sudo:.*$' /etc/group | cut -d: -f4`>>audit.txt
#List of Services Running
#List of Open Ports
echo ""
echo ""
cat audit.txt
