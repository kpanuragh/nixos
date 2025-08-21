{
  description = "Development environment for NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Nix tools
            nixpkgs-fmt
            nil # Nix LSP
            nix-tree
            nix-index
            
            # Development tools
            git
            gnumake
            
            # Documentation
            manix
            
            # Shell utilities
            direnv
            nix-direnv
          ];

          shellHook = ''
            echo "🚀 NixOS Configuration Development Environment"
            echo "================================================="
            echo ""
            echo "Available commands:"
            echo "  make help       - Show all available make targets"
            echo "  make switch     - Apply system configuration"
            echo "  make home       - Apply home-manager configuration"
            echo "  make check      - Check flake for errors"
            echo "  nixpkgs-fmt     - Format Nix files"
            echo ""
            echo "Useful tools:"
            echo "  nix-tree        - Explore dependency trees"
            echo "  manix           - Search Nix documentation"
            echo ""
          '';
        };
      });
}
