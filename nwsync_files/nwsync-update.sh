#!/usr/bin/env bash

if ! [ $EUID -ne 0 ]; then
  echo
  echo "Don't run this script as root (sudo)."
  echo
  sleep 1s
  exit 1
fi

MODULENAME="module.mod"

HOMEPATH="$HOME"
pushd "$HOMEPATH/nwsync"

# Example nwsync_write --description="Download" "$HOMEPATH/www/nwsync/nwsyncdata" "$HOMEPATH/nwn/modules/$MODULENAME"
sudo "$HOMEPATH/.nimble/bin/nwn_nwsync_write" --description="Module's Required Files" "$HOMEPATH/www/nwsync/nwsyncdata" "$HOMEPATH/nwn/userdir/modules/$MODULENAME"

exit 0
