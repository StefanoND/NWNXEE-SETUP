# UPDATE IN PROGRESS
# ------------------------------------------------------------------------------
# METHOD 1 - LOCAL
# ------------------------------------------------------------------------------
# INSTALL NGINX
#
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
ln -svf /var/www/ ~/
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
# -----------------------------------------------------------------------------
#                                  NOTE
# -----------------------------------------------------------------------------
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
# -----------------------------------------------------------------------------
#
# Make a link of it in .../sites-enabled/
sudo ln -svf /etc/nginx/sites-available/nwsync /etc/nginx/sites-enabled/
#
# You can check to see if it's working by putting the ip address you configured in the browser.
# Example: if you access "http://192.168.1.1", you'll see NGINX saying that you configured it successfully
#
# ------------------------------------------------------------------------------
# Install NWSync
#
# Make directory for nwsync and open it
mkdir ~/nwsync && cd ~/nwsync
#
# Install nim and put it in your path (Be careful when running scripts from the internet)
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
#
# export the new nimble/bin folder to PATH as well as add it to your .bashrc
export PATH=/home/wosee/.nimble/bin:$PATH
printf "\nexport PATH=/home/wosee/.nimble/bin:\$PATH\n\n" | tee -a ~/.bashrc
#
# Select stable version of choosenim
choosenim stable
#
# Install neverwinter.nim
nimble install -y neverwinter
#
# Create a .bash_aliases if you haven't already
touch ~/.bash_aliases
#
# Create a better alias for nwsync commands
printf "\nalias nwsync_write='nwn_nwsync_write'\nalias nwsync_prune='nwn_nwsync_prune'\nalias nwsync_print='nwn_nwsync_print'\nalias nwsync_fetch='nwn_nwsync_fetch'\n" | tee -a ~/.bash_aliases
#
# Source .bash_aliases so the system recognizes the new aliases
source ~/.bash_aliases
#
# Download the nwsync-update.sh and place it in your home folder
cp -a ~/NWNXEE-SETUP/nwsync_files/nwsync-update.sh ~/
#
# Go back to your home folder
cd ~
#
# Change the "MODULENAME" to your module's name including the ".mod" extension
nano nwsync-update.sh
#
# Like so MODULENAME="mycoolmodule.mod"
#
# Make it usable
chmod +x nwsync-update.sh
#
# Run ./nwsync-update.sh
./nwsync-update.sh
#
# Depending on how much files/size your haks have, it may take a long time when you first run it
# When it's done you can check to see if it worked either by checking the nwsyncdata folder
ls ~/www/nwsync/nwsyncdata
#
# You should be able two folders: "data" and "manifests" and a file called "latest"
# Also you can access its contents through "http://192.168.1.1/nwsyncdata/" this can take a few minutes
# to update
#
# If need permission use
chown -R $(logname):www-data ~/www
chmod -R 0755 ~/www
#
# ------------------------------------------------------------------------------
# METHOD 2 - Digita Ocean (Spaces)
# ------------------------------------------------------------------------------
#
# Install s3cmd
# ARCH
sudo pacman -S s3cmd --noconfirm --needed
# UBUNTU
sudo apt install s3cmd -y
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
# Download DO Space uploader from my fork of urothis' repo and make his script executable
git clone https://github.com/StefanoND/nwn-nwsync-digitalOcean-uploader.git && cd nwn-nwsync-digitalOcean-uploader
chmod +x uploadNWSync.sh
#
# Edit nwsync-update.sh and uploadNWSync.sh accordingly
#
# Now run nwsync and copy the "data" folder, "manifests" folder and latest file into nwsync folder in nwn-nwsync-digitalOcean-uploader
# You can also change the path of nwsync to point straight to it instead
#
# After it's done, run the uploadNWSync script
sudo ./uploadNWSync.sh
#
# Grab a coffee, come back later, it might take a LONG time to finish depending on the size of your custom content.
# My custom content size is around 12GiB, nwsync size is around 6GiB.
# The script took me around 2 hours to finish on the 1st run, and twice as much for updating.
# So when you're going to update your nwsync to your Space, do it overnight
#
# While your nwsync stuff is being uploaded you can configure add a domain and activate CDN on it
#
# Go to https://www.namecheap.com/ create an account and create a domain name
# Now that it's created, click on "Manage" then in "Nameservers" select "Custom DNS" and add these links
ns1.digitalocean.com
ns2.digitalocean.com
ns3.digitalocean.com
#
# Click the Green Checkmark to save changes
#
# Go to https://cloud.digitalocean.com/networking/domains
# The domain name must be the same as the one you created in namecheap (If you created awesome.nwsync.xyz in namecheap it MUST be awesome.nwsync.xyz in here aswell)
#
# Now back to your Spaces, click settings and enable CDN
# Add custom subdomain, choose the domain you just created and select "Create Subdomain"
# For simplicity sake I'll name it "download" (which will be appended to awesome.nwsync.xyz so it'll be download.awesome.nwsync.xyz)
# Name the certificate whatever you want apply and save
# Now wait for around 30 mins - 1 hour and the link will be online.
#
# Now all that's left to do is to add your nwsyncurl to your server's script (Change MODULENAME to the name it is in your DO Space)
-nwsyncurl https://download.awesome.nwsync.xyz/MODULENAME/nwsync
#
# Done
