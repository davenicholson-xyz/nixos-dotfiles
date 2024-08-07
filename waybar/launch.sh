#!/usr/bin/env bash

THEME="dark"

# Terminate already running bar instances
pkill -9 waybar 
# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done 

waybar -c $HOME/.dotfiles/waybar/$THEME/config -s $HOME/.dotfiles/waybar/$THEME/style.css &

