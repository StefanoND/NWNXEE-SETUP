# NWNXEE-SETUP
Tutorial for Ubuntu Server 20.04 LTS

Clone this repo with:

    git clone https://github.com/StefanoND/NWNXEE-SETUP.git
#
Changelog

    Manjaro Section removed (it's not meant for server use)
    Currently updating repo where it needs
#

Thanks to mtijanic, orth, daz, Urothis, niv and all NWN/NWNX community

Almost all content are modified/updated version of their guides

NWNXEE Repo: https://github.com/nwnxee/unified

## NWNX Server setup

Instructions on how to setup a NWNX Server:

- nwnx-setup.sh (This is not a runnable file)

Original Guide: https://github.com/mtijanic/nwn-misc/blob/master/nwnx-server-setup/nwnx-setup.sh

Files to maintain the NWNX Server:

| File Name        | Function                                 |
|------------------| ---------------------------------------- |
| mod-start.sh     | starts the server unless already running |
| mod-stop.sh      | kills the server                         |
| mod-disable.sh   | disables server auto restart             |
| mod-enable.sh    | enables server auto restart              |
| mod-savechars.sh | saves servervault/ to git                |
| mod-status.sh    | returns 1 if server is running, 0 if not |

## NWSync Setup

Instructions on how to setup NWSync and a Database for it:

- nwsync-setup.sh (This is not a runnable file)

Files to use for setup/update nwsync files

| File Name            | Function                     |
| -------------------- | ---------------------------- |
| nwsync-update.sh     | File to update NWSync        |
| nwsync_GUI_update.sh | File to update NWSync GUI    |
| index.html           | File for NGINX (Lines 49-51) |
| nwsync               | File for NGINX (Lines 53-55) |

## NOIP Setup

Instructions on how to setup No-ip2 for static IP address:

- noip-setup.sh (This is not a runnable file)

## NWNX_PROFILER Setup

Instructions on how to setup InfluxDB and Grafana for NWNX_PROFILER:

- influxdb-setup.sh (This is not a runnable file)

Original Guide: https://gist.github.com/plenarius/8555685b71b42327f899c12fff960e89

Files for Dashboards/Data Source creation

| File Name               | Function                                |
| ----------------------- | --------------------------------------- |
| Activity.json           | File for Profiling Player's Activities  |
| Network_Messages.json   | File for Profiling Network Messages     |
| Pathing_Data.json       | File for Profiling Pathing from Objects |
| SQL_Data.json           | File for Profiling SQL Actions          |
| Script_Data.json        | File for Profiling Scripts              |
| Server_Performance.json | File for Profiling Server Performance   |
| nwn.yml                 | File for Data Source                    |
