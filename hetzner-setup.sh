# This is not a runnable file
#
# Info:
# NWServer only uses 1 (ONE) CPU Core/Thread, having more than 1 core/thread in your system will only be beneficial if the OS itself is using too much CPU
# 2GB-4GB of RAM is enough for (almost) all servers (specially if single servers) (Unless you have multiple very populated servers)
# 20 GB is more than enough for most servers (Unless you have really HUGE hakpaks or installing non-minimal server OSes)
#
# With that out of the way, I chose hetzner be cause offer alot for cheap
# I'll choose we'll use Hetzner Cloud
#
# Create a Server:
# 
# Location: Choose one
#
# Image:
# OS images: Ubuntu 22.04
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
# Firewalls (Check the end of this file on how to create the Firewall Rules)
# Select the one you created
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
########################################################################
#                               FIREWALL                               #
########################################################################
#
# The following are the ports required to open for each platform
#
# Don't forget to forward the port you're gonna host the server (Usually within the 5120-5300 range 5121 being the most common one, UDP and both inbound and outbound)
# Note: The ports 3074 and 5121 ports are used on more than one platform so no need do add them twice or three times in the firewall rules
#
# Inbound Rules
#
#   Global:
#     TCP: 22 (SSH)
#     UDP: 80 (WWW)
#
#   Docker:
#     TCP: N/A
#     UDP: 53778
#   PC:
#     TCP: N/A
#     UDP: 5112
#
#   PS4:
#     TCP: 1935, 3478-3480
#     UDP: 3074, 3478-3479, 5121
#
#   Steam
#     TCP: 27015-27030, 27036-27037
#     UDP: 4380, 5121, 27000-27031, 27036
#
#   Nintendo Switch
#     TCP: 6667, 12400, 28910, 29900, 29901, 29920
#     UDP: 1-65535 (NOT RECOMMENDED)
#
#   XBox One
#     TCP: 3074
#     UDP: 88, 500, 3074, 3544, 4500, 5121
#
# Outbound Rules
#
# Global
#   UDP: Only the Server's port (Usually 5121)
