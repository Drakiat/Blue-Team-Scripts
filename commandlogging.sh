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
#This line is to fix
#echo >> /etc/bash.bashrc
if [ ! -f commandlogging-helper.txt ]; then
    wget -o commandlogging-helper.txt https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/
fi
line=$(head -n 1 commandlogging-helper.txt)
echo $line >> /etc/bash.bashrc
echo "local6.*    /var/log/commands.log" > /etc/rsyslog.d/bash.conf
sed -i "/messages/a /var/log/commands.log" /etc/logrotate.d/rsyslog
sudo service rsyslog restart
