# NWNX:EE Setup

Take some time to understand what each command does.
These steps were tested on a clean Ubuntu 26.04 Server install:

This guide is intended for a fast setup from installing OS to get the server up
and running in less than 1 hour.

Many things here are briefly explained/not explained/ommited/explained wrongly/lied about
as to not overwhelm the reader and get their server up and running.

My intention is to make this as a base or starting point for the reader so they
can go more in-depth on their own.

## Hetzner only

ONLY REQUIRED IF HOSTING ON HETZNER (https://www.hetzner.com/)
Skip to the next part if you're not hosting on Hetzner

First let's open the sudoers file and see if everything's ok

    sudo visudo

Look for the following lines, add them if they're not there.
Allow members of group sudo to execute any command

    %sudo   ALL=(ALL:ALL) ALL

Now let's create a new user, change USERNAME to whatever you like
It'll ask for a password, I recommend you to use password
You can leave everything else empty

    sudo adduser USERNAME

Let's add it to the sudo group

    sudo usermod -aG sudo USERNAME

To check if it was created and added to the sudoers group use the command below

    id USERNAME

Done, you can login with

    ssh USERNAME@xxx.xxx.xxx.xxx

Update/Upgrade system

    sudo apt update && sudo apt dist-upgrade -y && sync

Install bash-completion (So you can auto complete with "TAB") and

    sudo apt install -y bash-completion && sync

Install this too and restart

    sudo apt install -y libxt6 libxmu6 nano && sync
    sudo shutdown -r now

## Accessing your host's folder from within the VM

Skip to the next part if you don't need it or prefer SCP

### FOR VIRTUALBOX (I don't use virtual box anymore, this part might me outdated)

Host-Guest folder sharing

This part was created some time ago and it may or may not be 100% accurate anymore
Skip to the next part if you don't need it or is using libvirt/qemu

1. Open VirtualBox
2. Right-click your VM, then click Settings
3. Go to Shared Folders section
4. Add a new shared folder and name it "sharedf" without quotes (can't be just "shared")
5. On Add Share prompt, select the Folder Path in your host that you want to be accessible inside your VM.
6. In the Folder Name field, type shared
7. Uncheck Read-only. Check auto-mount and Make Permanent
8. Start your VM
9. Once your VM is up and running, go to Devices menu -> Insert Guest Additions CD image menu but don't run it, cancel if it asks

Install dependencias for VirtualBox guest additions

Still testing this one

    sudo apt install virtualbox-guest-x11
    sudo VBoxClient --clipboard

Create cdrom folder in case it doesn't exist

    sudo mkdir /media/cdrom

Mount it

    sudo mount /dev/cdrom /media/cdrom

Go into cdrom

    cd /media/cdrom

Go into root user

    sudo su

Install Guest Additions

    ./VBoxLinuxAdditions.run

Reboot VM

    sudo shutdown -r now

Create "shared" directory in your home

    sudo mkdir /mnt/shared

Mount the shared folder from the host to your /mnt/shared directory

    sudo mount -t vboxsf sharedf /mnt/shared

The host folder should now be accessible inside the VM

    cd /mnt/shared

Make the folder persistent
Edit fstab file in /etc directory

    sudo nano /etc/fstab

Add the following line to fstab (sparated by tabs) and press Ctrl+O (Letter O, NOT number 0)
then ENTER to Save and Ctrl+X to leave

    sharedf	/mnt/shared	vboxsf	defaults	0	0

Edit modules

    sudo nano /etc/modules

Add the following line to /etc/modules and press Ctro+O then ENTER to Save and Ctrl+X to leave

    vboxsf

Reboot the VM and log-in again

    sudo shutdown -r now

Go to your /mnt directory and check to see if the file is highlighted in green.

    cd /mnt
    ls

If it is then congratulations! You've linked the directory within your vm with your host folder.

You may want to link it to your home folder for faster access

    ln -svf /mnt/share ~/

Repeat the steps above if you want to link another directory, they must have unique names

## LIBVIRT/QEMU

Host-Guest folder sharing

Skip to the next part if you don't need it or is using VirtualBox

1. Turn off your VM if it's on
2. Go to "Details" tab
3. Click on "Add Hardware" button and Select "Filesystem"
4. Change "Driver" to "virtio-9p"
5. Change "Source path" to the path of the folder you want to share, ctrl+c and ctrl+v it's path
6. "Target path" must be a UNIQUE NAME, I'll use "share" and click "Finish"
7. Click on "Filesystem UNIQUE NAME" you just created and click on the "XML" tab
8. On the first line, change the "accessmode" from "mapped" to "passthrough"
9. Click "Apply"
10. Repeat steps above if you want to share another folder
11. Start your VM


Install drivers for Servers just in case it's not already installed

    sudo apt install -y linux-image-extra-virtual

Install qemu-guest-agent

    sudo apt install -y qemu-guest-agent

Check if guest agent is running

    systemctl status qemu-guest-agent.service

If it's not saying "active (running)", enable it

    sudo qemu-ga --daemonize

Create your "share", must be the same as the one you named in "Target path" folder

    sudo mkdir /mnt/share

Edit your /etc/fstab

    sudo nano /etc/fstab

Paste the following at the bottom, don't forget to use the same name you used earlier

    share /mnt/share 9p defaults,trans=virtio,rw 0 0

Save (CTRL+O) and quit (CTRL+X)

Reload the daemon and auto mount your drives

    sudo systemctl daemon-reload && sudo mount -a

Check to see if you can see the contents of the folder.

    ls /mnt/share

If you can then congratulations! You've linked the directory within your vm with your host folder.

You may want to link it to your home folder for faster access

    ln -svf /mnt/share ~/

Repeat the steps above if you want to link another directory, they must have unique names

## Permission issues with mounted folders

IF you have any permission issues with VirtualBox or Libvirt/QEMU you can try
DO NOT USE IF YOU'RE NOT HAVING ANY ISSUES

    sudo chown -R "$(logname):$(logname)" shared
    sudo chmod 755 shared

## Secure Copy Protocol (SCP) (if you're not using the solutions above)

Install SSH if you haven't already

    sudo apt install -y ssh

Enable and start it

    sudo systemctl enable --now ssh.service

Done. Now you have SSH installed which provides SCP (Secure Copy Protocol) which is what
we'll be using to share files between the PC and the Server

To transfer files from the PC to the Server you type
"scp /path/to/file name@address:/path/to/destination" like so:

    scp ~/downloads/image.png vm@192.168.100.100:~/downloads


This will copy the "image.png" from the host machine to the ~/downloads folder of the server folder

If you want to transfer a folder instead, you use -r before the paths like so

    scp -r ~/downloads/images vm@192.168.100.100:~/downloads

This will copy the "images" folder and all its contents into the server's downloads folder

If you're inside your server and want to get a file or folder from the PC you do the inverse

    scp host@192.168.200.200:~/downloads/image.png ~/downloads

NOTE: The first time you run these commands you'll be prompted to trust (or not) the connection

NOTE: You'll need to type the password to be able to finish the commands,
those are the login passwords of each respective machine.

So if you don't know the password of any of the machines you won't be able to run the above commands,
unless the owner/administrator of each machine Set up an alternate althentitation that will let you
run those commands without problems

If you're using an SSH-Key you must add "-i /path/to/id_rsa" after "scp"
And the password is the passphrase you used when creating the SSH-Key

## OPTIONAL, CONFIGURING FIREWALL (Recommended if hosting for others to play)

This can be skipped if you're using only local hosting for testing purposes

Install ufw

    sudo apt install -y ufw

Enable it as a service

    sudo systemctl enable --now ufw

Now we want to enable it through ufw itself

    sudo ufw enable

That's it. Here are some ports you may want to allow:

SSH
This port is TCP

    sudo ufw allow 22/tcp

Default NWN's Server Port (Change 5121 to whatever port you're using)
This port is UDP

    sudo ufw allow 5121/udp

If you're hosting more than one server you can allow a range of ips like so
All the ports you're going to use are UDP

    sudo ufw allow 5121:5123/udp

## Install necessary prereqs

    NO LONGER NEEDED ON 20.04 LTS ONWARDS
    On 64bit systems, we need to manually add support for 32bit architecture
    sudo dpkg --add-architecture i386

We use a new compiler which may not be available by default, so add an extra place to download packages from

    sudo add-apt-repository ppa:ubuntu-toolchain-r/test && sync

Redownload manifests for the newly added architecture and repository so we can use them (and upgrade existing ones)

    sudo apt update && sudo apt dist-upgrade -y && sync

Install necessary dependencies

    sudo apt install -y dkms build-essential linux-headers-generic linux-headers-"$(uname -r)" linux-image-extra-virtual binutils binutils-dev nano && sync

Install tools needed to build NWNX

    sudo apt install -y g++-16 g++-16-multilib gcc-16 gcc-16-multilib cmake git make unzip && sync

Install SSL and Audio/MIDI dependencies

    sudo apt install -y libssl3 libssl-dev libsndio7.0 libsndio-dev && sync

### OPTIONAL, install redis if you're going to use it

    sudo apt install redis -y

##
### THIS PART IS FOR ARM 64 SYSTEMS

Use this command instead of the above

    sudo apt install g++ gcc cmake git make unzip libcapstone-dev pkg-config -y
    sudo cp /usr/lib/aarch64-linux-gnu/pkgconfig/capstone.pc /usr/lib/pkgconfig
##

## Databases, choose only one

### MariaDB (Recommended over MySQL)

Install stuff needed to build/run/use MariaDB
Don't forget to improve your MariaDB security
https://wiki.archlinux.org/title/MariaDB#Improve_initial_security

    sudo apt install -y mariadb-server libmariadb3 libmariadb-dev libmariadb-dev-compat apparmor-utils && sync

Disable its service in case it auto started

    sudo systemctl disable --now mariadb

Add yourself to MySQL group

    sudo usermod -aG mysql $USER

Set mariadb to apparmor complain mode

    sudo aa-complain /etc/apparmor.d/mariadbd

Reboot

    sudo shutdown -r now

Run this command

    sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

Now you can enable it

    sudo systemctl enable --now mariadb

Improve mariadb security

    mariadb-secure-installation

Press "n" for both of the following prompts

    Switch to unix_socket authentication [Y/n] n
    Change the root password? [Y/n] n

Press "y" for the remaining of the prompts

    Remove anonymous users? [Y/n] y
    Disallow root login remotely? [Y/n] y
    Remove test database and access to it? [Y/n] y
    Reload privilege tables now? [Y/n] y

### SQLITE (NO GUIDE FOR IT YET)

    sudo apt install -y sqlite3 sqlitebrowse && sync

### POSTGRESQL (NO GUIDE FOR IT YET)

    sudo apt install -y postgresql postgresql-contrib postgresql-client-common && sync

Reboot the VM and log-in again (also this is a good time to create a snapshot)

    sudo shutdown -r now

## Download and build NWNX

Get latest source from github, with --depth=1 we don't need all their commits history

    git clone --depth=1 --recursive https://github.com/nwnxee/unified.git ~/nwnx && sync


Make a directory where the build system will initialize even though there's already a Build folder (with upper case B)

    mkdir ~/nwnx/nwnx-build && sync && cd ~/nwnx/nwnx-build

Initialize the build system to use GCC version 16, for 64bit. Build release version of nwnx, with debug info
Ignore Doxygen, PostgreSQL, Ruby, SWIG and HUNSPELL errors, you don't need them, unless you know what you're doing

    CC="gcc-16 -m64" CXX="g++-16 -m64" cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../ && sync

##
### THIS PART IS FOR ARM 64 SYSTEMS

Use this command instead of the above

    cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../

##

Build NWNX, in X threads (Where X is your CPU thread count + 1). This will take a while

    make -j5 && sync

##
### Updating NWNX:EE

THIS PART IS NOT NEEDED IF YOU'RE FOLLOWING THIS TUTORIAL FOR THE FIRST TIME

Update nwnx from older version. delete nwnx folder and redo the above steps (from line 411 through 436)
##

## Download NWN dedicated server

Make a directory to hold NWN data

    mkdir ~/nwn && sync && cd ~/nwn

Fetch the NWN dedicated server package. Replace "8193.37-17" with current NWN build version
You can check the latest version here: https://nwn.beamdog.net/downloads/

    wget https://nwn.beamdog.net/downloads/nwnee-dedicated-8193.37-17.zip && sync

Unpack the server to current directory - ~/nwn

    unzip nwnee-dedicated-8193.37-17.zip -d . && sync

##
### Updating NWN dedicated server

THIS PART IS NOT NEEDED IF YOU'RE FOLLOWING THIS TUTORIAL FOR THE FIRST TIME
Update from older version

    cd ~/nwn
Fetch the NWN dedicated server package. Replace 8193.37-17 with current NWN build version

    wget https://nwn.beamdog.net/downloads/nwnee-dedicated-8193.37-17.zip

Unpack the server to current directory - ~/nwn

    unzip nwnee-dedicated-8193.37-17.zip -d .

Press A to overwrite everything

##

### NWServer first-run

Run it once to create the user directory.
nwserver must be run with current directory the same as the executable, so we need to 'cd' into it first

    cd ~/nwn/bin/linux-x86 && ./nwserver-linux

##
### ARM64 NWServer first-run

Use this command instead of the above

    mkdir -p bin/linux-arm64 && cd bin/linux-arm64

Now you need arm64's nwserver-linux.

On another computer, download NWNEE from steam

Still on the other computer, copy it to the server from the "linux-arm64" folder

    scp '/path/to/linux-arm64/nwserver-linux' USERNAME@xxx.xxx.xxx.xxx:~/nwn/bin/linux-arm64/

Back on the server, go to linux-arm64 folder and run nwserver

    cd ~/nwn/bin/linux-arm64 && ./nwserver-linux

##

### User Directory

The user directory path is long and contains spaces, which is hard to type sometimes.
So we create a link (shortcut) to it as ~/nwn/userdir so it's easier to access

    ln -sv ~/.local/share/Neverwinter\ Nights/ ~/nwn/userdir

### Setting up your server

Copy your module/hak/tlk/etc files to ~/nwn/userdir

Edit ~/nwn/userdir/nwnplayer.ini to your preference

### Set up version control on the servervault

This is useful so you can restore player character backups if something goes wrong at any time

    cd ~/nwn/userdir/servervault

We'll use git for version control since that's what NWNX uses.
Run the following commands

    git init
    git config --global user.name = "My Name"
    git config --global user.email = "my@email.com"

OPTIONAL - Change the default branch name to "main" (instead of master)

    git config --global init.defaultBranch main

### Setting up the Database for the servervault

### MARIADB/MYSQL

If using mariadb run the following command

    sudo mariadb

If using mysql run the following command

    sudo mysql

The following commands are the same for mariadb/mysql

We want to configure mysql/mariadb itself.

    USE mysql;

Create a new user for nwserver to use. 'nwn' is username, 'pass' is password, change them.

    CREATE USER 'nwn'@'localhost' IDENTIFIED BY 'pass';

Give it full access

    GRANT ALL PRIVILEGES ON *.* TO 'nwn'@'localhost';

Apply changes

    FLUSH PRIVILEGES;

Create a database for the module to use, typically named same as module, but can be anything.

    CREATE DATABASE mymodulename;

Quit

    exit;

### SQLITE

If you know how to configure SQLite and/or PostgreSQL let me know so I can update here

### POSTGRESQL

If you know how to configure SQLite and/or PostgreSQL let me know so I can update here

##
### Dubious ownership

If you get an error about "Dubious ownership" just run the below command make sure
that it matches your server vault path, this usually happens when you're using the shared
folder for the servervault instead of a folder "fully" inside the guest vm.

Run this command both in Host and in the VM with their respective correct paths

    git config --global --add safe.directory ~/shared/nwn/servervault
##

### OPTIONAL, Server management scripts

Install and enable cron for managing your script automations

    sudo apt install -y cron
    sudo systemctl enable --now cron

For simplicity sake, clone this repo in the server's home folder

    git clone --depth=1 https://github.com/StefanoND/NWNXEE-SETUP.git ~/NWNXEE-SETUP && sync

Copy them into your /home/ folder

    cp ~/NWNXEE-SETUP/nwnx_files/* ~/

The above will copy these scripts to your home directory

    mod-disable.sh - disables server auto restart
    mod-enable.sh - enables server auto restart
    mod-savechars.sh - creates a backup of all characters automatically
    mod-start.sh - starts the server unless already running
    mod-status.sh - Tells the mod-start.sh script if the server is running or not
    mod-stop.sh - kills the server

cd to your home directory if you haven't already

    cd ~

Need to mark the scripts above as executable

    chmod +x mod-*.sh


Create a place where logs will be stored

    mkdir ~/logs

Edit the mod-savechars.sh script if you have you setup your servervault somewhere else

    nano mod-savechars.sh

Edit the mod-start.sh script to further customize. You can use any other text editor instead.

    nano mod-start.sh

If you have setup Redis you may want to check mod-stop.sh aswell

    nano mod-stop.sh

Set up cronjob for auto server restart every 5 seconds

Cron lets you run some script at specified intervals. You need to run this command, and then add the line exactly as given below

    crontab -e

Add these lines

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

Start the server. If it goes down, the cron job will restart it again within 5 seconds.

    ./mod-start.sh

To stop the server from auto-starting run the mod-disable script

    ./mod-disable.sh

When you're done and want to enable auto-start, run the mod-enable script

    ./mod-enable.sh
