# Install pre-requisite (if it isn't already)
sudo apt install -y make gcc
#
# Download NO-IP
wget -O ~/noip-duc-linux.tar.gz http://www.noip.com/client/linux/noip-duc-linux.tar.gz
#
# Unzip it
sudo tar -xf noip-duc-linux.tar.gz -C /usr/local/src
#
# Install and configure with your no-ip2 credentials, leave everything at default
sudo make install -C /usr/local/src/noip-2.1.9-1
#
# To make noip run on boot we'll need to create a service for this.
# Download noip2.service and put it at /etc/systemd/system
curl https://raw.githubusercontent.com/StefanoND/NWNXEE-SETUP/main/noip_files/noip2.service -o - | sudo tee /etc/systemd/system/noip2.service
#
# Reload Systemctl so the service is detected
sudo systemctl daemon-reload
#
# Enable NOIP2 service
sudo systemctl enable --now noip2
#
# Reboot your PC
sudo shutdown -r now
#
# Now you can check if it's working or not, if it is congratulations!
systemctl status noip2
#
# You'll need to configure your Router/Firewall to allow/block connections accordingly
