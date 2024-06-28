#!/usr/bin/env bash

# Run this once NixOS has been built and switched for the first time

# Make symlink for dunst config from pywal generated config
ln -s $HOME/.cache/wal/dunstrc $HOME/.config/dunst/dunstrc
