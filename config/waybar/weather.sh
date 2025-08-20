#!/usr/bin/env bash

# Simple weather display for Waybar
# Get weather from wttr.in

# Check for internet connection
if ! ping -c 1 google.com &> /dev/null; then
    echo "🌐 No connection"
    exit 0
fi

# Get weather data (replace "YourCity" with your location)
weather=$(curl -s "wttr.in/?format=%C+%t" --max-time 5)

if [[ -n "$weather" ]]; then
    # Clean up the output
    weather=$(echo "$weather" | sed 's/+//g' | sed 's/°C/ °C/')
    echo "🌤️ $weather"
else
    echo "🌤️ Weather unavailable"
fi
