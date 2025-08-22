#!/usr/bin/env bash

# Advanced window switcher using wofi
# Shows all windows across all workspaces with preview

# Get all windows with their info
windows=$(hyprctl clients -j | jq -r '.[] | "\(.workspace.id) | \(.class) | \(.title) | \(.address)"')

# Format for wofi display
formatted_windows=""
declare -A window_map

while IFS='|' read -r workspace class title address; do
    # Clean up the strings
    workspace=$(echo "$workspace" | xargs)
    class=$(echo "$class" | xargs)
    title=$(echo "$title" | xargs)
    address=$(echo "$address" | xargs)
    
    # Limit title length
    if [ ${#title} -gt 50 ]; then
        title="${title:0:47}..."
    fi
    
    # Create display string
    display_string="[$workspace] $class: $title"
    formatted_windows="$formatted_windows$display_string\n"
    
    # Map display string to window address
    window_map["$display_string"]="$address"
done <<< "$windows"

# Show wofi and get selection
selected=$(echo -e "$formatted_windows" | wofi --dmenu --prompt "Switch to window:" --conf ~/.config/hypr/wofi-dmenu-config --style ~/.config/hypr/wofi-dmenu-style.css)

# Focus the selected window
if [ -n "$selected" ]; then
    address="${window_map[$selected]}"
    if [ -n "$address" ]; then
        hyprctl dispatch focuswindow "address:$address"
    fi
fi
