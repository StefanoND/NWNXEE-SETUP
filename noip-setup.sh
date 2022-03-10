# Install pre-requisite (if it isn't already)
apt install make gcc -y
#
# Change folder
cd /usr/local/src/
#
# Download NO-IP
sudo wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz
#
# Unzip it
tar xf noip-duc-linux.tar.gz
#
# Change folder
cd noip-2.1.9-1/
#
# Install and configure with your no-ip2 credentials, leave everything at default
sudo make install
#
# Reconfigure it with your no-ip2 credentials and leave everything at default
# This is needed be cause even though it says it "created" the config file, it's nowhere to be found
sudo /usr/local/bin/noip2 -C
#
# Make it run on boot (You can use other app instead of Nano if you wish)
# Create this file and copy-paste the following
sudo nano /etc/systemd/system/noip2.service
#
#-----------------------------------------------------------------------------
#                                  NOTE
#-----------------------------------------------------------------------------
# [Unit]
# Description=noip2 service
#
# [Service]
# Type=forking
# ExecStart=/usr/local/bin/noip2
# Restart=always
#
# [Install]
# WantedBy=default.target
#-----------------------------------------------------------------------------
#
# Reload Systemctl
sudo systemctl daemon-reload
#
# Enable NOIP2 service
sudo systemctl enable noip2
#
# Reboot your PC
shutdown -r now
#
# Now you can check if it's working or not, if it is congratulations!
systemctl status noip2
