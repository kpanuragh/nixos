# NixOS Configuration Management
# Convenient commands for managing your NixOS configuration

.PHONY: help switch build test clean update upgrade gc check

# Default target
help:
	@echo "NixOS Configuration Management"
	@echo ""
	@echo "Available commands:"
	@echo "  switch   - Build and switch to new configuration"
	@echo "  build    - Build configuration without switching"
	@echo "  test     - Test configuration (temporary)"
	@echo "  clean    - Clean up old generations"
	@echo "  update   - Update flake inputs"
	@echo "  upgrade  - Update and switch to new configuration"
	@echo "  gc       - Run garbage collection"
	@echo "  check    - Check flake for errors"

# Build and switch to new configuration
switch:
	sudo nixos-rebuild switch --flake .

# Build configuration without switching
build:
	sudo nixos-rebuild build --flake .

# Test configuration (temporary, reverts on reboot)
test:
	sudo nixos-rebuild test --flake .

# Clean up old generations (keep last 3)
clean:
	sudo nix-collect-garbage -d
	sudo nixos-rebuild switch --flake .

# Update flake inputs
update:
	nix flake update

# Update flake and switch
upgrade: update switch

# Run garbage collection
gc:
	sudo nix-collect-garbage -d

# Check flake for errors
check:
	nix flake check

# Show system information
info:
	@echo "System Information:"
	@echo "==================="
	@nixos-version
	@echo ""
	@echo "Current Generation:"
	@sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -1
	@echo ""
	@echo "Disk Usage:"
	@df -h /nix/store | tail -1

# Add/commit all changes
commit:
	git add .
	git status
	@echo ""
	@read -p "Commit message: " msg; git commit -m "$$msg"

# Push changes to remote
push:
	git push origin main
