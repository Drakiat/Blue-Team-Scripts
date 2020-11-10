#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
echo Input banner:
read banner

chown root:root /etc/motd
chmod 644 /etc/motd
echo $banner > /etc/motd
  
chown root:root /etc/issue
chmod 644 /etc/issue
echo $banner > /etc/issue
  
chown root:root /etc/issue.net
chmod 644 /etc/issue.net
echo $banner > /etc/issue.net
