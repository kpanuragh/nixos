#!/usr/bin/env bash

# Scrolling Music Display for Waybar
# Shows long song titles with scrolling effect

max_length=35
scroll_speed=2

# Get music info
status=$(playerctl status 2>/dev/null)
title=$(playerctl metadata --format='{{ title }}' 2>/dev/null)
artist=$(playerctl metadata --format='{{ artist }}' 2>/dev/null)

# Exit if no music
if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
    echo "🎵 No music"
    exit 0
fi

# Combine title and artist
if [[ -n "$title" && -n "$artist" ]]; then
    full_text="$title - $artist"
elif [[ -n "$title" ]]; then
    full_text="$title"
else
    full_text="Unknown"
fi

# Status icon
if [[ "$status" == "Playing" ]]; then
    icon="▶️"
else
    icon="⏸️"
fi

# If text is short enough, display normally
if [[ ${#full_text} -le $max_length ]]; then
    echo "$icon $full_text"
    exit 0
fi

# Calculate scroll position based on time
current_time=$(date +%s)
scroll_pos=$(( (current_time * scroll_speed) % (${#full_text} + 10) ))

# Create scrolling effect
if [[ $scroll_pos -lt $max_length ]]; then
    # Show beginning of text
    display_text="${full_text:0:$max_length}"
else
    # Calculate actual scroll position
    actual_pos=$(( scroll_pos - max_length ))
    if [[ $actual_pos -lt ${#full_text} ]]; then
        # Scrolling through the text
        remaining_chars=$(( ${#full_text} - actual_pos ))
        if [[ $remaining_chars -ge $max_length ]]; then
            display_text="${full_text:$actual_pos:$max_length}"
        else
            # End of text, add beginning
            end_part="${full_text:$actual_pos}"
            start_part="${full_text:0:$(( max_length - remaining_chars - 3 ))}"
            display_text="$end_part • $start_part"
        fi
    else
        # Reset to beginning
        display_text="${full_text:0:$max_length}"
    fi
fi

echo "$icon $display_text"
