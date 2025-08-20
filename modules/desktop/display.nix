{ config, lib, pkgs, ... }:

{
  # X11 and display management
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  
  # Hyprland configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  # XDG portals for desktop integration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-hyprland 
    ];
  };
  
  # GNOME Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;
}
