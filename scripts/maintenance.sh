#!/usr/bin/env bash

# NixOS System Maintenance Script
# Run this script periodically to keep your system clean and updated

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        error "This script should not be run as root"
        exit 1
    fi
}

# Update flake inputs
update_flake() {
    log "Updating flake inputs..."
    if [[ -f "flake.lock" ]]; then
        nix flake update
        success "Flake inputs updated"
    else
        warning "No flake.lock found, skipping flake update"
    fi
}

# Clean up system
cleanup_system() {
    log "Cleaning up system..."
    
    # Remove old generations (keep last 5)
    sudo nix-collect-garbage --delete-older-than 7d
    nix-collect-garbage --delete-older-than 7d
    
    # Optimize nix store
    sudo nix-store --optimize
    
    success "System cleanup completed"
}

# Update system
update_system() {
    log "Updating NixOS system..."
    sudo nixos-rebuild switch --flake .
    success "System updated"
}

# Update home-manager
update_home() {
    log "Updating Home Manager..."
    home-manager switch --flake .
    success "Home Manager updated"
}

# Check system health
check_health() {
    log "Checking system health..."
    
    # Check disk space
    df -h / | awk 'NR==2 {
        usage = substr($5, 1, length($5)-1)
        if (usage > 90) {
            print "⚠ Root filesystem is " usage "% full"
        } else {
            print "✓ Root filesystem usage: " usage "%"
        }
    }'
    
    # Check memory usage
    free -h | awk 'NR==2 {
        print "✓ Memory usage: " $3 "/" $2
    }'
    
    # Check last boot time
    uptime_output=$(uptime -s)
    log "Last boot: $uptime_output"
    
    success "Health check completed"
}

# Backup important configurations
backup_configs() {
    log "Creating backup of important configurations..."
    
    BACKUP_DIR="$HOME/nixos-backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Backup current configuration
    cp -r . "$BACKUP_DIR/dotfiles"
    
    # Backup system information
    nixos-version > "$BACKUP_DIR/nixos-version.txt"
    uname -a > "$BACKUP_DIR/system-info.txt"
    lsblk > "$BACKUP_DIR/disk-layout.txt"
    
    # Compress backup
    tar -czf "$BACKUP_DIR.tar.gz" -C "$(dirname "$BACKUP_DIR")" "$(basename "$BACKUP_DIR")"
    rm -rf "$BACKUP_DIR"
    
    # Keep only last 10 backups
    ls -t "$HOME/nixos-backups/"*.tar.gz 2>/dev/null | tail -n +11 | xargs -r rm
    
    success "Backup created at $BACKUP_DIR.tar.gz"
}

# Generate system report
generate_report() {
    log "Generating system report..."
    
    REPORT_FILE="$HOME/system-report-$(date +%Y%m%d).txt"
    
    {
        echo "=== NixOS System Report ==="
        echo "Generated: $(date)"
        echo ""
        
        echo "=== System Information ==="
        nixos-version
        uname -a
        echo ""
        
        echo "=== Hardware Information ==="
        lscpu | head -20
        echo ""
        lsmem --summary
        echo ""
        
        echo "=== Disk Usage ==="
        df -h
        echo ""
        
        echo "=== Memory Usage ==="
        free -h
        echo ""
        
        echo "=== Network ==="
        ip addr show | grep -E "(inet|UP|DOWN)"
        echo ""
        
        echo "=== Services ==="
        systemctl --failed
        echo ""
        
        echo "=== Last 10 system logs ==="
        journalctl --system -n 10 --no-pager
        
    } > "$REPORT_FILE"
    
    success "System report generated at $REPORT_FILE"
}

# Main function
main() {
    check_root
    
    log "Starting NixOS maintenance..."
    
    case "${1:-all}" in
        "update")
            update_flake
            update_system
            update_home
            ;;
        "cleanup")
            cleanup_system
            ;;
        "backup")
            backup_configs
            ;;
        "health")
            check_health
            ;;
        "report")
            generate_report
            ;;
        "all")
            update_flake
            update_system
            update_home
            cleanup_system
            check_health
            backup_configs
            ;;
        *)
            echo "Usage: $0 [update|cleanup|backup|health|report|all]"
            echo ""
            echo "Commands:"
            echo "  update   - Update flake inputs, system, and home-manager"
            echo "  cleanup  - Clean up old generations and optimize store"
            echo "  backup   - Create backup of configurations"
            echo "  health   - Check system health"
            echo "  report   - Generate detailed system report"
            echo "  all      - Run all maintenance tasks (default)"
            exit 1
            ;;
    esac
    
    success "Maintenance completed!"
}

# Run main function
main "$@"
