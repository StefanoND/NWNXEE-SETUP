# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 18.04 Desktop install:
#------------------------------------------------------------------------------
# Install NoIP
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
sudo /usr/local/bin/noip2 -C
#
# Insert e-mail
# Insert password
# Set the refresh interval (5 sec is good enough)
#
# Done installing and configuring
#
# Make NoIP run at startup
#
sudo crontab -e
# Type it in the last line
@reboot su -l <username> && sudo noip2
#------------------------------------------------------------------------------
# Install nginx
sudo apt install nginx
#
# Make is as a service (and run automatically at boot)
sudo systemctl enable nginx
#
# Create a shortcut from /var/www/ to ~/wwww
ln -s /var/www/ ~/
#
# Create a folder inside /var/www for nwsync
mkdir /var/www/nwsync
#
# Download and put the index.html file inside nwsync
# Create a new file for nwsync to put stuff in. This is where nswync will put everything and will be available for people to download from
mkdir /var/www/nwsyc/nwsyncdata
#
# Download nwsync file in here and place it in /etc/nginx/sites-available and make a shortcut of it on sites-enabled
ln -s /etc/nginx/sites-available/nwsync /etc/nginx/sites-enabled/
#
# Make directory for nwsync and open it
mkdir ~/nwsync && cd ~/nwsync
#
# Download nwsync (Version may be different)
wget https://github.com/Beamdog/nwsync/releases/download/0.2.6/nwsync.linux.amd64.zip
#
# Unzip it
unzip nwsync.linux.amd64.zip -d .
#
# Create a nwsyncdata folder
mkdir ~/nwsync/nwsyncdata
#
# Download nwsync_gui
wget https://github.com/WilliamDraco/nwsync_gui/releases/download/v1.1.0/nwsync_gui-linux.zip
#
# Unzip it
unzip nwsync_gui-linux.zip -d .
#
# Download the nwsync-update.sh and place it in your home folder
# Make it usable
chmod +x nwsync-*.sh
#
# Edit the "PATH=~/nwsync" if necessary
# Go back to your home folder
cd ~
#
# Run ./nwsync-update.sh or nwsync_GUI_update.sh if you want the GUI one
sudo ./nwsync-update.sh
sudo ./nwsync-GUI-update.sh
# 
# Click on "Choose Source" and select your module
# Click on "Choose Destination" and select "nwsyncdata" inside your nwsync folder
# Click on the big "RUN NWSYNC WRITE" button
# You may close this now
# If need permission use
chown -R $USER:$USER /path/to/folder
chown -R 755 /path/to/file
