# UPDATE IN PROGRESS
#------------------------------------------------------------------------------
# METHOD 1 - LOCAL
#------------------------------------------------------------------------------
# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 22.04 Desktop install:
# Install nginx
sudo apt install nginx -y
#
# Reload Daemon
sudo systemctl daemon-reload
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
#     # You can also use the hostname you setup from noip
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
# You can check to see if it's working by putting the ip address you configured in the browser.
# Example: if you access "http://192.168.1.1", you'll see NGINX saying that you configured it successfully
# After running nwsync for the first time, you can access it's contents through "http://192.168.1.1/nwsyncdata/"
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
chown -R $(logname):www-data ~/www
chown -R 0755 ~/www
#
#------------------------------------------------------------------------------
# METHOD 2 - Digita Ocean (Spaces)
#------------------------------------------------------------------------------
#
# Install docker
# ARCH
sudo pacman -S docker --noconfirm --needed
# UBUNTU
sudo apt install docker -y
#
# Enable it
sudo systemctl enable --now docker
#
# Create an account at https://digitalocean.com/
#
# Create a new teamnwsync
#
# Create a new Spaces, leave everything at default, don't forget to put a name
# Create Access Key https://cloud.digitalocean.com/account/api/spaces
#
# Download DO Space uploader from urothis and make his script executable
git clone https://github.com/urothis/nwn-nwsync-digitalOcean-uploader.git && cd nwn-nwsync-digitalOcean-uploader
chmod +x uploadNWSync.sh
#
# Edit env.list accordingly
# Note: The Endpoint must be the link without "https://SPACENAME", like: fra1.digitaloceanspaces.com or nyc3.digitaloceanspaces.com, etc
#
# Now run nwsync and copy the "data" folder, "manifests" folder and latest file into nwsync folder in nwn-nwsync-digitalOcean-uploader
# You can also change the path of nwsync to point straight to it instead
#
# After it's done, run the uploadNWSync script
sudo ./uploadNWSync.sh
#
# Grab a coffee, come back later, it might take a LONG time to finish depending on the size of your custom content.
# My custom content size is around 7GB, nwsync size is around 3GB, the script takes around 1 hour and 20 mins to finish
#
# WiP TODO
