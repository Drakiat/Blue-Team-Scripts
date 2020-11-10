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
echo Enter IP of Splunk server:
read ip
wget -O splunkforwarder.tgz 'https://tinyurl.com/l1n-sp1-for'
#curl -Lo splunkforwarder.tgz 'https://tinyurl.com/l1n-sp1-for'
tar -xvzf splunkforwarder.tgz -C /opt
cd /opt/splunkforwarder/bin
./splunk start --accept-license
./splunk enable boot-start
./splunk add forward-server $ip:9997
./splunk add monitor /var/log/
./splunk restart

