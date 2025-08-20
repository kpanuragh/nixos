#!/usr/bin/env bash

# Dotfiles Management Script
# This script helps manage your NixOS dotfiles with full directory symbolic linking

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "🔗 NixOS Dotfiles Management"
echo "============================"

# Function to backup existing directories
backup_existing() {
    local target="$1"
    if [ -d "$target" ] && [ ! -L "$target" ]; then
        echo "📦 Backing up existing directory: $target"
        mv "$target" "${target}.backup.$(date +%Y%m%d-%H%M%S)"
    fi
}

# Function to create symbolic links
create_symlinks() {
    echo "🔗 Creating symbolic links for configuration directories..."
    
    # Hyprland configuration
    echo "  → Linking Hyprland configuration"
    backup_existing "$CONFIG_DIR/hypr"
    
    # Waybar configuration  
    echo "  → Linking Waybar configuration"
    backup_existing "$CONFIG_DIR/waybar"
    
    # Kitty configuration
    echo "  → Linking Kitty configuration"
    backup_existing "$CONFIG_DIR/kitty"
    
    echo "✅ Backup complete. NixOS Home Manager will handle the linking."
}

# Function to apply NixOS configuration
apply_config() {
    echo "🚀 Applying NixOS configuration..."
    if command -v nixos-rebuild &> /dev/null; then
        sudo nixos-rebuild switch --flake "$DOTFILES_DIR"
    else
        echo "⚠️  nixos-rebuild not found. Please apply manually:"
        echo "   sudo nixos-rebuild switch --flake $DOTFILES_DIR"
    fi
}

# Function to show status
show_status() {
    echo "📋 Current symbolic link status:"
    echo ""
    
    for dir in hypr waybar kitty; do
        target="$CONFIG_DIR/$dir"
        if [ -L "$target" ]; then
            echo "✅ $dir → $(readlink "$target")"
        elif [ -d "$target" ]; then
            echo "📁 $dir (directory, not linked)"
        else
            echo "❌ $dir (missing)"
        fi
    done
}

# Main menu
case "${1:-}" in
    "backup")
        create_symlinks
        ;;
    "apply")
        apply_config
        ;;
    "status")
        show_status
        ;;
    "setup")
        create_symlinks
        apply_config
        show_status
        ;;
    *)
        echo "Usage: $0 {backup|apply|status|setup}"
        echo ""
        echo "Commands:"
        echo "  backup  - Backup existing config directories"
        echo "  apply   - Apply NixOS configuration"
        echo "  status  - Show current symbolic link status"
        echo "  setup   - Full setup (backup + apply + status)"
        echo ""
        echo "Example: $0 setup"
        ;;
esac
