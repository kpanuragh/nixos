#!/usr/bin/env bash

# Package Duplicate Checker for NixOS Configuration
# This script identifies duplicate packages across your configuration

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"

echo "🔍 NixOS Package Duplicate Checker"
echo "=================================="
echo ""

# Function to extract packages from a file
extract_packages() {
    local file="$1"
    local type="$2" # "system" or "home"
    
    if [[ ! -f "$file" ]]; then
        return
    fi
    
    if [[ "$type" == "system" ]]; then
        grep -A 100 "environment\.systemPackages" "$file" 2>/dev/null | \
        grep -E "^\s*[a-zA-Z0-9_.-]+[;]?\s*(#.*)?$" | \
        sed 's/^\s*//' | sed 's/[;#].*//' | sed 's/\s*$//' | \
        grep -v "with pkgs" | grep -v "systemPackages" || true
    else
        grep -A 100 "home\.packages" "$file" 2>/dev/null | \
        grep -E "^\s*[a-zA-Z0-9_.-]+[;]?\s*(#.*)?$" | \
        sed 's/^\s*//' | sed 's/[;#].*//' | sed 's/\s*$//' | \
        grep -v "with pkgs" | grep -v "packages" || true
    fi
}

# Collect all packages
declare -A system_packages
declare -A home_packages
declare -A package_locations

echo "📦 Scanning system packages..."
for file in "$CONFIG_DIR"/modules/packages/*.nix; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        echo "  - $filename"
        while IFS= read -r package; do
            if [[ -n "$package" ]]; then
                system_packages["$package"]=1
                package_locations["$package"]+="system:$filename "
            fi
        done < <(extract_packages "$file" "system")
    fi
done

echo ""
echo "🏠 Scanning home packages..."
for file in "$CONFIG_DIR"/modules/home/*.nix "$CONFIG_DIR"/home.nix; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        echo "  - $filename"
        while IFS= read -r package; do
            if [[ -n "$package" ]]; then
                home_packages["$package"]=1
                package_locations["$package"]+="home:$filename "
            fi
        done < <(extract_packages "$file" "home")
    fi
done

echo ""
echo "🔍 Checking for duplicates..."
echo ""

# Check for duplicates
duplicates_found=false

# System-to-system duplicates
echo "📋 System package duplicates:"
declare -A system_seen
for package in "${!system_packages[@]}"; do
    locations="${package_locations[$package]}"
    system_count=$(echo "$locations" | grep -o "system:" | wc -l)
    if [[ $system_count -gt 1 ]]; then
        echo "  ⚠️  $package appears in: $(echo "$locations" | grep -o "system:[^ ]*" | sed 's/system://' | tr '\n' ' ')"
        duplicates_found=true
    fi
done

# Home-to-home duplicates  
echo ""
echo "🏠 Home package duplicates:"
declare -A home_seen
for package in "${!home_packages[@]}"; do
    locations="${package_locations[$package]}"
    home_count=$(echo "$locations" | grep -o "home:" | wc -l)
    if [[ $home_count -gt 1 ]]; then
        echo "  ⚠️  $package appears in: $(echo "$locations" | grep -o "home:[^ ]*" | sed 's/home://' | tr '\n' ' ')"
        duplicates_found=true
    fi
done

# Cross-category duplicates (system vs home)
echo ""
echo "🔄 Cross-category duplicates (system vs home):"
for package in "${!system_packages[@]}"; do
    if [[ -n "${home_packages[$package]:-}" ]]; then
        echo "  ⚠️  $package appears in both system and home packages"
        echo "      Locations: ${package_locations[$package]}"
        duplicates_found=true
    fi
done

echo ""
if [[ "$duplicates_found" == "false" ]]; then
    echo "✅ No duplicate packages found!"
else
    echo "⚠️  Duplicates found. Consider:"
    echo "   - Remove duplicates from home packages if they're available system-wide"
    echo "   - Keep user-specific versions in home packages only when needed"
    echo "   - Consolidate similar packages into appropriate modules"
fi

echo ""
echo "📊 Package counts:"
echo "   System packages: ${#system_packages[@]}"
echo "   Home packages: ${#home_packages[@]}"
echo "   Total unique: $((${#system_packages[@]} + ${#home_packages[@]}))"

echo ""
echo "💡 Recommendations:"
echo "   - Development tools should generally be in system packages"
echo "   - User-specific configurations should be in home packages"
echo "   - GUI applications can be in either, depending on whether all users need them"
