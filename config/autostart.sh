#!/usr/bin/env zsh

if [ -f "$HOME/.zshrc" ]; then
    . "$HOME/.zshrc"
fi

# Start hypridle for automatic power management
hypridle &

# Start dunst notification daemon
dunst --config ~/.config/hypr/dunstrc &

