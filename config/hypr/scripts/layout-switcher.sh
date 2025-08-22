#!/usr/bin/env bash

# Dynamic layout switcher
# Allows switching between different layout configurations

layouts=(
    "dwindle|Default tiling layout"
    "master|Master-stack layout"
)

# Format for wofi
formatted=""
current_layout=$(hyprctl getoption general:layout | grep -o 'str: "[^"]*"' | sed 's/str: "\([^"]*\)"/\1/')

for layout in "${layouts[@]}"; do
    IFS='|' read -r name description <<< "$layout"
    if [ "$name" = "$current_layout" ]; then
        formatted="$formatted● $name - $description\n"
    else
        formatted="$formatted  $name - $description\n"
    fi
done

# Show wofi and get selection
selected=$(echo -e "$formatted" | wofi --dmenu --prompt "Switch layout:" --conf ~/.config/hypr/wofi-dmenu-config --style ~/.config/hypr/wofi-dmenu-style.css)

# Extract layout name and switch
if [ -n "$selected" ]; then
    layout_name=$(echo "$selected" | sed 's/^[●[:space:]]*//' | cut -d' ' -f1)
    if [ -n "$layout_name" ]; then
        hyprctl keyword general:layout "$layout_name"
        notify-send "Layout" "Switched to $layout_name layout"
    fi
fi
