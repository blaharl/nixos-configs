#!/usr/bin/env bash
#

# initialize wallpaper daemon
# swww-daemon &
# set wallpaper
# swww img ~/Persistent/Pictures/wallpapers/xfce-shapes.png &

nm-applet --indicator &

# the bar
waybar &

# dunst
dunst &

sleep 1 &
# swww restore
