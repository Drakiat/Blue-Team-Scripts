#!/bin/bash
echo Do not forget to run with sudo!!!!!!!!!!!!
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

