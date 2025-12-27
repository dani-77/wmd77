#!/bin/bash

bat() {
    # Example acpi -b:
    # Battery 0: Discharging, 53%, 02:31:12 remaining
    # Battery 0: Charging, 82%, 00:25:10 until charged
    local line status percent time state

    line=$(acpi -b 2>/dev/null | head -n1)
    [ -z "$line" ] && { printf "Battery: ??%% (--) --:--"; return; }

    status=$(printf '%s\n' "$line" | awk -F': ' '{print $2}' | cut -d',' -f1)
    percent=$(printf '%s\n' "$line" | grep -o '[0-9]\+%' | head -n1)
    time=$(printf '%s\n' "$line" | grep -o '[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}' | head -n1)

    # Normalize state label
    case "$status" in
        *Charging*)    state="+" ;;
        *Discharging*) state="-" ;;
        *Full*)        state="Full" ;;
        *)             state="$status" ;;
    esac

    [ -z "$time" ] && time="--:--"

    printf "Battery: %s (%s) %s" "$percent" "$state" "$time"
}

status() {
    # Date and time
    DATE=$(date '+%a %d %b %Y, %H:%M')
    
    # Weather
    WEATHER=$(curl -s wttr.in/?format=1 | awk '{ print $2 }')

    # Memory usage
    MEMORY=$(free -m | grep '^Mem' | awk '{print "Mem: " $3 "MB/" $2 "MB"}')
    
    # CPU usage (use used instead of idle)
    CPU=$(top -bn1 | grep 'Cpu(s)' | awk '{print 100-$8"%"}')
    
    # Wlan: ESSID + quality
    IFACE=$(ls /sys/class/net | grep '^wl' | head -n1)
    WLAN_STATE=""
    WLAN=""
    if [ -n "$IFACE" ]; then
        WLAN_STATE=$(cat "/sys/class/net/$IFACE/operstate" 2>/dev/null)
        if [ "$WLAN_STATE" = "up" ]; then
            ESSID=$(iwgetid "$IFACE" --raw 2>/dev/null)
            # Quality in %
            QUALITY=$(iwconfig "$IFACE" 2>/dev/null | \
                      awk '/Link Quality/ { split($2,a,"=|/"); printf "%d%%", (a[2]/a[3])*100 }')
            [ -z "$ESSID" ] && ESSID="unknown"
            [ -z "$QUALITY" ] && QUALITY="--"
            WLAN="WiFi: $ESSID ($QUALITY)"
        else
            WLAN="WiFi: down"
        fi
    else
        WLAN="WiFi: n/a"
    fi

    # Volume
    VOLUME=$(amixer get Master | grep -o '[0-9]*%' | head -1)
    
    # Battery
    BATTERY_INFO=$(bat)
    
    # Combine all info with prefixes
    echo "$WEATHER | CPU: $CPU | $MEMORY | $WLAN | Volume: $VOLUME | $BATTERY_INFO | $DATE"
}

while true; do
    xsetroot -name "$(status)"
    sleep 2
done &

