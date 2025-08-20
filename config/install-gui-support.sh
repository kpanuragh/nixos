#!/usr/bin/env bash

# Install tkinter for GUI support on NixOS
# This script helps users enable the GUI version

echo "🔧 Grammar Fixer - Enable GUI Support"
echo "======================================"
echo ""

if command -v nix-env &> /dev/null; then
    echo "📦 NixOS detected. Installing tkinter support..."
    echo ""
    echo "Choose installation method:"
    echo "1) User environment (nix-env)"
    echo "2) System configuration (requires sudo)"
    echo "3) Nix shell (temporary)"
    echo ""
    read -p "Choose option (1-3): " choice
    
    case $choice in
        1)
            echo "Installing tkinter via nix-env..."
            nix-env -iA nixpkgs.python3Packages.tkinter
            ;;
        2)
            echo "For system-wide installation, add this to your configuration.nix:"
            echo ""
            echo "environment.systemPackages = with pkgs; ["
            echo "  python3Packages.tkinter"
            echo "  # ... your other packages"
            echo "];"
            echo ""
            echo "Then run: sudo nixos-rebuild switch"
            ;;
        3)
            echo "For temporary use, run:"
            echo "nix-shell -p python3Packages.tkinter"
            echo "Then start the grammar fixer from within that shell"
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac
else
    echo "📦 Installing tkinter for your system..."
    
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y python3-tk
    elif command -v pacman &> /dev/null; then
        sudo pacman -S tk
    elif command -v dnf &> /dev/null; then
        sudo dnf install tkinter
    else
        echo "❌ Unsupported package manager. Please install python3-tk manually."
        exit 1
    fi
fi

echo ""
echo "✅ After installation, restart the grammar fixer to use GUI mode!"
echo "   Press Super+Shift+G or run ~/.config/hypr/grammar-fixer.sh"
