# Install pre-requisite (if it isn't already)
sudo apt install make gcc -y
#
# Change folder
cd /usr/local/src
#
# Download NO-IP
sudo wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz
#
# Unzip it
sudo tar xf noip-duc-linux.tar.gz
#
# Change folder
cd noip-2.1.9-1
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
sudo touch /etc/systemd/system/noip2.service
curl https://raw.githubusercontent.com/StefanoND/NWNXEE-SETUP/main/noip_files/noip2.service -o - | sudo tee /etc/systemd/system/noip2.service
#
# Reload Systemctl
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
