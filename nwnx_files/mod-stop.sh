#!/usr/bin/env bash

echo "Shutting down the server"
# If you use redis and have added a "server" channel and subscribed the "shutdown" event
# you can uncomment the lines bellow
# echo PUBLISH server shutdown | redis-cli
# sleep 5
cat ~/.modpid | xargs kill -9
