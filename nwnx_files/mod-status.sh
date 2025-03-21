#!/usr/bin/env bash

STATUS=0

while read -r line; do
  if output=$(ps -p "$line" >/dev/null 2>&1); then
    STATUS=1
  fi
done <~/.modpid

echo "$STATUS"
