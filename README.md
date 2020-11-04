# NWNXEE-SETUP
Thanks to mtijanic: https://github.com/mtijanic
Thanks to orth: https://github.com/plenarius

Almost all content are modified/updated version of their guides

## NWNX Server setup

Instructions on how to setup a NWNX Server:

- nwnx-setup.sh (This is not a runnable file)

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

## NWNX_PROFILER Setup

Instructions on how to setup InfluxDB and Grafana for NWNX_PROFILER:

- influxdb-setup.sh (This is not a runnable file)

| File Name               | Function                                |
| ----------------------- | --------------------------------------- |
| Activity.json           | File for Profiling Player's Activities  |
| Network_Messages.json   | File for Profiling Network Messages     |
| Pathing_Data.json       | File for Profiling Pathing from Objects |
| SQL_Data.json           | File for Profiling SQL Actions          |
| Script_Data.json        | File for Profiling Scripts              |
| Server_Performance.json | File for Profiling Server Performance   |
| nwn.yml                 | File for Data Source                    |
