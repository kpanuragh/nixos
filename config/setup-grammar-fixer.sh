#!/usr/bin/env bash

# Grammar Fixer Setup Script
# Creates virtual environment and installs dependencies

set -e

SCRIPT_DIR="$HOME/.config/hypr"
VENV_DIR="$SCRIPT_DIR/grammar-fixer-venv"

echo "🔧 Setting up Grammar Fixer virtual environment..."

# Check if Python3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 is not installed. Please install Python3 first."
    notify-send -u critical "Grammar Fixer Setup" "Python3 is not installed"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
    
    if [ $? -ne 0 ]; then
        echo "❌ Failed to create virtual environment. Installing python3-venv..."
        # Try to install venv if it's missing
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y python3-venv
        elif command -v pacman &> /dev/null; then
            sudo pacman -S python-virtualenv
        elif command -v nix-env &> /dev/null; then
            nix-env -iA nixpkgs.python3Packages.virtualenv
        fi
        
        # Try again
        python3 -m venv "$VENV_DIR"
        if [ $? -ne 0 ]; then
            echo "❌ Still failed to create virtual environment"
            notify-send -u critical "Grammar Fixer Setup" "Failed to create virtual environment"
            exit 1
        fi
    fi
else
    echo "✅ Virtual environment already exists"
fi

# Activate virtual environment
echo "⚡ Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Upgrade pip
echo "📥 Upgrading pip..."
pip install --upgrade pip

# Install required packages
echo "📦 Installing dependencies..."
pip install -r "$SCRIPT_DIR/requirements.txt"

# Try to ensure tkinter is available (NixOS specific)
echo "🔍 Checking tkinter availability..."
python3 -c "import tkinter; print('✅ tkinter available')" 2>/dev/null || {
    echo "⚠️ tkinter not available in virtual environment"
    echo "On NixOS, you may need to install python3-tk system-wide:"
    echo "  nix-env -iA nixpkgs.python3Packages.tkinter"
    echo "Or add it to your system configuration"
}

# Verify installation
echo "🔍 Verifying installation..."
python3 -c "import requests; print('✅ requests installed successfully')"

echo "🎉 Setup complete!"
echo ""
echo "Grammar Fixer is now ready to use with:"
echo "  • Virtual environment: $VENV_DIR"
echo "  • Dependencies: requests"
echo ""
echo "You can now run the grammar fixer with Super+Shift+G"

# Send success notification
notify-send -c volume "Grammar Fixer" "Setup completed successfully!"

echo "✨ All done! Virtual environment is ready."
