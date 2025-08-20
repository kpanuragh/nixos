{ config, pkgs, ... }:

{
  # Git configuration
  programs.git = {
    enable = true;
    userName = "Anuragh K P";
    userEmail = "anuragh.kp@cubettech.com";
    lfs.enable = true;
    
    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      
      pull = {
        rebase = false;
      };
      
      init = {
        defaultBranch = "main";
      };
      
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
