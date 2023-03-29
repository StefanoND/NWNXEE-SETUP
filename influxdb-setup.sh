###########################################################################################################
################################################ IMPORTANT ################################################
###########################################################################################################
## NOTE: YOU MUST ENABLE NWNX_TRACKING, NWNX_DIAGNOSTICS, NWNX_METRICS_INFLUXDB AND NWNX_OBJECT PLUGINS  ##
##       ALSO, YOU MUST CREATE THEIR RESPECTIVE SCRIPTS IN THE MODULE AND THEIR DEPENDENCIES OR ELSE     ##
##       YOUR GRAFANA WILL RETURN "No Data"                                                              ##
###########################################################################################################
# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 20.04 Desktop install:
#------------------------------------------------------------------------------
# Open ports 8086(TCP) 8088(TCP) 8089(UDP) and 3000 (TCP/UDP)
#
# Increase UDP Buffer to 25MB (or higher)
sudo sysctl -w net.core.rmem_max=26214400
sudo sysctl -w net.core.rmem_default=26214400
#
#Import GPG Key
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
#
# Add repo to Ubuntu 22.04
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
#
# Update apt index and install InfluxDB
sudo apt update -y && sudo apt upgrade -y
sudo apt install influxdb -y
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
# Add GPG Key
curl https://packages.grafana.com/gpg.key | sudo apt-key add -
#
#
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
#
# Update
sudo apt update -y && sudo apt upgrade -y
#
# Install Grafana
sudo apt install grafana -y
#
# Reload Daemon
sudo /bin/systemctl daemon-reload
#
# Enable grafana to be run as a service
sudo /bin/systemctl enable --now grafana-server
#
####################################################################################
## For this part you probably will need a GUI if you don't have a way to acces it ##
####################################################################################
## Install tasksel
# sudo apt install tasksel
#
## Install Desktop environment, you can check which desktops are available
## with "tasksel --list-tasks" without quotes I chose the default minimal
# sudo tasksel install ubuntu-desktop-minimal
#
## Wait for it to finish (around 10 mins depending on your system)
## Reboot
# shutdown -r now
#
## At this point, GUI should be working without any problem if not, make sure
## your system is booting into the graphical.target
# sudo systemctl set-default graphical.target
####################################################################################
#
# Visit Grafana, change "localhost" to your site
http://localhost:3000
Username: admin
Password: admin
Change your password
#
# Create a new Datasource (InfluxDB)
Visit: http://localhost:3000/datasources/new
Select InfluxDB
# Change these parts
Name: NWN
URL: http://localhost:8086
Access: Server (Default)
Database: metrics
User: nwn
Password: pass
#
# Now let's add the dashboards
Visit: http://localhost:3000/dashboard/import
#
# Use the .json files from the website below or from the folder in here
https://github.com/urothis/nwnxee-docker-template/tree/master/grafana-provisioning/dashboards
