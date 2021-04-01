#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
# ASCII Cause why not ;)
echo ""
echo ""
wget -qO- https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/sec2.txt
echo ""
echo ""

# Add a bunch of users from list:

# Parse through CSV file of usernames,passwords
while IFS=, read -r user pass; do
	# Add user
	su -c "useradd $user -s /bin/bash -m"
	echo "Added user: $user ."

	# Set user pass
	echo "$user:$pass" | chpasswd
	echo "Gave $user a password: $pass .";
done < users.csv
