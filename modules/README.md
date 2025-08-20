# Module Options and Configuration Documentation

This directory contains modular NixOS configuration files organized by functionality.

## Directory Structure

```
modules/
├── system/          # Core system configuration
│   ├── boot.nix     # Boot loader and kernel parameters
│   ├── nix.nix      # Nix daemon, flakes, and garbage collection
│   ├── networking.nix # Network, firewall, and VPN
│   ├── users.nix    # User accounts and permissions
│   ├── audio.nix    # PipeWire audio configuration
│   ├── hardware.nix # Hardware support and drivers
│   ├── virtualization.nix # Docker and virtualization
│   └── locale.nix   # Timezone and localization
├── desktop/         # Desktop environment
│   ├── display.nix  # X11, Wayland, and display managers
│   ├── gaming.nix   # Gaming-related configuration
│   └── fonts.nix    # Font configuration
├── packages/        # Package collections by category
│   ├── development.nix  # Development tools and languages
│   ├── hyprland.nix     # Hyprland/Wayland specific tools
│   ├── media.nix        # Media and entertainment
│   ├── monitoring.nix   # System monitoring tools
│   ├── networking.nix   # Network utilities
│   ├── fileutils.nix    # File management tools
│   ├── gui.nix          # GUI applications
│   └── utilities.nix    # Miscellaneous utilities
├── services/        # System services
│   ├── ai.nix       # AI services (Ollama)
│   └── ssh.nix      # SSH configuration
└── home/           # Home Manager modules
    ├── programs.nix # Program configurations
    ├── shell.nix    # Shell and prompt configuration
    └── git.nix      # Git configuration
```

## Best Practices Applied

1. **Separation of Concerns**: Each module handles a specific aspect of the system
2. **Conditional Loading**: Modules can be easily enabled/disabled
3. **Documentation**: Each module is well-documented
4. **Consistent Naming**: Clear, descriptive names for all modules
5. **Minimal Dependencies**: Modules are as independent as possible
6. **Type Safety**: Proper use of NixOS option types
7. **Performance Optimization**: Optimized configurations for better performance

## Usage

To add or remove functionality:

1. **Add a new module**: Create a new `.nix` file in the appropriate directory
2. **Import the module**: Add the import to `configuration.nix`
3. **Configure options**: Set module-specific options as needed

## Module Template

```nix
{ config, lib, pkgs, ... }:

{
  # Module description and configuration
  # Use lib.mkIf for conditional configuration
  # Document all options and their purposes
}
```
