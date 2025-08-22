{ config, lib, pkgs, ... }:

{
  # Font configuration for crisp, readable system-wide fonts
  fonts = {
    packages = with pkgs; [
      # Modern system fonts
      inter
      roboto
      roboto-mono
      ubuntu_font_family
      source-sans-pro
      source-serif-pro
      source-code-pro
      
      # Core Noto fonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans
      noto-fonts-emoji
      
      # Premium programming fonts
      jetbrains-mono
      fira-code
      fira-code-symbols
      cascadia-code
      hack-font
      inconsolata
      
      # Nerd fonts for icons
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.inconsolata
      
      # Additional quality fonts
      cantarell-fonts
      font-awesome
      material-design-icons
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      
      defaultFonts = {
        sansSerif = [ "Inter" "Roboto" "Noto Sans" ];
        serif = [ "Source Serif Pro" "Noto Serif" ];
        monospace = [ "JetBrainsMono Nerd Font" "JetBrains Mono" "Fira Code" ];
        emoji = [ "Noto Color Emoji" ];
      };
      
      # Font rendering optimizations
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <!-- Improve font rendering -->
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
            <edit name="embeddedbitmap" mode="assign">
              <bool>false</bool>
            </edit>
          </match>
          
          <!-- Better font substitutions -->
          <alias>
            <family>sans-serif</family>
            <prefer>
              <family>Inter</family>
              <family>Roboto</family>
              <family>Noto Sans</family>
            </prefer>
          </alias>
          
          <alias>
            <family>serif</family>
            <prefer>
              <family>Source Serif Pro</family>
              <family>Noto Serif</family>
            </prefer>
          </alias>
          
          <alias>
            <family>monospace</family>
            <prefer>
              <family>JetBrainsMono Nerd Font</family>
              <family>JetBrains Mono</family>
              <family>Fira Code</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
    };
  };
}
