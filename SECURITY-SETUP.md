# Security Setup Instructions

## 🔒 IMPORTANT: API Keys Removed

Your API keys have been removed from the configuration for security. You must set them up securely before using AI features.

## Quick Setup (Recommended)

Run the automated setup script:

```bash
make setup-env
```

This will:
- Create `~/.config/hypr/env.conf` with proper permissions (600)
- Guide you through setting up your API keys securely

## Manual Setup Options

### Option 1: Environment File (Simple)

1. Create the environment file:
   ```bash
   cp config/hypr/env.conf.example ~/.config/hypr/env.conf
   chmod 600 ~/.config/hypr/env.conf
   ```

2. Edit the file and add your actual API keys:
   ```bash
   # Add your actual keys here:
   export GEMINI_API_KEY="your-actual-gemini-key"
   export OPENAI_API_KEY="your-actual-openai-key"
   ```

### Option 2: Age Encryption (Most Secure)

1. Install age encryption:
   ```bash
   nix-shell -p age
   ```

2. Generate a key pair:
   ```bash
   age-keygen -o ~/.config/age/key.txt
   ```

3. Create an encrypted secrets file:
   ```bash
   echo "GEMINI_API_KEY=your-key" | age -r $(age-keygen -y ~/.config/age/key.txt) > ~/.config/secrets.age
   ```

### Option 3: Systemd Credentials (System Integration)

1. Store credentials using systemd:
   ```bash
   echo "your-api-key" | sudo systemd-creds encrypt --name=gemini-api-key -
   ```

## Verification

After setup, restart Hyprland or source the environment:
```bash
source ~/.config/hypr/env.conf
echo $GEMINI_API_KEY  # Should show your key
```

## Files in This Setup

- `config/hypr/env.conf.example` - Template for environment variables
- `modules/home/secrets.nix` - Secure secrets management configuration
- `scripts/setup-secure-env.sh` - Automated setup script
- `.gitignore` - Prevents committing actual secrets

## ⚠️ Security Notes

- NEVER commit actual API keys to git
- The `env.conf` file is ignored by git
- Keep your keys private and secure
- Use different keys for different environments if possible

## Next Steps

1. Run `make setup-env` to configure your API keys
2. Test the AI features in Hyprland
3. Consider using a password manager for key storage
