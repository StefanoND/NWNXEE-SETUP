#!/#!/usr/bin/env bash

if [ $EUID -ne 0 ]; then
  echo
  echo "This script must run as root (sudo) to function."
  echo
  sleep 1s
  exit 1
fi

HOMEPATH="$HOME"
pushd "$HOMEPATH/nwsync"

# Example ./nwsync_write --description="Download" "$HOMEPATH/www/nwsync/nwsyncdata" "$HOMEPATH/nwn/modules/module.mod"
./nwsync_write --description="Module's Required Files" "$HOMEPATH/www/nwsync/nwsyncdata" "$HOMEPATH/nwn/userdir/modules/module.mod"

exit 0
