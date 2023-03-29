#!/bin/bash

# Change USER to your username
export PATH=/home/USER

pushd $PATH/nwsync

# Example ./nwsync_write --description="Download" $PATH/www/nwsync/nwsyncdata $PATH/nwn/modules/module.mod
./nwsync_write --description="Module's Required Files" $PATH/www/nwsync/nwsyncdata $PATH/nwn/userdir/modules/module.mod
