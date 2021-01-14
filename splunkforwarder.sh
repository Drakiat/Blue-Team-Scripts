#!/bin/bash
# ---------------------------------------------------------------------------------------------------------------------
#@(#)$Id$
#title  :splunkforwarder.sh
#description:   this script is designed to automate the installation and configuration of Splunk Universal Fowarder on Linux machines
#usage: ./splunkforwarder.sh
# ---------------------------------------------------------------------------------------------------------------------
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
#ASCII :)
echo "test"
FILE=sec2.txt
if [ -f "$FILE" ]; then
    cat $FILE
else
    wget -qO- https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/sec2.txt
fi

echo ""
echo ""
echo Enter IP of Splunk server:
read ip
read -p "Do you want iptables rules to be added? (Y/N)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "iptables -I INPUT -p tcp --sport 9997 -s $ip -j ACCEPT"
    echo "iptables -I OUTPUT -p tcp --dport 9997 -d $ip -j ACCEPT"
    iptables -I INPUT -p tcp --sport 9997 -s $ip -j ACCEPT
    iptables -I OUTPUT -p tcp --dport 9997 -d $ip -j ACCEPT
fi
#wget -O splunkforwarder.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.0&product=universalforwarder&filename=splunkforwarder-8.1.0-f57c09e87251-Linux-x86_64.tgz&wget=true'
#curl -Lo splunkforwarder.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.0&product=universalforwarder&filename=splunkforwarder-8.1.0-f57c09e87251-Linux-x86_64.tgz&wget=true'
FILE=splunkforwarder-8.1.0-f57c09e87251-Linux-x86_64.tgz
if [ -f "$FILE" ]; then
    tar -xvzf $FILE -C /opt
    echo "Splunk installer found..."
else
    echo "Fetching Splunk installer from the internet..."
    curl -Lo splunkforwarder.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.0&product=universalforwarder&filename=splunkforwarder-8.1.0-f57c09e87251-Linux-x86_64.tgz&wget=true'
    tar -xvzf splunkforwarder.tgz -C /opt

fi
cd /opt/splunkforwarder/bin
./splunk start --accept-license
./splunk enable boot-start
./splunk add forward-server $ip:9997
./splunk add monitor /var/log/
./splunk restart
echo "adding 'iptables -I INPUT -p tcp --sport 9997 -s $ip -j ACCEPT'"
echo "adding 'iptables -I OUTPUT -p tcp --dport 9997 -d $ip -j ACCEPT'"
