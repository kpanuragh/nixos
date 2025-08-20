#!/usr/bin/env bash

# Advanced Music Visualizer for Waybar
# Uses pulseaudio to get real audio levels

# Check if music is playing
if ! playerctl status 2>/dev/null | grep -q "Playing"; then
    echo "🎵 No music"
    exit 0
fi

# Get audio level from pulseaudio
get_audio_level() {
    # Get default sink
    default_sink=$(pactl get-default-sink 2>/dev/null)
    if [[ -z "$default_sink" ]]; then
        echo "50"
        return
    fi
    
    # Get volume level
    volume=$(pactl get-sink-volume "$default_sink" 2>/dev/null | grep -oP '\d+%' | head -1 | tr -d '%')
    echo "${volume:-50}"
}

# Generate bars based on audio level and time
generate_visualizer() {
    local level=$1
    local bars=""
    local time_offset=$(date +%N | cut -c1-2)  # Use nanoseconds for variation
    
    for i in {1..10}; do
        # Create pseudo-random but smooth animation
        local height=$(( (level * i / 10 + time_offset + i * 7) % 8 ))
        case $height in
            0) bars+="▁" ;;
            1) bars+="▂" ;;
            2) bars+="▃" ;;
            3) bars+="▄" ;;
            4) bars+="▅" ;;
            5) bars+="▆" ;;
            6) bars+="▇" ;;
            7) bars+="█" ;;
        esac
    done
    echo "$bars"
}

# Get current song
song=$(playerctl metadata --format='{{ title }}' 2>/dev/null)
artist=$(playerctl metadata --format='{{ artist }}' 2>/dev/null)

# Get audio level
audio_level=$(get_audio_level)

# Generate visualizer
viz=$(generate_visualizer "$audio_level")

# Format output
if [[ -n "$song" ]]; then
    # Truncate song title if too long
    short_song=$(echo "$song" | cut -c1-25)
    echo "$viz $short_song"
else
    echo "$viz Music Playing"
fi
