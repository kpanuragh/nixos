#!/usr/bin/env bash

# Simple Music Visualizer for Waybar
# Shows animated bars when music is playing

# Check if music is playing
if ! playerctl status 2>/dev/null | grep -q "Playing"; then
    echo "🎵"
    exit 0
fi

# Get current song info
song=$(playerctl metadata --format='{{ title }}' 2>/dev/null | head -c 20)
artist=$(playerctl metadata --format='{{ artist }}' 2>/dev/null | head -c 15)

# Generate animated bars based on current second
second=$(date +%S)
bars=""

# Create animated effect
for i in {1..8}; do
    # Calculate bar height based on time and position
    height=$(( (second * i + i * 3) % 8 ))
    case $height in
        0|1) bars+="▁" ;;
        2) bars+="▂" ;;
        3) bars+="▃" ;;
        4) bars+="▄" ;;
        5) bars+="▅" ;;
        6) bars+="▆" ;;
        7) bars+="█" ;;
    esac
done

# Output format: bars + song info
if [[ -n "$song" ]]; then
    echo "$bars $song"
else
    echo "$bars Music"
fi
