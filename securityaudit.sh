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
CYAN='\033[1;36m'
NC='\033[0m'
echo -e "${CYAN}List of Admin/User/Service Accounts:${NC}" `grep '^sudo:.*$' /etc/group | cut -d: -f4|tr '\n' ' '^C && grep '^wheel:.*$' /etc/group | cut -d: -f4`
#Don't forget to change the root password. If any user has UID 0 besides root, they shouldn't. Bad idea. To check:
echo -e "${CYAN}Check if users have UID 0 that are not root: ${NC}"
grep 'x:0:' /etc/passwd
#Check if the user is a member of the root group:
echo -e "${CYAN}Check if the user is a member of the root group: ${NC}"
grep root /etc/group
#To see if anyone can execute commands as root, check sudoers:
echo -e "${CYAN}To see if anyone can execute commands as root, check sudoers: ${NC}"
cat /etc/sudoers
#To check for SUID bit, which allows programs to be executed with root privileges:
echo -e "${CYAN}Check for SUID bit, which allows programs to be executed with root privileges: ${NC}"
find / -perm -04000
