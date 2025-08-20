# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    builders-use-substitutes = true;
    max-jobs = "auto";
    cores = 0; # Use all available cores
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
services.ollama = {
  enable = true;
  loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
};


  networking.hostName = "iamanuragh"; # Define your hostname.
  networking.extraHosts =''
  127.0.0.1 oelms.local.com
  127.0.0.1 clientportal.local.com
  127.0.0.1 library.local.com
  '';
  networking.firewall = {
  enable = true; # This is the default and can be omitted
  
  # Add 9003 to your existing list of allowed ports.
  # You likely already have port 22 for SSH.
  allowedTCPPorts = [ 22 80 443 9003 19530 8001 3355 3000 ]; 
};
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
    daemon.settings = {
      features = { buildkit = true; };
      # Use systemd cgroup driver for better integration
      exec-opts = [ "native.cgroupdriver=systemd" ];
      log-driver = "journald";
      storage-driver = "overlay2";
    };
  };
 
  fonts = {
    packages = (with pkgs; [
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans
      noto-fonts-emoji
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      udev-gothic-nf
      font-awesome
      cantarell-fonts
      jetbrains-mono
    ]);

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
        serif = [ "Noto Serif JP" "DejaVu Serif" ];
      };
      subpixel = { lcdfilter = "light"; };
    };
  };


  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";
hardware.rtl-sdr.enable = true;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver = {
      enable = true;
      displayManager.gdm.enable = true; # Enable GDM as the display manager
        xkb = {
    layout = "us";
    variant = "";
  };

};
  programs.adb.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anuragh = {
    isNormalUser = true;
    description = "Anuragh";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "plugdev" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
    # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  
  # Enhanced security settings
  security.apparmor.enable = true;
  security.polkit.enable = true;
  
  # Improve kernel security
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
  ];
  
  # Enable zram for better memory management
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.upower.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # Enable JACK support for pro audio
    wireplumber.enable = true;
    
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024; # Reduced for lower latency
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 4096;
        "core.daemon" = true;
        "core.name" = "pipewire-0";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-protocol-native";
        }
        {
          name = "libpipewire-module-profiler";
        }
        {
          name = "libpipewire-module-metadata";
        }
        {
          name = "libpipewire-module-spa-device-factory";
        }
        {
          name = "libpipewire-module-spa-node-factory";
        }
        {
          name = "libpipewire-module-client-node";
        }
        {
          name = "libpipewire-module-client-device";
        }
        {
          name = "libpipewire-module-adapter";
        }
        {
          name = "libpipewire-module-link-factory";
        }
        {
          name = "libpipewire-module-session-manager";
        }
      ];
    };
  };
  services.fwupd.enable = true;
  programs.nix-ld.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Automatic system optimization
  nix.optimise = {
    automatic = true;
    dates = [ "03:45" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Only essential packages that aren't in modules
    discord
    bitwarden-cli
  ];
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
  };

services.gnome.gnome-keyring.enable = true;
 security.pam.services.gdm-password.enableGnomeKeyring = true;
  xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
    #services.openssh.enable = true;
services.openssh = {
  enable = true;
  settings = {
            PubkeyAcceptedAlgorithms = "ssh-rsa,ssh-ed25519,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256,rsa-sha2-512,rsa-sha2-256";
                  KexAlgorithms =[
                 "mlkem768x25519-sha256"
  "sntrup761x25519-sha512"
  "sntrup761x25519-sha512@openssh.com"
  "curve25519-sha256"
  "curve25519-sha256@libssh.org"
  "diffie-hellman-group-exchange-sha256"
    "diffie-hellman-group1-sha1"
            ];
    Ciphers = [
  "chacha20-poly1305@openssh.com"
  "aes256-gcm@openssh.com"
  "aes128-gcm@openssh.com"
  "aes256-ctr"
  "aes192-ctr"
  "aes128-ctr"
 "3des-cbc"
];
  };
};
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  virtualisation.waydroid.enable = true;

}
