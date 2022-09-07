git clone https://github.com/SherlockSec/koth-service
cd koth-service
# Edit main.go and change the following constants:
# const kingPath = "/root/king.txt" 	// Path to king file
# const mapPath = "map.txt" 	// Path to map file
# const flags = 1 	        // amount of flags
# Then build:
# Windows
#env GOOS=windows GOARCH=amd64 go build .
# Linux
env GOOS=linux GOARCH=amd64 go build .
# Then create the service config for your OS, e.g. use systemctl for Linux and sc for Windows
echo "
[Unit]
Description=King of the Hill service
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/opt/koth-service/koth-service

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/koth.service
#create the king flag
echo “unclaimed” > /root/king.txt
cd ..
mv koth-service/ /opt
systemctl start koth
#And automatically get it to start on boot:
systemctl enable koth
