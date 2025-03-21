#!/usr/bin/env bash

STATUS="Server is running"

while read -r line; do
  if output=$(ps -p "$line" >/dev/null 2>&1); then
    STATUS="Server is not running"
  fi
done <~/.modpid

echo "$STATUS"
