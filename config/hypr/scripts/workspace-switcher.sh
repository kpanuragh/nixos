#!/usr/bin/env bash

# Quick workspace switcher with visual feedback
# Shows workspace info and allows quick switching

current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')
workspaces=$(hyprctl workspaces -j | jq -r '.[] | "\(.id) | \(.windows) windows | \(.lastwindowtitle // "Empty")"' | sort -n)

# Format for display
formatted=""
while IFS='|' read -r id info; do
    id=$(echo "$id" | xargs)
    info=$(echo "$info" | xargs)
    
    if [ "$id" = "$current_workspace" ]; then
        formatted="$formatted● $id - $info\n"
    else
        formatted="$formatted  $id - $info\n"
    fi
done <<< "$workspaces"

# Show wofi and get selection
selected=$(echo -e "$formatted" | wofi --dmenu --prompt "Switch to workspace:" --conf ~/.config/hypr/wofi-dmenu-config --style ~/.config/hypr/wofi-dmenu-style.css)

# Extract workspace number and switch
if [ -n "$selected" ]; then
    workspace_id=$(echo "$selected" | grep -o '^[●[:space:]]*[0-9]\+' | grep -o '[0-9]\+')
    if [ -n "$workspace_id" ]; then
        hyprctl dispatch workspace "$workspace_id"
    fi
fi
