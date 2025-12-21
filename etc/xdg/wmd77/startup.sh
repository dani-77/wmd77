#!/bin/bash

feh --bg-fill --randomize ~/Wallpaper/ &
synclient TapButton1=1 &
udiskie -a &
xcompmgr -c -f -n &
xautolock -time 5 -locker slock &
redshift -l 41.16:-8.62 &
sh /etc/xdg/wmd77/bar.sh
