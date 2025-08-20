#!/usr/bin/env bash

# Waybar Music Visualizer Script
# Uses cava to generate audio spectrum bars

# Configuration
bars=10
bar_width=1
raw_target="/tmp/cava_raw"

# Create cava config for waybar
config_file="/tmp/cava_waybar_config"
cat > "$config_file" << EOF
[general]
bars = $bars
bar_width = $bar_width

[output]
method = raw
raw_target = $raw_target
data_format = ascii
ascii_max_range = 8

[smoothing]
noise_reduction = 70
EOF

# Kill any existing cava instances
pkill -f "cava.*waybar"

# Start cava in background
cava -p "$config_file" &
cava_pid=$!

# Function to convert cava output to visual bars
generate_bars() {
    if [[ -p "$raw_target" ]]; then
        read -t 0.1 line < "$raw_target"
        if [[ -n "$line" ]]; then
            bars_output=""
            for char in $(echo "$line" | fold -w1); do
                case $char in
                    0) bars_output+="▁" ;;
                    1) bars_output+="▂" ;;
                    2) bars_output+="▃" ;;
                    3) bars_output+="▄" ;;
                    4) bars_output+="▅" ;;
                    5) bars_output+="▆" ;;
                    6) bars_output+="▇" ;;
                    7|8) bars_output+="█" ;;
                    *) bars_output+="▁" ;;
                esac
            done
            echo "$bars_output"
        else
            echo "▁▁▁▁▁▁▁▁▁▁"
        fi
    else
        echo "▁▁▁▁▁▁▁▁▁▁"
    fi
}

# Main loop
while true; do
    # Check if music is playing
    if playerctl status 2>/dev/null | grep -q "Playing"; then
        generate_bars
    else
        echo "🎵"
    fi
    sleep 0.1
done

# Cleanup on exit
trap 'kill $cava_pid 2>/dev/null; rm -f "$config_file" "$raw_target"' EXIT
