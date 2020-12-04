#!/bin/bash

export PATH=/home/USER/nwsync

pushd /home/USER/nwsync

# Example ./nwsync_write --description="Download" /home/ecsyend/www/nwsync/nwsyncdata /home/ecsyend/nwn/modules/module.mod
./nwsync_write --description="Module's Required Files" /home/USER/www/nwsync/nwsyncdata ~/nwn/userdir/modules/module.mod
