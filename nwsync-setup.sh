# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 20.04 Desktop install:
#------------------------------------------------------------------------------
# Install nginx
sudo apt install nginx -y
#
# Make is as a service (and run automatically at boot)
sudo systemctl enable --now nginx
#
# Create a shortcut from /var/www/ to ~/wwww
ln -s /var/www/ ~/
#
# Create a folder inside /var/www for nwsync
sudo mkdir /var/www/nwsync
#
# Download and put the index.html file inside nwsync
sudo cp -a ~/NWNXEE-SETUP/nwsync_files/index.html ~/www/nwsync
#
# Create a new file for nwsync to put stuff in. This is where nswync will put everything and will be available for people to download from
sudo mkdir ~/www/nwsync/nwsyncdata
#
# Download nwsync file in here and place it in /etc/nginx/sites-available and make a shortcut of it on sites-enabled
sudo cp -a ~/NWNXEE-SETUP/nwsync_files/nwsync /etc/nginx/sites-available
#
# Tune the OS to support bursts of download
sudo sysctl -w net.core.somaxconn=4096
#
# Edit the nwsync file with your configs:
sudo nano /etc/nginx/sites-available/nwsync
#
#-----------------------------------------------------------------------------
#                                  NOTE
#-----------------------------------------------------------------------------
# server {
#     listen 80 backlog=4096;
#     listen [::]:80 backlog=4096;
#
#     # CHANGE THE "192.168.1.1" WITH YOUR PUBLIC IP ADDRESS
#     # GO TO https://www.whatismyip.com/ TO FIND OUT YOUR PUBLIC IP
#     server_name 192.168.1.1; 
#
#     root /var/www/nwsync;
#     index index.html;
#
#     location / {
#         root /var/www/nwsync;
#         index index.html;
#         sendfile on;
#         tcp_nopush on;
#         tcp_nodelay on;
#         autoindex on;
#         autoindex_exact_size off;
#         try_files $uri $uri/ =404;
#     }
# }
#-----------------------------------------------------------------------------
#
# Make a link of it in .../sites-enabled/
sudo ln -s /etc/nginx/sites-available/nwsync /etc/nginx/sites-enabled/
#
# Make directory for nwsync and open it
mkdir ~/nwsync && cd ~/nwsync
#
# Download nwsync (Version may be different)
wget https://github.com/Beamdog/nwsync/releases/download/0.4.3/nwsync.linux.amd64.zip
#
# Unzip it
unzip nwsync.linux.amd64.zip -d .
#
# Download the nwsync-update.sh and place it in your home folder
cp -a ~/NWNXEE-SETUP/nwsync_files/nwsync-update.sh ~/
#
# Edit the "PATH=~/nwsync" if necessary
# Go back to your home folder
cd ~
#
# Make it usable
chmod +x nwsync-update.sh
#
# Run ./nwsync-update.sh or nwsync_GUI_update.sh if you want the GUI one
sudo ./nwsync-update.sh
# 
# If need permission use
chown -R $(logname):$(logname) /path/to/folder
chown -R 755 /path/to/file
