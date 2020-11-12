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
echo "export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local6.debug "$(whoami) [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
" >> /etc/bash.bashrc
echo "local6.*    /var/log/commands.log" > /etc/rsyslog.d/bash.conf
sed -i "/messages/a /var/log/commands.log" /etc/logrotate.d/rsyslog
sudo service rsyslog restart
