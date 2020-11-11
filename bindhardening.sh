#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
LIGHTCYAN='\033[1;36m'
NOCOLOR='\033[0m'
#ASCII :)
wget -qO- https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/sec2.txt
echo ""
echo ""
echo -e "${LIGHTCYAN}Hardening firewall...${NOCOLOR}"
# Flush/Delete firewall rules
iptables -F
iptables -X
iptables -Z
# Βlock null packets (DoS)
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
# Block syn-flood attacks (DoS)
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
# Block XMAS packets (DoS)
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
# Allow internal traffic on the loopback device
iptables -A INPUT -i lo -j ACCEPT
# Allow ssh access
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
#Allow bind access
iptables -A OUTPUT -p udp --dport 53 --sport 1024:65535 -j ACCEPT
iptables -A INPUT -p udp --dport 53 --sport 1024:65535 -j ACCEPT
#Allow NTP access
iptables -A INPUT -p udp --dport 123 -j ACCEPT
iptables -A OUTPUT -p udp --sport 123 -j ACCEPT
#Allow FTP
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 20 -j ACCEPT
#add more

# Allow established connections
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Allow outgoing connections
iptables -P OUTPUT ACCEPT
# Set default deny firewall policy
iptables -P INPUT DROP
# Set default deny firewall policy
iptables -P FORWARD DROP
# Save rules
iptables-save > /etc/iptables/rules.v4
# Apply and confirm
iptables-apply -t 40 /etc/iptables/rules.v4
#Stop and purge cron
echo -e "${LIGHTCYAN}Stopping and purging Cron...${NOCOLOR}"
service cron stop
sudo apt-get purge cron
#BackupBind
echo -e "${LIGHTCYAN}Copying Bind config...${NOCOLOR}"
#BackupEtc
cp -ar /etc/ /root/etcbackup
echo -e "${LIGHTCYAN}Setting permissions on shadow files...${NOCOLOR}"
# 6.1.9 Ensure permissions on /etc/gshadow- are configured
chown root:shadow /etc/gshadow-
chmod o-rwx,g-rw /etc/gshadow-
# 6.1.7 Ensure permissions on /etc/shadow- are configured
chown root:shadow /etc/shadow-
chmod o-rwx,g-rw /etc/shadow-
#Securing SSHD
echo -e "${LIGHTCYAN}Securing ssh...${NOCOLOR}"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i "s/#HostbasedAuthentication.*no$/HostbasedAuthentication no/" /etc/ssh/sshd_config
sed -i "s/#IgnoreRhosts.*yes$/IgnoreRhosts yes/" /etc/ssh/sshd_config
sed -i "s/#MaxAuthTries.*6$/MaxAuthTries 4/" /etc/ssh/sshd_config
sed -i "s/#LogLevel.*INFO$/LogLevel INFO/" /etc/ssh/sshd_config
protocol=$(grep -cP '^Protocol 2$' /etc/ssh/sshd_config)
if [ $protocol -eq 0 ];
then
	printf '\n%s' 'Protocol 2' >> /etc/ssh/sshd_config
fi
sed -i "s/#LoginGraceTime.*2m$/LoginGraceTime 60/" /etc/ssh/sshd_config
sed -i "s/#ClientAliveInterval.*0$/ClientAliveInterval 300/" /etc/ssh/sshd_config
sed -i "s/#ClientAliveCountMax.*3$/ClientAliveCountMax 0/" /etc/ssh/sshd_config
sed -i "s/#PermitUserEnvironment.*no$/PermitUserEnvironment no/" /etc/ssh/sshd_config
sed -i "s/#PermitEmptyPasswords.*no$/PermitEmptyPasswords no/" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin.*prohibit-password/PermitRootLogin no/g" /etc/ssh/sshd_config
chown root:root /etc/ssh/sshd_config
chmod og-rwx /etc/ssh/sshd_config
#chroot abwise and agbates
echo -e "${LIGHTCYAN}Chrooting abwise and agbates...${NOCOLOR}"
wget https://raw.githubusercontent.com/McSim85/make_chroot_jail/master/make_chroot_jail.sh
chmod +x make_chroot_jail.sh
./make_chroot_jail.sh -u abwise
./make_chroot_jail.sh -u agbates
echo -e "${LIGHTCYAN}Script by Frog.com (F%&% Allsafe!!!!!)${NOCOLOR}"
