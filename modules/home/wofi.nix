{ config, pkgs, ... }:

{
  # Wofi configuration
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    
    style = ''
      window {
        margin: 0px;
        border: 1px solid #c3c3c3;
        background-color: #282828;
        border-radius: 15px;
      }

      #input {
        padding: 4px;
        margin: 4px;
        padding-left: 20px;
        border: none;
        color: #ebdbb2;
        font-weight: bold;
        background-color: #3c3836;
        outline: none;
        border-radius: 15px;
        margin: 10px;
        margin-bottom: 2px;
      }
      #input:focus {
        border: 0px solid #ebdbb2;
        margin-bottom: 0px;
      }

      #inner-box {
        margin: 4px;
        border: 10px solid #282828;
        color: #ebdbb2;
        font-weight: bold;
        background-color: #282828;
        border-radius: 15px;
      }

      #outer-box {
        margin: 0px;
        border: none;
        background-color: #282828;
        border-radius: 15px;
      }

      #scroll {
        margin: 0px;
        border: none;
        border-radius: 15px;
        margin-bottom: 5px;
      }

      #text {
        margin: 5px;
        border: none;
        color: #ebdbb2;
        font-weight: bold;
        background-color: transparent;
      }

      #entry {
        margin: 0px;
        border: none;
        border-radius: 15px;
        background-color: transparent;
      }

      #entry:selected {
        color: #282828;
        font-weight: bold;
        background-color: #ebdbb2;
        border-radius: 15px;
      }
    '';
  };
}
