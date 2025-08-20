{ config, pkgs, lib, ... }:

{
  # Secure secrets management using age encryption
  # Install age for encryption: nix-shell -p age
  
  # Alternative 1: Use environment variables (less secure but simple)
  home.sessionVariables = {
    # These will be loaded from your shell environment
    # Set them in your shell profile or use a secure method
  };
  
  # Alternative 2: Use a secure secrets management approach
  # You can create encrypted files and decrypt them at runtime
  
  home.file = {
    # Create a script to safely load environment variables
    ".config/hypr/load-env.sh" = {
      text = ''
        #!/bin/bash
        # Script to securely load environment variables
        
        ENV_FILE="$HOME/.config/hypr/env.conf"
        
        # Check if the secure environment file exists
        if [ -f "$ENV_FILE" ]; then
          echo "Loading secure environment variables..."
          # Note: This file should contain your actual API keys
          # and should NEVER be committed to git
        else
          echo "Warning: $ENV_FILE not found!"
          echo "Please create it from the template: env.conf.example"
          echo "cp ~/.config/hypr/env.conf.example ~/.config/hypr/env.conf"
          echo "Then edit it with your actual API keys"
        fi
      '';
      executable = true;
    };
    
    # Instructions for setting up secure environment
    ".config/hypr/SECURITY_README.md".text = ''
      # Secure Environment Setup
      
      ## Steps to set up your API keys securely:
      
      1. Copy the example file:
         ```bash
         cp ~/.config/hypr/env.conf.example ~/.config/hypr/env.conf
         ```
      
      2. Edit the file with your actual API keys:
         ```bash
         editor ~/.config/hypr/env.conf
         ```
      
      3. Set proper permissions (recommended):
         ```bash
         chmod 600 ~/.config/hypr/env.conf
         ```
      
      ## Alternative secure methods:
      
      ### Method 1: Shell environment variables
      Add to your shell profile (~/.zshrc, ~/.bashrc):
      ```bash
      export GEMINI_API_KEY="your_key_here"
      export OPENAI_API_KEY="your_key_here"
      ```
      
      ### Method 2: Use age encryption (most secure)
      ```bash
      # Install age
      nix-shell -p age
      
      # Create encrypted secrets file
      echo "GEMINI_API_KEY=your_key" | age -p > ~/.config/hypr/secrets.age
      
      # Decrypt when needed
      age -d ~/.config/hypr/secrets.age
      ```
      
      ### Method 3: Use systemd-credentials (NixOS native)
      Set up systemd credentials for secure key storage.
      
      ## Important Security Notes:
      - Never commit env.conf to git (it's in .gitignore)
      - Use proper file permissions (600)
      - Consider using a password manager integration
      - Rotate your API keys regularly
    '';
  };
}
