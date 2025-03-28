###########################################################################################################
################################################ IMPORTANT ################################################
###########################################################################################################
## NOTE: YOU MUST ENABLE NWNX_TRACKING, NWNX_DIAGNOSTICS, NWNX_METRICS_INFLUXDB AND NWNX_OBJECT PLUGINS  ##
##       ALSO, YOU MUST CREATE THEIR RESPECTIVE SCRIPTS IN THE MODULE AND THEIR DEPENDENCIES OR ELSE     ##
##       YOUR GRAFANA WILL RETURN "No Data"                                                              ##
###########################################################################################################
# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 24.04 Desktop install:
#------------------------------------------------------------------------------
# Open ports 8086(TCP/UDP) and 3000 (TCP) if you're having issues
#
# Increase UDP Buffer to 25MB (or higher)
sudo sysctl -w net.core.rmem_max=26214400
sudo sysctl -w net.core.rmem_default=26214400
#
# #Import GPG Key
# wget -q https://repos.influxdata.com/influxdata-archive_compat.key
# echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
#
# sudo tee /etc/apt/sources.list.d/influxdb.list
# curl -fsSL https://repos.influxdata.com/influxdata-archive_compat.key | sudo gpg --dearmor -o /usr/share/keyrings/influxdb-keyring.gpg
#
# #
# # Add repo to Ubuntu 22.04
# echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
#
# Install InfluxDB
sudo apt install -y influxdb influxdb-client
#
# By default all users can use InfluxDB with privileges. Let's enable authentication
#
# First create an admin account
# Enter influx
influx
#
# Add admin account
# Change 'PASSWORD' to your desired password, keeping the ''.
# Write them down you'll need them for later
create user admin with password 'PASSWORD' with all privileges
#
# Now let's enable authentication
sudo sed -i "s/.*auth-enabled =.*/  auth-enabled = true/g" /etc/influxdb/influxdb.conf
#
# Reload Daemons
sudo systemctl daemon-reload
#
# Set as system service
sudo systemctl enable --now influxdb
#
# Configure "influxdb.conf"
sudo nano /etc/influxdb/influxdb.conf
#
# Look for the "[[udp]]" section, You''ll see that they'll be commented out
# Uncomment the following lines below and make the changes so they look like this:
#    [[udp]]
#        enable = true
#        bind-address = ":8089"
#        database = "metrics"
# You can use whatever name you want in the "metrics"
#
# ----------------------------------------------------------------------------------------------
#
# After enabling auth, you can access InfluxDB by either one of the next
#
# --------------------------------------
#
# Run InfluxDB CLI and authenticate
influx
#
# Authenticate with auth
auth
#
# --------------------------------------
#
# Add login info on CLI (not recommended)
# Change 'PASSWORD' to your desired password, keeping the ''.
influx -username 'admin' -password 'PASSWORD'
#
# --------------------------------------
#
# Set login info on environment variables (not recommended)
# Change 'PASSWORD' to your desired password, keeping the ''.
export INFLUX_USERNAME='admin'
export INFLUX_PASSWORD='PASSWORD'
#
influx
#
# --------------------------------------
#
# Authenticate on HTTP API (not recommended)
# Change 'PASSWORD' to your desired password, keeping the ''.
curl -G http://localhost:8086/query?pretty=true -u 'admin':'PASSWORD' --data-urlencode "q=show users"
#
# --------------------------------------
#
# NOTE: The last three methods are not recommended be cause you're typing them directly in you terminal
# which will be saved in your shell history, which is unencrypted and doesn't need privileges to
# open/read it's contents, unless you've configured it differently.
#
# ----------------------------------------------------------------------------------------------
#
# Set up database
#
influx
#
# This will open influx in terminal, type
CREATE DATABASE metrics
#
# If you want to check if it was created type
SHOW DATABASES
#
# Now let's use it
USE metrics
#
# And quit
quit
#
# Install Grafana
#
# Install required packages
sudo apt install -y apt-transport-https software-properties-common wget
#
# Create folder for keyrings, if it doesn't exist
sudo mkdir -p /etc/apt/keyrings/
#
# Add Grafana's GPG Key
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg >/dev/null
#
# Add their repo for stable releases
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
#
# Update
sudo apt update -y && sudo apt upgrade -y
#
# Install Grafana Enterprise, it's free. If you decide to subscribe, it'll unlock the enterprise features
sudo apt install grafana-enterprise -y
#
# Reload Daemon
sudo systemctl daemon-reload
#
# Enable grafana to be run as a service
sudo systemctl enable --now grafana-server
#
# For the next part you'll need a browser, if your server doesn't have a graphic interface, you can either
# access from the outside through the address you've setup (like "mysite.com:3000") or from another
# device in your local network through the server's internal IP address (like "191.168.1.100:3000") if you
# can't or won't, you can install a Graphical Interface on the server and connect through it's local ip
# (either "localhost:3000" or "127.0.0.1:3000" they're the same and both works)
####################################################################################
#
# We need a display manager (DM) and a desktop environment (DE) for this.
# We'll use lightdm for DM since it's lightweight and doesn't use much resources and xfce as DE for the
# same reason
sudo apt install -y lightdm xfce4
#
# Let's configure lightdm to use xfce as graphical interface
printf "[SeatDefaults]\nallow-guest=false\nuser-session=xfce\n" | sudo tee /etc/lightdm/lightdm.conf
#
# At this point, GUI should be working without any problem if not, make sure
# your system is booting into the graphical.target
sudo systemctl set-default graphical.target
#
# Wait for it to finish (around 10 mins depending on your system)
# Reboot
shutdown -r now
#
# Done, now you may continue the guide
#
####################################################################################
#
# Visit Grafana, change "localhost" to your site
http://localhost:3000
#
# To log in with the Admin account with these credentials
Username: admin
Password: admin
#
# It'll ask to change your admin password, do it now.
#
# Now we'll need to create a User account
# Now go to the bottom-left and click on "Administration" then "Users and Access" then "Users"
# Now on the right, click on the blue button named "New User", fill in the required fields: name and
# password and click "Create User"
#
# Log out (from you admin account) and log in with the newly created user account
#
# Create a new Datasource (InfluxDB)
http://localhost:3000/datasources/new
# Select InfluxDB
# Change these parts
Name: NWN # You may change the name
# At 'HTTP'
URL: http://localhost:8086 # You'll have to manually type this or copy paste
# At 'Auth' enable 'Basic Auth'
# At 'Basic Auth Details' the same log in info from line 41
User: YOURINFLUXUSERNAME
Password: YOURINFLUXPASSWORD
# At 'InfluxDB Details':
Database: metrics
User: nwn      # You may change the username
Password: pass # You may change the password
HTTP Method: POST
#
# Click on 'Save & Test', you should receive a Green Box telling you that "datasource is working"
#
# Now let's add the dashboards
Visit: http://localhost:3000/dashboard/import
#
# Use the .json files from influxdb_files folder or at the following repo
https://github.com/urothis/nwnxee-docker-template/tree/master/grafana-provisioning/dashboards
#
# You should have 6 dashboards now.
# Reboot your server
sudo reboot
#
# Now you have to configure the mod-start.sh file inside nwnx_files folder to enable InfluxDB and change
# the following vars
#
# The Admin account from Grafana
INFLUXDBADMINUSER='admin'
INFLUXDBADMINPASSWORD='password'
#
# The User account from Grafana
INFLUXDBUSER='nwn'
INFLUXDBUSERPASSWORD='pass'
