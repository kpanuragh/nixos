#!/bin/bash

# Secure Environment Setup Script
# This script helps you set up your API keys securely

set -e

CONFIG_DIR="$HOME/.config/hypr"
ENV_FILE="$CONFIG_DIR/env.conf"
EXAMPLE_FILE="$CONFIG_DIR/env.conf.example"

echo "🔐 Secure Environment Setup for Hyprland"
echo "========================================"

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Check if example file exists
if [ ! -f "$EXAMPLE_FILE" ]; then
    echo "❌ Example file not found: $EXAMPLE_FILE"
    echo "Please make sure your NixOS configuration is applied first."
    exit 1
fi

# Check if env.conf already exists
if [ -f "$ENV_FILE" ]; then
    echo "⚠️  Environment file already exists: $ENV_FILE"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Keeping existing file."
        exit 0
    fi
fi

# Copy example to actual file
cp "$EXAMPLE_FILE" "$ENV_FILE"

echo "✅ Created environment file: $ENV_FILE"

# Set secure permissions
chmod 600 "$ENV_FILE"
echo "✅ Set secure permissions (600) on environment file"

echo ""
echo "🔧 Next steps:"
echo "1. Edit the file: $ENV_FILE"
echo "2. Replace the placeholder values with your actual API keys"
echo "3. Save the file"
echo ""
echo "💡 To edit the file:"
echo "   editor $ENV_FILE"
echo ""
echo "🔒 Security reminders:"
echo "   - This file is in .gitignore and won't be committed"
echo "   - File permissions are set to 600 (owner read/write only)"
echo "   - Never share or commit this file"
echo "   - Rotate your API keys regularly"

# Offer to open the file for editing
echo ""
read -p "Do you want to edit the file now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Try to detect available editors
    if command -v code >/dev/null 2>&1; then
        code "$ENV_FILE"
    elif command -v nvim >/dev/null 2>&1; then
        nvim "$ENV_FILE"
    elif command -v vim >/dev/null 2>&1; then
        vim "$ENV_FILE"
    elif command -v nano >/dev/null 2>&1; then
        nano "$ENV_FILE"
    else
        echo "No editor found. Please manually edit: $ENV_FILE"
    fi
fi

echo ""
echo "✨ Setup complete! Your API keys will be loaded securely by Hyprland."
