#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
echo Enter IP of Splunk server:
read ip
#wget -O splunkforwarder.tgz 'https://www.dropbox.com/s/611e61m4bztedxk/splunkforwarder-9.0.4-de405f4a7979-Linux-x86_64.tgz?dl=1'
curl -Lo splunkforwarder.tgz 'https://www.dropbox.com/s/611e61m4bztedxk/splunkforwarder-9.0.4-de405f4a7979-Linux-x86_64.tgz?dl=1'
tar -xvzf splunkforwarder.tgz -C /opt
cd /opt/splunkforwarder/bin
./splunk start --accept-license
./splunk enable boot-start
./splunk add forward-server $ip:9997
./splunk add monitor /var/log/
./splunk restart