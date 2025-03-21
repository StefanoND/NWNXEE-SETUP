#!/usr/bin/env bash

pushd ~/nwn/userdir/servervault
git add .
git commit -am "servervault-backup-$(date +%s)"
popd
