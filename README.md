# VNC-Installation-Script-for-Ubuntu

```markdown
# VNC Installation Script for Ubuntu

This script automates the installation and configuration of a VNC server on Ubuntu, allowing remote desktop access.

## Prerequisites

- Ubuntu operating system
- sudo privileges

## Usage

### Step 1: Download the Script
Download the installation script to your Ubuntu machine using `wget`:
```bash
wget https://link-to-script.sh
```

### Step 2: Run the Script
Execute the script using `bash`:
```bash
bash vnc_installation_script.sh
```

## Steps Performed by the Script

### Step 1: Update and Install GNOME Desktop
Update the package list and install the GNOME desktop environment:
```bash
apt update
apt install ubuntu-desktop -y
```

### Step 2: Install and Configure VNC
Install the TigerVNC server and common packages:
```bash
apt install tigervnc-standalone-server tigervnc-common -y
```

### Step 3: Create VNC Configuration
Create a systemd service configuration file for VNC:
```bash
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
```

### Step 4: Enable and Start the VNC Server
Reload systemd configurations and enable the VNC server to start on boot:
```bash
systemctl daemon-reload
systemctl enable vncserver@:1.service
systemctl start vncserver@:1.service
```

## Additional Information

- Set up a VNC password for users using the `vncpasswd` command.
- Ensure firewall rules allow connections to the VNC server port (`:1` by default).

## Support

For issues or questions, please open an [issue](https://github.com/yourusername/yourrepository/issues).

## License

This project is licensed under the [MIT License](LICENSE).
```
Replace `https://link-to-script.sh` with the actual link to your script if you host it somewhere. Also, replace `yourusername/yourrepository` in the support section with your GitHub username and repository name.
