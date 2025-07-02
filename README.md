# My NixOS Configuration

This repository contains my personal NixOS configuration files, managed with Nix Flakes and Home Manager.

## Features

*   **Window Manager:** [Hyprland](https://hyprland.org/)
*   **Bar:** [Waybar](https://github.com/Alexays/Waybar)
*   **Launcher:** [Wofi](https://hg.sr.ht/~scoopta/wofi)
*   **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
*   **Editor:** [Neovim](https://neovim.io/)
*   **Shell:** [Zsh](https://www.zsh.org/) with [Starship](https://starship.rs/) prompt

## Usage

To use this configuration, you can clone this repository and build the NixOS configuration using the following command:

```bash
nixos-rebuild switch --flake .#iamanuragh
```

## Directory Structure

*   `flake.nix`: The main entry point for the NixOS configuration.
*   `configuration.nix`: The main NixOS configuration file.
*   `home.nix`: The Home Manager configuration file.
*   `hardware-configuration.nix`: The hardware-specific configuration.
