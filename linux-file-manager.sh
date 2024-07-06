#!/bin/bash

DIR=~/ngatngay-file-manager
ADDR="0.0.0.0:8753"

apt install -y wget php-cli php-common php-mbstring php-xml php-mysql php-curl php-zip

# service
cat << EOF > /etc/systemd/system/ngatngay-file-manager.service
[Unit]
Description=ngatngay File Manager
After=network.target

[Service]
ExecStart=/bin/bash -c 'php -S $ADDR -t $DIR >& /dev/null'
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl stop ngatngay-file-manager
systemctl start ngatngay-file-manager
systemctl enable ngatngay-file-manager

mkdir -p $DIR
cd $DIR

wget https://github.com/ngatngay/file-manager/releases/latest/download/file-manager-full.zip -O file-manager.zip
unzip -o file-manager.zip

# chmod -R 755 $DIR

echo ""
echo "Install OK! Access [IP]:8753 to use!"

