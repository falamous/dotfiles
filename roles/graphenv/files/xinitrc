#!/bin/sh

wallpaper &                         # set wallpaper
picom &                             # compositor for transperancy
unclutter &                         # remove mouse when idle
xset r rate 250 50 &                # speed xrate up
dunst &                             # notifications
light -S 40                         # screen brightness
greenclip daemon &                  # clipboard manager
xautolock -time 10 -locker slock &  # screen locker
pkill mpd && mpd                    # music player daemon
checkmac                            # check that mac addresses are changed
# bling &                             # for AnimeMatrix

xinput set-prop 15 'libinput Disable While Typing Enabled' 0
xrandr --output 'eDP-1' --mode '1920x1080' --rate '60'

alacritty -e false                  # wait for a window to spawn and then set xorg settings
mirrormonitor                       # mirror monitors kek

ssh-agent qtile start

kill $(jobs -p)                     # kill all jobs
pkill .xinitrc                      # kill all instances of .xinitrc after shutting down xorg
