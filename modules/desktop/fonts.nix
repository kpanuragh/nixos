{ config, lib, pkgs, ... }:

{
  # Font configuration
  fonts = {
    packages = with pkgs; [
      # Core fonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans
      noto-fonts-emoji
      
      # Programming fonts
      fira-code
      fira-code-symbols
      jetbrains-mono
      
      # Additional fonts
      dina-font
      proggyfonts
      udev-gothic-nf
      font-awesome
      cantarell-fonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
        serif = [ "Noto Serif JP" "DejaVu Serif" ];
        monospace = [ "JetBrains Mono" "Fira Code" ];
      };
      subpixel = { 
        lcdfilter = "light"; 
      };
    };
  };
}
