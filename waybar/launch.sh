#!/usr/bin/env bash

# Terminate already running bar instances
pkill -9 waybar 
# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done 

waybar -c /home/dave/.dotfiles/waybar/$1/config -s /home/dave/.dotfiles/waybar/$1/style.css &

