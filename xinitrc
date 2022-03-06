#!/bin/sh

#function statusbar_loop(){
#	while :; do
#		statusbar
#		sleep 15
#	done
#}
#
#wallpaper &           # set wallpaper
## statusbar_loop &      # update statusbar continuasly
#picom &               # compositor for transperancy
#unclutter &           # remove mouse when idle
#xset r rate 250 50 &  # speed xrate up
#dunst &               # notifications
#light -S 40           # screen brightness
#greenclip daemon &    # clipboard manager
## bling &               # for AnimeMatrix
#setupkeys
#
#
#st -e exit            # wait for a window to spawn and then set xorg settings
#mirrormonitor         # mirror monitors kek
#
## xrandr --output LVDS1 --auto --scale 1x1 --output VGA1 --auto --left-of LVDS1 --scale 1x1 &&
## setxkbmap -layout us,ru -option grp:lwin_toggle -option caps:escape
#
#mkdir -p $XDG_DATA_HOME/dwm/             # create the log directory
#ssh-agent qtile start 2>&1 | llog                   # start window manager
ssh-agent qtile start &>~/keklolkek
# strace -f qtile start 2>&1 | tee ~/keklolkek

kill $(jobs -p)       # kill all jobs
pkill .xinitrc        # kill all instances of .xinitrc after shutting down xorg
