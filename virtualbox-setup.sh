# Thankfully the process is the same on all OSes (besides installation)
#
# WINDOWS
# Go to Oracle's website and download VirtualBox names "Windows Hosts" and it's expansion pack
https://www.virtualbox.org/wiki/Downloads
#
# Direct download for Windows
https://download.virtualbox.org/virtualbox/7.0.6/VirtualBox-7.0.6-155176-Win.exe
#
# Direct download of Expansion Pack
https://download.virtualbox.org/virtualbox/7.0.6/Oracle_VM_VirtualBox_Extension_Pack-7.0.6a-155176.vbox-extpack
#
# MANJARO
sudo pacman -S virtualbox virtualbox-ext-oracle --noconfirm --needed
#
# After installing VirtualBox and its extension pack we can open Virtualbox
# Once VirtualBox is up click on "File->Tools->Network Manager" in "Host-only Networks" tab click "Create"
# In "Adapter" tab select "Configure Adapter Automatically" and in "DHCP Server" enable "Enable Server"
# Leave everything else as is, apply and ok everything.
#
# Click on "New" to create the VM, choose a name, choose the folder to put it, choose ISO image (I'll cover Ubuntu Server 22.04)
# Type and Version will automatically change to Linux and Ubuntu x64 respectively, if not change them accordingly
# Check "Skip Unattended Installation"
#
# Open "Hardware" dropdown, base memory should be between 2GB-8GB (2GB bare minimum, 4GB for nwnxee, 6GB for huge servers, 8GB for overkill)
# Processors: 2 CPU is enough, you can give more if you want, but it's unnecessary
#
# Open "Hard Disk" dropdown, choose size. (32GB should be enough, even with huge hakpaks)
# Int "Hard Disk Type and Variant" Section, "VDI (VirtualBox Disk Image)" is good enough, enable "Pre-allocate Full Size"
#
# Click on "Finish"
#
# Select the VM and click on "Settings" in "General" click on "Advanced" tab and select "Enabled" in bot "Shared Clipboard" and "Drag'n'Drop" drop down
#
# Click on "System" In "Processor" tab enable "Enable PAE/NX"
#
# Click on "Display" section and "Video Memory" put max, and enable "Enable 3D Acceleration" in "Extended Features:"
#
# Click on "Storage" section and click on "vmname.vdi" and enable "Solid-state Drive"
#
# Click on "Network" section, in "Adapter 1" tab in "Attached To:" dropdown select "Bridged Adapter" and select your adapter
# Click on "Advanced" and in "Promiscuous Mode:" dropdown select "Allow All"
# In "Adapter 2" tab in "Attached To:" dropdown select "Host-only Adapter" and select the adapter we created (Probably will be "vboxnet0")
# Click on "Advanced" and in "Promiscuous Mode:" dropdown select "Allow All"
#
# Click on "Shared Folders" section, click on "Add" select the path, "Folder Name:" should be "sharedf", leave everything as is and click "Ok"
#
# Now you can start installing the OS, click no "Start"
#
# In installation select "Try or Install Ubuntu Server"
# Select your language
# Configure your keyboard, you can also try "Identify keyboard"
# Select Ubuntu Server (minimized)
# Leave everything else as is until Profile Setup
# In Profile Setup fill the fields accordingly
# Choose "Skip for now" when asked about ubuntu pro
#
# OPTIONAL: "Install OpenSSH Server", "Import SSH Identity" "from GitHub", "GitHub Username" is your GH username.
# enable "Allow Password auth over SSH" and confirm SSH Keys
#
# Leave everything else as is untill intall finished, once it's finished reboot and done
