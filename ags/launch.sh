#!/usr/bin/env bash

THEME="bar"

# Terminate already running bar instances
ags -b bar -q
# Wait until the processes have been shut down
while pgrep -x ags >/dev/null; do sleep 1; done 

ags -b bar -c $HOME/.dotfiles/ags/${THEME}/config.js

