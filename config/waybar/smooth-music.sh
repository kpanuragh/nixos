#!/usr/bin/env bash

# Smooth Music Display for Waybar
# Shows current song with smooth animated indicator

# Check if music is playing
status=$(playerctl status 2>/dev/null)
if [[ "$status" != "Playing" ]]; then
    if [[ "$status" == "Paused" ]]; then
        song=$(playerctl metadata --format='{{ title }}' 2>/dev/null | head -c 30)
        echo "⏸️ ${song:-"Music Paused"}"
    else
        echo "🎵 No music"
    fi
    exit 0
fi

# Get song info
title=$(playerctl metadata --format='{{ title }}' 2>/dev/null)
artist=$(playerctl metadata --format='{{ artist }}' 2>/dev/null)

# Create smooth animation based on milliseconds
ms=$(date +%3N)  # Get milliseconds (000-999)
frame=$((ms / 125))  # 8 frames (125ms each)

# Animated music note that cycles through different states
case $frame in
    0) icon="🎵" ;;
    1) icon="🎶" ;;
    2) icon="🎵" ;;
    3) icon="🎶" ;;
    4) icon="🎵" ;;
    5) icon="🎶" ;;
    6) icon="🎵" ;;
    7) icon="🎶" ;;
esac

# Format output
if [[ -n "$title" ]]; then
    # Limit length to prevent overflow
    display_title=$(echo "$title" | head -c 25)
    if [[ -n "$artist" ]]; then
        display_artist=$(echo "$artist" | head -c 15)
        echo "$icon $display_title - $display_artist"
    else
        echo "$icon $display_title"
    fi
else
    echo "$icon Playing"
fi
