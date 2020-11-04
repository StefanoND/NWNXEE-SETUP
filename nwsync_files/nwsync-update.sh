#!/bin/bash

export PATH=~/nwsync

pushd ~/nwsync

# Example ./nwsync_write --description="Download" /home/ecsyend/www/nwsync/nwsyncdata /home/ecsyend/nwn/modules/module.mod
./nwsync_write --description="Module's Required Files" /home/USER/www/nwsync/nwsyncdata /path/to/modules/module.mod
