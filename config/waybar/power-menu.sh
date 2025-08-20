#!/usr/bin/env bash

# Power menu script for Waybar
choice=$(echo -e "🔒 Lock\n🚪 Logout\n🔄 Restart\n⏽️ Shutdown\n😴 Sleep" | wofi --dmenu -p "Power Menu" --width 200 --height 250)

case "$choice" in
    "🔒 Lock")
        hyprlock
        ;;
    "🚪 Logout")
        hyprctl dispatch exit
        ;;
    "🔄 Restart")
        systemctl reboot
        ;;
    "⏽️ Shutdown")
        systemctl poweroff
        ;;
    "😴 Sleep")
        systemctl suspend
        ;;
esac
