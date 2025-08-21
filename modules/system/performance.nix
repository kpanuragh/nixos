{ config, lib, pkgs, ... }:

{
  # Performance optimizations
  
  # Kernel parameters for better performance (security settings in security.nix)
  boot.kernel.sysctl = {
    # Network performance
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
    "net.ipv4.tcp_rmem" = "4096 65536 134217728";
    "net.ipv4.tcp_wmem" = "4096 65536 134217728";
    "net.ipv4.tcp_congestion_control" = "bbr";
    
    # Virtual memory
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
    
    # File system
    "fs.inotify.max_user_watches" = 524288;
    "fs.file-max" = 2097152;
  };

  # Systemd optimization
  systemd = {
    # Faster boot
    services = {
      # Disable unnecessary services
      "systemd-udev-settle".enable = false;
      
      # Optimize NetworkManager
      NetworkManager.serviceConfig = {
        Restart = "on-failure";
        RestartSec = "1s";
      };
    };
    
    # User services optimization
    user.services = {
      # Faster user session startup
      "app-gnome\\x2dkeyring\\x2ddaemon@autostart".serviceConfig = {
        Slice = "background.slice";
      };
    };
  };

  # Zram for better memory management
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand"; # Use "performance" for desktop, "powersave" for laptop
  };

  # Hardware optimization
  hardware = {
    # Enable all firmware
    enableAllFirmware = true;
    
    # CPU microcode
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware; # Uncomment if AMD
    
    # Graphics acceleration
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # VAAPI for Intel
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
  };

  # Services optimization
  services = {
    # Faster DNS
    resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
      extraConfig = ''
        DNS=1.1.1.1#cloudflare-dns.com 8.8.8.8#dns.google
        DNSOverTLS=yes
        MulticastDNS=yes
        LLMNR=yes
        Cache=yes
        ReadEtcHosts=yes
      '';
    };

    # Optimize SSD
    fstrim.enable = true;
  };

  # Automatic system maintenance
  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserSlices = true;
  };

  # Nix store optimization
  nix.settings = {
    # Auto-optimize store
    auto-optimise-store = true;
    
    # Use more cores for building
    max-jobs = "auto";
    cores = 0; # Use all available cores
    
    # Experimental features
    experimental-features = [ "nix-command" "flakes" ];
    
    # Trusted users
    trusted-users = [ "root" "@wheel" ];
    
    # Substituters for faster builds
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # Boot optimization
  boot = {
    # Faster boot
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    
    # Initrd optimization
    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    
    # Plymouth for boot splash
    plymouth.enable = true;
    
    # Faster filesystem check
    loader.timeout = 3;
  };
}
