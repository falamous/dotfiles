#!/bin/sh

wallpaper &                         # set wallpaper
picom &                             # compositor for transperancy
unclutter &                         # remove mouse when idle
xset r rate 250 50 &                # speed xrate up
dunst &                             # notifications
light -S 40                         # screen brightness
greenclip daemon &                  # clipboard manager
xautolock -time 10 -locker slock &  # screen locker
# bling &                             # for AnimeMatrix


alacritty -e false                  # wait for a window to spawn and then set xorg settings
mirrormonitor                       # mirror monitors kek

ssh-agent qtile start

kill $(jobs -p)                     # kill all jobs
pkill .xinitrc                      # kill all instances of .xinitrc after shutting down xorg
