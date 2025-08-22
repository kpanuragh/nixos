{ config, lib, pkgs, ... }:

{
  # GTK configuration for crisp system fonts
  gtk = {
    enable = true;
    
    font = {
      name = "Inter";
      size = 11;
    };
    
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    gtk3.extraConfig = {
      gtk-font-name = "Inter 11";
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = false;
      gtk-menu-images = false;
      gtk-enable-event-sounds = false;
      gtk-enable-input-feedback-sounds = false;
      gtk-xft-antialias = true;
      gtk-xft-hinting = true;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    
    gtk4.extraConfig = {
      gtk-font-name = "Inter 11";
      gtk-application-prefer-dark-theme = true;
      gtk-enable-event-sounds = false;
      gtk-enable-input-feedback-sounds = false;
    };
  };
  
  # Qt configuration to match GTK
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
  
  # XDG desktop settings
  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <match target="font">
        <edit name="antialias" mode="assign">
          <bool>true</bool>
        </edit>
        <edit name="hinting" mode="assign">
          <bool>true</bool>
        </edit>
        <edit name="hintstyle" mode="assign">
          <const>hintslight</const>
        </edit>
        <edit name="rgba" mode="assign">
          <const>rgb</const>
        </edit>
        <edit name="lcdfilter" mode="assign">
          <const>lcddefault</const>
        </edit>
      </match>
    </fontconfig>
  '';
}
