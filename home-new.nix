# Home Manager Configuration - Modular Structure
{ config, pkgs, inputs, ... }:

{
  # User information
  home = {
    username = "anuragh";
    homeDirectory = "/home/anuragh";
    stateVersion = "25.05";
  };

  # Custom packages (things not available in nixpkgs)
  home.packages = with pkgs; [
    # Custom ollama-tui from your flake input
    inputs.ollama-tui.packages.${system}.default
  ];

  # Import program configurations
  imports = [
    ./modules/home/programs.nix
    ./modules/home/shell.nix
    ./modules/home/git.nix
  ];
}
