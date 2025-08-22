#!/usr/bin/env bash

# System performance monitor overlay
# Quick access to system information

# Get system info
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')
memory_usage=$(free | grep Mem | awk '{printf "%.1f", ($3/$2) * 100.0}')
disk_usage=$(df -h / | awk 'NR==2{print $5}')
temperature=$(sensors 2>/dev/null | grep -i "core 0" | awk '{print $3}' | head -n1 || echo "N/A")

# GPU info (if available)
gpu_usage=""
if command -v nvidia-smi >/dev/null 2>&1; then
    gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n1)
    gpu_usage="GPU: ${gpu_usage}%"
elif command -v radeontop >/dev/null 2>&1; then
    gpu_usage="GPU: Available"
fi

# Network info
network_info=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'dev \K\S+' | head -n1)
if [ -n "$network_info" ]; then
    network_status="Connected via $network_info"
else
    network_status="No connection"
fi

# Battery info (if laptop)
battery_info=""
if [ -d "/sys/class/power_supply/BAT0" ]; then
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")
    battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "N/A")
    battery_info="Battery: ${battery_level}% (${battery_status})"
fi

# Create info string
info="System Information\n"
info+="─────────────────\n"
info+="CPU Usage: ${cpu_usage}\n"
info+="Memory Usage: ${memory_usage}%\n"
info+="Disk Usage: ${disk_usage}\n"
info+="Temperature: ${temperature}\n"
[ -n "$gpu_usage" ] && info+="${gpu_usage}\n"
info+="Network: ${network_status}\n"
[ -n "$battery_info" ] && info+="${battery_info}\n"
info+="─────────────────\n"
info+="Open System Monitor\n"
info+="Open Power Settings\n"
info+="Open Network Settings"

# Show in wofi
selected=$(echo -e "$info" | wofi --dmenu --prompt "System Info:" --conf ~/.config/hypr/wofi-dmenu-config --style ~/.config/hypr/wofi-dmenu-style.css)

# Handle selection
case "$selected" in
    "Open System Monitor")
        kitty -e btop &
        ;;
    "Open Power Settings")
        gnome-power-statistics 2>/dev/null || xfce4-power-manager-settings 2>/dev/null || notify-send "Error" "No power manager found"
        ;;
    "Open Network Settings")
        nm-connection-editor &
        ;;
esac
