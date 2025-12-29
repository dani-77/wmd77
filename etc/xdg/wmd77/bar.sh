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
        *Charging*)    state="+++" ;;
        *Discharging*) state="Remaining" ;;
        *Full*)        state="Full" ;;
        *)             state="$status" ;;
    esac

    [ -z "$time" ] && time="--:--"

    printf "Battery: %s %s %s" "$percent" "($state)" "$time"
}

status() {

    # Battery
    BATTERY_INFO=$(bat)
    
    # CPU usage (use used instead of idle)
    CPU=$(top -bn1 | grep 'Cpu(s)' | awk '{print 100-$8"%"}')

    # Date and time
    DATE=$(date '+%a %d %b %Y, %H:%M')

    # Memory usage
    MEMORY=$(free -m | grep '^Mem' | awk '{print "Mem: " $3 "MB/" $2 "MB"}')
    
    # Updates
    # Void
    VOID_UPDATES=$(timeout 20 xbps-install -unM 2>/dev/null | wc -l)
    ARCH_UPDATES=$(timeout 20 checkupdates 2>/dev/null | wc -l)
    DEB_UPDATES=$(timeout 20 aptitude search '~U' 2>/dev/null | wc -l)

    # Volume
    VOLUME=$(amixer get Master | grep -o '[0-9]*%' | head -1)
    
    # Weather
    WEATHER=$(curl -s wttr.in/?format=1 | awk '{ print $2 }')
    
    # Wlan: Simple
    WLAN_STATE=$(cat /sys/class/net/wl*/operstate 2>/dev/null | head -1)
    if [ "$WLAN_STATE" = "up" ]; then
        WLAN1="Connected"
    else
        WLAN1="Disconnected"
    fi

    # Wlan: ESSID + quality
    # Determine wifi interface (first wl* device)
    IFACE=$(ls /sys/class/net | grep '^wl' | head -n1)

    if [ -n "$IFACE" ]; then
    WLAN_STATE=$(cat "/sys/class/net/$IFACE/operstate" 2>/dev/null)
    if [ "$WLAN_STATE" = "up" ]; then
        # ESSID via nmcli
        ESSID=$(nmcli -t -f IN-USE,SSID dev wifi | awk -F: '$1=="*"{print $2; exit}')
        # Quality via nmcli (signal 0–100)
        QUALITY=$(nmcli -t -f IN-USE,SIGNAL dev wifi | awk -F: '$1=="*"{print $2"%"; exit}')
        [ -z "$ESSID" ] && ESSID="unknown"
        [ -z "$QUALITY" ] && QUALITY="--"
        WLAN2="WiFi: $ESSID ($QUALITY)"
    else
        WLAN2="WiFi: down"
    fi
    else
    	WLAN2="WiFi: n/a"
    fi

    # Combine all info with prefixes
    echo "UPD: $VOID_UPDATES | $WEATHER | CPU: $CPU | $MEMORY | $WLAN1 | Volume: $VOLUME | $BATTERY_INFO | $DATE"
}

while true; do
    xsetroot -name "$(status)"
    sleep 2
done &

