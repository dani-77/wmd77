#!/bin/bash

feh --bg-fill ~/Wallpaper/wall_macos3.jpg &
synclient TapButton1=1 &
udiskie -a &
xcompmgr -c -f -n &
xautolock -time 5 -locker slock &
#i3status | dzen2 -p -h 24 -ta r
sh /etc/xdg/wmd77/bar.sh
