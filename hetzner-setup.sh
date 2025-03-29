# This is not a runnable file
#
# Check: https://nwn.wiki/display/NWN1/NWServer+Recommendations
# OS: Linux (with NWNX)
# CPU: Fast CPU speed, with 2 or more cores
# RAM: 4GB minimum to 16GB maximum (heavily OS and module / hakpack size dependant, make sure to test!)
# Disk: Fast SSD with enough space for uploading new versions of files (eg 30GB OS + nwserver base + 10GB hakpacks means you need around 60GB minimum for having 2 copies of the hakpacks at once).
# Network: Dedicated IP address with sufficient bandwidth and appropriate UDP firewall ports open
#
# With that out of the way, I chose hetzner be cause offer alot for cheap
# I'll choose Hetzner Cloud
#
# Create a Server:
#
# Location: Choose one
#
# Image:
# OS images: Ubuntu 24.04
#
# Type
# Shared vCPU: Arm64 (Ampere) (Even though NWNEE doesn't CURRENTLY support ARM64, it will in patch .36)
# CAX11 (2 vCPUs, 4GB RAM and 40GB SSD) is suggested (You can choose the other options based on the Info above)
#
# Networking:
# Public IPv4: ENABLED
# Public IPv6: DISABLED (We won't be using it)
# Private Networks: DISABLED (Unless you plan to have multiple servers each running a NWServer)
#
# SSH Keys (Check the end of this file on how to create an SSH-Key)
# Click "+ Add SSH Key" and paste the ssh-key into there, the name will be put automatically (Which will be your COMMENT)
# If you enable "Set as default key" every new serer you create in hetzner will use this SSH-Key, this is not recommended, it's convenient but not very secure
#
# Volumes
# Not needed
#
# Backups
# It's up to you, you'll be charged 20% of the server's price (So the 4.05 one will cost 4,86. The 7,37 one will cost 8,84, etc)
# I personally don't use it since the important things are the player's charactes and databases which are vey small
# And I have scheduled a hourly backup
#
# Labels
# It's up to you. I don't use them
#
# Cloud config
# WiP you can check their website for a basic cloud-config https://community.hetzner.com/tutorials/basic-cloud-config
#
# Name
#
########################################################################
#                           CREATING SSH-KEY                           #
########################################################################
#
# Go in the terminal and type this, replace "COMMENT" with something that will help you identify this SSH Key.
# Examples:
#   ssh-keygen -t rsa -b 4096 -C "My Awesome Server (MAIN)"
#   ssh-keygen -t rsa -b 4096 -C "My Server - PTR"
ssh-keygen -t rsa -b 4096 -C "COMMENT"
#
# It'll now ask for a name, I suggest something simple, and maybe even prefix/suffix "id_rsa" into the filename like:
server_id_rsa
#
# It'll now ask you to add a passphrase, if you have pwgen installed you can create a random one
pwgen -cnysB 16 8
#
# Now you must copy the ID created into "Add an SSH Key", sometimes the created key will be in $HOME and not $HOME/.ssh
cat $HOME/.ssh/server_id_rsa.pub
#
# It'll look like this, where "COMMENT" is what you typed in the comment during the SSH-Key creation
ssh-rsa RANDOMSTUFFHERE COMMENT
#
# You'll be able to login with this command in the terminal
ssh root@xxx.xxx.xxx.xxx -i $HOME/.ssh/server_id_rsa
