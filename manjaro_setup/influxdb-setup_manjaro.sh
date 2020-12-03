# NOTE: This is not a runnable file - you need to manually paste the lines one by one
# Take some time to understand what each command does.
# These steps were tested on a clean Ubuntu 18.04 Desktop install:
#------------------------------------------------------------------------------
# Open ports 8086(TCP) 8088(TCP) 8089(UDP)
#
# Increase UDP Buffer to 25MB (or higher)
sudo sysctl -w net.core.rmem_max=26214400
sudo sysctl -w net.core.rmem_default=26214400
#
# Install InfluxDB
sudo pacman -S influxdb --noconfirm
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
# And quit
quit
#
# Install Grafana
sudo pacman -S grafana --noconfirm
#
# Reload Daemon
sudo systemctl daemon-reload
#
# Enable grafana to be run as a service
sudo systemctl enable grafana.service
#
# Start grafana as service
sudo systemctl start grafana.service
#
# Visit Grafana, change "localhost" to your site
http://localhost:3000
Username: admin
Password: admin
Change your password
#
# Create a new Datasource (InfluxDB)
http://localhost:3000/datasources/new
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
http://localhost:3000/dashboard/import
#
# Use the .json files from the website below or from the folder in here
https://github.com/urothis/nwnxee-docker-template/tree/master/grafana-provisioning/dashboards
