#!/bin/bash


# ASCII Cause why not ;)
echo ""
echo ""
#ASCII :)
FILE=sec2.txt
if [ -f "$FILE" ]; then
    cat $FILE
else
    wget -qO- https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/sec2.txt
fi
echo ""
echo ""

# Add a bunch of users from list:

# Parse through CSV file of usernames,passwords
while IFS=, read -r user pass; do
	# Add user
	sudo su -c "useradd $user -s /bin/bash -m"
	echo "Added user: $user ."

	# Set user pass
	echo "$user:$pass" | sudo chpasswd
	echo "Gave $user a password: $pass .";
done < users.csv
