#!/bin/bash

status() {
    # Date and time
    DATE=$(date '+%a %d %b %Y, %H:%M')
    
    # Memory usage
    MEMORY=$(free -m | grep '^Mem' | awk '{print "Mem: " $3 "MB/" $2 "MB"}')
    
    # CPU usage
    CPU=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print $1"%"}')
    
    # Volume
    VOLUME=$(amixer get Master | grep -o '[0-9]*%' | head -1)
    
    # Battery percentage
    BATTERY=$(acpi -b | grep -o '[0-9]*%' | head -1)
    
    # Combine all info with prefixes
    echo "CPU: $CPU | $MEMORY | Volume: $VOLUME | Battery: $BATTERY | $DATE"
}

while true; do
    xsetroot -name "$(status)"
    sleep 2
done &
