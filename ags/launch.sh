#!/usr/bin/env bash

THEME="bar"

# Terminate already running bar instances
pkill -9 ags 
# Wait until the processes have been shut down
while pgrep -x ags >/dev/null; do sleep 1; done 

ags -c $HOME/.dotfiles/ags/${THEME}/config.js

