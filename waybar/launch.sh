#!/usr/bin/env bash

# Terminate already running bar instances
pkill -9 waybar 
# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done 
# Launch main
# waybar >/dev/null 2>&1 &
waybar -c /home/dave/.dotfiles/waybar/config -s /home/dave/.dotfiles/waybar/style.css &

