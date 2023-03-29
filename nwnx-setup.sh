# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 20.04 Server install:
#------------------------------------------------------------------------------
# Misc setup
# ---------------------------------------
#
# Increase font size
#
# Change console-setup file
sudo nano /etc/default/console-setup
#
# Change its contents so it looks like show below
FONTFACE="TER"
FONTSIZE="16x32"
#
# Apply changes
sudo update-initramfs -u
#
# Apply changes now (without reboot)
sudo setupcon
#
# Apply changes now system wide (without reboot)
sudo systemctl restart console-setup.service
#
# Done, you can now copy text from host (CTRL + C or CTRL + SHIFT + C) and paste in Putty with SHIFT + INSERT
#------------------------------------------------------------------------------
# THIS PART IS ONLY NEEDED IF YOU'RE USING ORACLE'S VM AND WANT SHARED FOLDERS (Using Windows as Host and Ubuntu as VM)
#1. Open VirtualBox
#2. Right-click your VM, then click Settings
#3. Go to Shared Folders section
#4. Add a new shared folder and name it "sharedf" without quotes (can't be just "shared")
#5. On Add Share prompt, select the Folder Path in your host that you want to be accessible inside your VM.
#6. In the Folder Name field, type shared
#7. Uncheck Read-only and Auto-mount, and check Make Permanent
#8. Start your VM
#9. Once your VM is up and running, go to Devices menu -> Insert Guest Additions CD image menu but don't run it, cancel if it asks
# Install dependencias for VirtualBox guest additions
sudo apt update -y && sudo apt upgrade -y
#
# Install necessary dependencies
sudo apt install -y dkms build-essential linux-headers-generic linux-headers-$(uname -r)
# Install this too
sudo apt install -y libxt6 libxmu6 nano
# Still testing this one
# sudo apt install virtualbox-guest-x11
# sudo VBoxClient --clipboard
#
# Create cdrom folder in case it doesn't exist
sudo mkdir /media/cdrom
#
# Mount it
sudo mount /dev/cdrom /media/cdrom
#
# Go into cdrom
cd /media/cdrom
#
# Go into root user
sudo su
#
# Install Guest Additions
./VBoxLinuxAdditions.run
#
# Reboot VM
reboot now
# Create "shared" directory in your home
mkdir ~/shared
# Mount the shared folder from the host to your ~/shared directory
sudo mount -t vboxsf sharedf ~/shared
# The host folder should now be accessible inside the VM
cd ~/shared
# Make the folder persistent
# Edit fstab file in /etc directory
sudo nano /etc/fstab
# Add the following line to fstab (sparated by tabs) and press Ctro+O then ENTER to Save and Ctrl+X to leave
sharedf	/home/<username>/shared	vboxsf	defaults	0	0
# Edit modules
sudo nano /etc/modules
# Add the following line to /etc/modules and press Ctro+O then ENTER to Save and Ctrl+X to leave
vboxsf
# Reboot the VM and log-in again
sudo shutdown -r now
# Go to your home directory and check to see if the file is highlighted in green.
cd ~
ls
# If it is then congratulations! You successfully linked the directory within your vm with your host folder.
#------------------------------------------------------------------------------
#
# Install necessary prereqs
#
#------------------------------------------------------------------------------
# NO LONGER NEEDED
# On 64bit systems, we need to manually add support for 32bit architecture
# sudo dpkg --add-architecture i386
#------------------------------------------------------------------------------
#
# We use a new compiler which may not be available by default, so add an extra place to download packages from
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
# Redownload manifests for the newly added architecture and repository so we can use them (and upgrade existing ones)
sudo apt update -y && sudo apt upgrade -y
# Install tools needed to build NWNX
sudo apt install g++-11 g++-11-multilib gcc-11 gcc-11-multilib cmake git make unzip -y
# Install stuff needed to build/run/use MySQL
sudo apt install mysql-server  libmysqlclient21 libmysqlclient-dev -y
# Install SSL dependency for Webhook just in case they're not already
sudo apt install libssl1.1 libssl-dev -y
# Install this required lib
sudo apt install libsndio7.0 libsndio-dev -y
#
# Reboot the VM and log-in again (also this is a good time to create a snapshot)
sudo reboot now
#
# Download and build NWNX
#
# Get latest source from github
git clone https://github.com/nwnxee/unified.git nwnx
# Make a directory where the build system will initialize even though there's already a Build folder (with upper case B)
mkdir nwnx/build && cd nwnx/build
# Initialize the build system to use GCC version 11, for 64bit. Build release version of nwnx, with debug info
# Ignore PostgreSQL, SWIG and HUNSPELL errors, you don't have them and you (probably) don't need them
CC="gcc-11 -m64" CXX="g++-11 -m64" cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../
# Build NWNX, in X threads (Where X is your CPU thread count + 1). This will take a while
make -j5
#
#############################################################################################################################################
##### THIS PART IS NOT NEEDED IF YOU'RE FOLLOWING THIS TUTORIAL FOR THE FIRST TIME                                                      #####
#############################################################################################################################################
##### Update nwnx from older version                                                                                                    #####
##### delete nwnx folder and redo the above steps (from line 136 through 142)                                                           #####
#############################################################################################################################################
#
# Download NWN dedicated package
# Make a directory to hold NWN data
mkdir ~/nwn && cd ~/nwn
# Fetch the NWN dedicated server package. The version here might be outdated, so replace "8193.34" with current NWN build version
# You can check the latest STABLE version here: https://forums.beamdog.com/discussion/67157/server-download-packages-and-docker-support
wget https://nwn.beamdog.net/downloads/nwnee-dedicated-8193.35-36.zip
# Unpack the server to current directory - ~/nwn
unzip nwnee-dedicated-8193.35-36.zip -d .
#
#############################################################################################################################################
##### THIS PART IS NOT NEEDED IF YOU'RE FOLLOWING THIS TUTORIAL FOR THE FIRST TIME                                                      #####
#############################################################################################################################################
##### Update from older version                                                                                                         #####
##### cd ~/nwn                                                                                                                          #####
##### Fetch the NWN dedicated server package. The version here might be outdated, so replace 8193.34 with current NWN build version     #####
##### wget https://nwnx.io/nwnee-dedicated-8193.35-36.zip                                                                               #####
##### Unpack the server to current directory - ~/nwn                                                                                    #####
##### unzip nwnee-dedicated-8193.35-36.zip -d .                                                                                         #####
##### Press A to overwrite everything                                                                                                   #####
#############################################################################################################################################
#
# Run it once to create the user directory.
# nwserver must be run with current directory the same as the executable, so we need to `cd` into it first
cd bin/linux-x86 && ./nwserver-linux
# The user directory path is long and contains spaces, which is hard to type sometimes.
# So we create a link (shortcut) to it as ~/nwn/userdir so it's easier to access
ln -s ~/.local/share/Neverwinter\ Nights/ ~/nwn/userdir
#
# -------------------------------------------------------------------------------
#
# To transfer files between your PC and the Server (or Host Machine and VM Guest without folder sharing) you can use SCP
#
# To transfer files from the Host to the Server you type "scp /path/to/file name@address:/path/to/destination" example:
scp ~/downloads/image.png vm@192.168.100.100:~/downloads
#
# This will copy the "image.png" from the host machine to the ~/downloads folder of the server folder
#
# If you want to transfer a folder instead, you use -r before the paths like so
scp -r ~/downloads/images vm@192.168.100.100:~/downloads
#
# This will copy the "images" folder and all its contents into the server's downloads folder
#
# If you're inside your server and want to get a file or folder from the host machine you do the inverse
scp host@192.168.200.200:~/downloads/image.png ~/downloads
#
# Note: The first time you run these commands you'll be prompted to trust (or not) the connection
# Note2: You'll need to type the password to be able to finish the commands, those are the login passwords of each respective machine
# So if in your vm your login is: vm and the password is: 123, you'll have to input "123" when it asks for the password
# The same applies if you're trying to use from the vm to the host, if the login of host is: host and the password is: 321, you'll have to input "321"
# So if you don't know the password of any of the machines you won't be able to run the above commands, unless the owner/administrator of each machine
# Set up an alternate althentitation that will let you run those commands without problems
#
# -------------------------------------------------------------------------------
# Set up your module:
# Copy your module/hak/tlk/etc files to ~/nwn/userdir
# Edit ~/nwn/userdir/nwnplayer.ini to your preference
#
# Set up version control on the servervault
# This is useful so you can restore player character backups if something goes wrong at any time
#
cd ~/nwn/userdir/servervault
# We'll use git for version control since that's what NWNX uses.
git init
git config --global user.name = "My Name"
git config --global user.email = "my@email.com"
#
# Set up the Database
#
# Run mysql (as admin/sudo). The following commands are given in MySQL, not the regular terminal
sudo mysql
# We want to configure mysql itself.
USE mysql;
# Create a new user for nwserver to use. 'nwn' is username, 'pass' is password, you can change them if you want.
CREATE USER 'nwn'@'localhost' IDENTIFIED BY 'pass';
# Give it full access
GRANT ALL PRIVILEGES ON *.* TO 'nwn'@'localhost';
FLUSH PRIVILEGES;
# Create a database for the module to use, typically named same as module, but can be anything.
CREATE DATABASE mymodulename;
exit;
#
#############################################################################################################################################
##### THIS PART IS NOT NEEDED IF YOU HAVE A DESKTOP/GUI INSTALLED                                                                       #####
#############################################################################################################################################
##### For simplicity sake download this repo in the user's home folder
##### cd ~/
#####
##### Download all files from this repo and cd into it
##### git clone https://github.com/StefanoND/NWNXEE-SETUP.git && cd NWNXEE-SETUP
#####
##### Copy them into your /home/ folder
##### cp nwnx_files/* ~/
#############################################################################################################################################
#
# Copy the scripts from this directory over into your home directory
# mod-start.sh - starts the server unless already running
# mod-stop.sh - kills the server
# mod-disable.sh - disables server auto restart
# mod-enable.sh - enables server auto restart
# mod-savechars.sh - saves servervault/ to git
# mod-status.sh - returns 1 if server is running, 0 if not
#
# cd to your home directory if you haven't already
cd ~
#
# Need to mark the scripts above as executable
chmod +x mod-*.sh
#
# Create a place where logs will be stored
mkdir logs
#
# Edit the mod-start.sh script to further customize. You can use any other text editor instead.
nano mod-start.sh
#
# Set up cronjob for auto server restart every minute
#
# Cron lets you run some script at specified intervals. You need to run this command, and then add the line exactly as given below
crontab -e
    # Add this line to the tab
    * * * * * sleep 5; ~/mod-start.sh
    * * * * * sleep 10; ~/mod-start.sh
    * * * * * sleep 15; ~/mod-start.sh
    * * * * * sleep 20; ~/mod-start.sh
    * * * * * sleep 25; ~/mod-start.sh
    * * * * * sleep 30; ~/mod-start.sh
    * * * * * sleep 35; ~/mod-start.sh
    * * * * * sleep 40; ~/mod-start.sh
    * * * * * sleep 45; ~/mod-start.sh
    * * * * * sleep 50; ~/mod-start.sh
    * * * * * sleep 55; ~/mod-start.sh
    * * * * * sleep 60; ~/mod-start.sh
#
# Start the server. If it goes down, the cron job will restart it again within 5 seconds.
#
./mod-start.sh
