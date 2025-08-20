#!/usr/bin/env bash

# Minimal Music Display for Waybar
# Clean, simple display with status indicator

# Get playback status
status=$(playerctl status 2>/dev/null)
title=$(playerctl metadata --format='{{ title }}' 2>/dev/null)
artist=$(playerctl metadata --format='{{ artist }}' 2>/dev/null)

# Format based on status
case "$status" in
    "Playing")
        if [[ -n "$title" ]]; then
            # Show title and artist if available
            if [[ -n "$artist" ]]; then
                echo "▶️ $(echo "$title" | head -c 20) • $(echo "$artist" | head -c 15)"
            else
                echo "▶️ $(echo "$title" | head -c 30)"
            fi
        else
            echo "▶️ Playing"
        fi
        ;;
    "Paused")
        if [[ -n "$title" ]]; then
            echo "⏸️ $(echo "$title" | head -c 25)"
        else
            echo "⏸️ Paused"
        fi
        ;;
    *)
        echo "⏹️ No music"
        ;;
esac
