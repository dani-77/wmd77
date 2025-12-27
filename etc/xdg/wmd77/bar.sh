#!/bin/bash

status() {
    # Date and time
    DATE=$(date '+%a %d %b %Y, %H:%M')
    
    # Weather
    WEATHER=$(curl wttr.in/?format=1 | awk '{ print $2 }')

    # Memory usage
    MEMORY=$(free -m | grep '^Mem' | awk '{print "Mem: " $3 "MB/" $2 "MB"}')
    
    # CPU usage
    CPU=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print $1"%"}')
    
    # Wlan
	WLAN_STATE=$(cat /sys/class/net/wl*/operstate 2>/dev/null | head -1)
    if [ "$WLAN_STATE" = "up" ]; then
        WLAN="Connected"
    else
        WLAN="Disconnected"
    fi

    # Volume
    VOLUME=$(amixer get Master | grep -o '[0-9]*%' | head -1)
    
    # Battery percentage
    BATTERY=$(acpi -b | grep -o '[0-9]*%' | head -1)
    
    # Combine all info with prefixes
    echo "$WEATHER | CPU: $CPU | $MEMORY | $WLAN | Volume: $VOLUME | Battery: $BATTERY | $DATE"
}

while true; do
    xsetroot -name "$(status)"
    sleep 2
done &
