# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 18.04 Desktop install:
#------------------------------------------------------------------------------
# Install NoIP
#
# Install gcc just in can you don't have it yet
sudo pacman -S gcc --noconfirm
#
# Go to /src/ folder
cd /usr/local/src/
#
# Get latest version of NoIP
sudo wget http://www.noip.com/client/linux/noip-duc-linux.tar.gz
#
# Decompress it
sudo tar xf noip-duc-linux.tar.gz
#
# Go into NoIP's folder (version might be different)
cd noip-2.1.9-1/
#
# Install it
sudo make install
#
# Configure NoIP
#
######################################################################
# IF YOU'RE USING HETZNER IT'LL PROBABLY ASK WHICH NETWORK INTERFACE
# YOU WANT TO USE: CHOOSE "eth0" INSTEAD OF "enpXsX"
######################################################################
# Insert e-mail
# Insert password
# If you have more than one host name, you usually don't want both of them on
# Press "N" for "[...] "all updated" and for all [host.name] that you don't want
#
# Set the refresh interval (5 sec is good enough)
# If you don't want anything runnig press N
#
# Done installing and configuring
#
# Use the code below to reconfigure
sudo /usr/local/bin/noip2 -C
#
# Make NoIP run at startup
#
# Copy the noip2.service config file into /etc/systemd/system's folder
sudo cp -a ~/NWNXEE-SETUP-main/nwsync_files/noip2.service /etc/systemd/system
#
# Reload config and enable and start noip2 as a service
sudo systemctl daemon-reload
sudo systemctl enable noip2
sudo systemctl start noip2
#
# Go back to root folder if you're going to do the steps below
cd ~
#------------------------------------------------------------------------------
# Install nginx
sudo pacman -S nginx --noconfirm
#
# Make is as a service (and run automatically at boot)
sudo systemctl enable nginx
#
# Replace it's config file with the one you downloaded here
sudo cp -a ~/NWNXEE-SETUP-main/nwsync_files/nginx.conf /etc/nginx
#
# Create a shortcut from /var/www/ to ~/wwww
sudo mkdir /var/www
ln -s /var/www/ ~/www
#
# Create a folder inside /var/www for nwsync
sudo mkdir /var/www/nwsync
#
# Download and put the index.html file inside nwsync
sudo cp -a ~/NWNXEE-SETUP-main/nwsync_files/index.html ~/www/nwsync
#
# Create a new file for nwsync to put stuff in. This is where nswync will put everything and will be available for people to download from
sudo mkdir ~/www/nwsync/nwsyncdata
#
# Download nwsync file in here and place it in /etc/nginx/sites-available and make a shortcut of it on sites-enabled
sudo mkdir /etc/nginx/sites-available
sudo cp -a ~/NWNXEE-SETUP-main/nwsync_files/nwsync.conf /etc/nginx/sites-available
#
# Open it and look for "server_name 192.168.1.1;" change "192.168.1.1" to your internal IP you can use "ip a" in terminal to find out
# Also look for "proxy_pass no.ip.address;" and change the "no.ip.address" with your own No-Ip hostname
# Save overwritting everything (Ctrl + O and yes) and quit (Ctrl + X)
#-----------------------------------------------------------------------------
#                                  NOTE
#-----------------------------------------------------------------------------
# If you're using a paid server (with static public IP) you must comment
# the "proxy_pass" line and use your no-ip hostname in the "server_name"
# instead of the interal IP
#-----------------------------------------------------------------------------
sudo nano /etc/nginx/sites-available/nwsync.conf
sudo mkdir /etc/nginx/sites-enabled
sudo ln -s /etc/nginx/sites-available/nwsync.conf /etc/nginx/sites-enabled/
#
# Restart nginx
sudo systemctl restart nginx
#
# Make directory for nwsync and open it
mkdir ~/nwsync && cd ~/nwsync
#
# Download nwsync (Version may be different)
wget https://github.com/Beamdog/nwsync/releases/download/0.3.0/nwsync.linux.amd64.zip
#
# Unzip it
unzip nwsync.linux.amd64.zip -d .
#
#---------------------------------------------------------------------------------------------
# OPTIONAL
#---------------------------------------------------------------------------------------------
# Download nwsync_gui if you want
wget https://github.com/WilliamDraco/nwsync_gui/releases/download/v1.1.0/nwsync_gui-linux.zip
#
# Unzip it
unzip nwsync_gui-linux.zip -d .
#---------------------------------------------------------------------------------------------
#
# Download the nwsync-update.sh and place it in your home folder and make it usable
cp -a ~/NWNXEE-SETUP-main/nwsync_files/nwsync-update.sh ~/
cd ~/
chmod +x nwsync-*.sh
#
# Edit the "PATH=~/nwsync" if necessary
nano nwsync-update.sh
#
# Run ./nwsync-update.sh or nwsync_GUI_update.sh if you want the GUI one
sudo ./nwsync-update.sh
sudo ./nwsync-gui-update.sh
# 
# Click on "Choose Source" and select your module
# Click on "Choose Destination" and select "nwsyncdata" inside your nwsync folder
# Click on the big "RUN NWSYNC WRITE" button
# You may close this now
# If need permission use
chown -R $USER:$USER /path/to/folder
chown -R 755 /path/to/file
