#!/bin/bash

# Step 1: Update and install GNOME Desktop
echo "Step 1: Update and install GNOME Desktop"
apt update
apt install ubuntu-desktop -y

# Step 2: Install and Configure VNC
echo "Step 2: Install and Configure VNC"
apt install tigervnc-standalone-server tigervnc-common -y

# Step 3: Create VNC configuration
echo "Step 3: Create VNC configuration"

cat <<EOL > /etc/systemd/system/vncserver@.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver %i -geometry 1280x1024
PIDFile=/home/$USER/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target
EOL

echo "VNC configuration created."

# Step 4: Enable and start the VNC server
echo "Step 4: Enable and start the VNC server"
systemctl daemon-reload
systemctl enable vncserver@:1.service
systemctl start vncserver@:1.service

echo "VNC installation and configuration complete."

# Additional information
echo "Remember to set up a VNC password for users. You can use 'vncpasswd' to set passwords for VNC users."

