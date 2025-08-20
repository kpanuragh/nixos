# Full Directory Symbolic Linking Setup

## 🔗 Overview

Your NixOS configuration now uses **full directory symbolic linking** instead of individual file linking. This provides several advantages:

- **Automatic inclusion** of new files you add to directories
- **Cleaner configuration** with less boilerplate
- **Easier maintenance** - no need to update NixOS configs when adding files
- **Complete directory replacement** ensuring consistency

## 📁 Directories Being Linked

| Application | Source Directory | Target Directory | Status |
|-------------|------------------|------------------|---------|
| **Hyprland** | `config/hypr/` | `~/.config/hypr/` | ✅ Full directory |
| **Waybar** | `config/waybar/` | `~/.config/waybar/` | ✅ Full directory |
| **Kitty** | `config/kitty/` | `~/.config/kitty/` | ✅ Full directory |

## 🛠️ How It Works

### Before (Individual Files):
```nix
home.file = {
  ".config/hypr/hyprland.conf".source = ../../config/hypr/hyprland.conf;
  ".config/hypr/hypridle.conf".source = ../../config/hypr/hypridle.conf;
  ".config/hypr/hyprlock.conf".source = ../../config/hypr/hyprlock.conf;
  # ... many more individual files
};
```

### After (Full Directory):
```nix
home.file = {
  ".config/hypr" = {
    source = ../../config/hypr;
    recursive = true;
  };
};
```

## 🚀 Usage Commands

### Quick Setup
```bash
# Full setup (backup existing + apply configuration + show status)
make full-setup
```

### Individual Commands
```bash
# Backup existing config directories
make backup-configs

# Apply NixOS configuration
make apply-config

# Check symbolic link status
make dotfiles-status

# Run management script directly
./scripts/manage-dotfiles.sh setup
```

## 🔒 Security Features

- **Automatic backup** of existing configurations before linking
- **Safe overwriting** with timestamped backups
- **Executable preservation** for scripts that need it
- **Environment security** maintained with secure API key loading

## 📋 What Happens During Setup

1. **Backup Phase**: Existing `~/.config/{hypr,waybar,kitty}` directories are backed up
2. **Linking Phase**: Home Manager creates symbolic links to your dotfiles repo
3. **Permission Phase**: Scripts are made executable automatically
4. **Verification Phase**: Status check confirms all links are working

## 🎯 Benefits

- **Version Control**: All configuration changes are tracked in git
- **Portability**: Easy to deploy on new systems
- **Consistency**: Same configuration across all your machines  
- **Maintenance**: Add new files without updating NixOS configuration
- **Rollback**: Easy to revert changes via git

## 📝 Adding New Files

Simply add files to the relevant `config/` directory and they'll be automatically included:

```bash
# Add new Hyprland script
echo '#!/bin/bash\necho "Hello from new script"' > config/hypr/my-new-script.sh
chmod +x config/hypr/my-new-script.sh

# Apply changes
make apply-config
```

No need to modify any `.nix` files!

## 🔍 Troubleshooting

If you have issues with symbolic links:

```bash
# Check current status
make dotfiles-status

# View detailed link information
ls -la ~/.config/hypr ~/.config/waybar ~/.config/kitty

# Manually fix if needed
./scripts/manage-dotfiles.sh backup
make apply-config
```

Your configuration is now fully modular and automatically managed! 🎉
