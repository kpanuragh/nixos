# NixOS Configuration Management
.DEFAULT_GOAL := help

# Colors for help
BOLD := \033[1m
RESET := \033[0m
BLUE := \033[34m
GREEN := \033[32m
YELLOW := \033[33m

## System Management
.PHONY: switch test boot check update clean backup

switch: ## Rebuild and switch to new system configuration
	@echo "$(BLUE)Building and switching to new configuration...$(RESET)"
	sudo nixos-rebuild switch --flake .

test: ## Test new configuration without switching
	@echo "$(BLUE)Testing new configuration...$(RESET)"
	sudo nixos-rebuild test --flake .

boot: ## Build configuration and set as default for next boot
	@echo "$(BLUE)Building configuration for next boot...$(RESET)"
	sudo nixos-rebuild boot --flake .

check: ## Check flake for errors
	@echo "$(BLUE)Checking flake for errors...$(RESET)"
	nix flake check

## Home Manager
.PHONY: home home-switch

home: home-switch ## Switch home-manager configuration

home-switch: ## Switch home-manager configuration
	@echo "$(BLUE)Switching home-manager configuration...$(RESET)"
	home-manager switch --flake .

## Updates
.PHONY: update-flake update-all

update-flake: ## Update flake inputs
	@echo "$(BLUE)Updating flake inputs...$(RESET)"
	nix flake update

update-all: update-flake switch home ## Update everything and rebuild

## Maintenance
.PHONY: clean optimize gc maintenance

clean: ## Clean old generations and optimize store
	@echo "$(BLUE)Cleaning system...$(RESET)"
	sudo nix-collect-garbage --delete-older-than 7d
	nix-collect-garbage --delete-older-than 7d

optimize: ## Optimize nix store
	@echo "$(BLUE)Optimizing nix store...$(RESET)"
	sudo nix-store --optimize

gc: clean optimize ## Run garbage collection and optimization

maintenance: ## Run full system maintenance
	@echo "$(BLUE)Running system maintenance...$(RESET)"
	./scripts/maintenance.sh all

## Development
.PHONY: fmt lint dev-shell check-duplicates

fmt: ## Format nix files
	@echo "$(BLUE)Formatting nix files...$(RESET)"
	find . -name "*.nix" -type f -exec nixpkgs-fmt {} \;

lint: ## Lint nix files
	@echo "$(BLUE)Linting nix files...$(RESET)"
	find . -name "*.nix" -type f -exec nix-instantiate --parse {} \; > /dev/null

check-duplicates: ## Check for duplicate packages across configuration
	@echo "$(BLUE)Checking for duplicate packages...$(RESET)"
	./scripts/check-duplicates.sh

dev-shell: ## Enter development shell
	@echo "$(BLUE)Entering development shell...$(RESET)"
	nix develop

## Backup and Restore
.PHONY: backup restore

backup: ## Create system backup
	@echo "$(BLUE)Creating system backup...$(RESET)"
	./scripts/maintenance.sh backup

## Information
.PHONY: info show-generations hardware-config

info: ## Show system information
	@echo "$(GREEN)NixOS System Information:$(RESET)"
	@echo "Version: $$(nixos-version)"
	@echo "Kernel: $$(uname -r)"
	@echo "Uptime: $$(uptime -p)"
	@echo "Last Update: $$(stat -c %y /run/current-system)"

show-generations: ## Show system generations
	@echo "$(GREEN)System Generations:$(RESET)"
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

hardware-config: ## Generate new hardware configuration
	@echo "$(BLUE)Generating hardware configuration...$(RESET)"
	sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix.new
	@echo "$(YELLOW)New hardware config saved as hardware-configuration.nix.new$(RESET)"
	@echo "$(YELLOW)Review and replace hardware-configuration.nix if needed$(RESET)"

## Git Management
.PHONY: commit push pull status

commit: ## Add and commit changes
	git add .
	git status
	@echo ""
	@read -p "Commit message: " msg; git commit -m "$$msg"

push: ## Push changes to remote
	git push origin main

pull: ## Pull changes from remote
	git pull origin main

status: ## Show git status
	git status

## Help
.PHONY: help

help: ## Show this help message
	@echo "$(BOLD)NixOS Configuration Management$(RESET)"
	@echo ""
	@echo "$(BOLD)Usage:$(RESET)"
	@echo "  make <target>"
	@echo ""
	@echo "$(BOLD)Targets:$(RESET)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(BOLD)Quick Start:$(RESET)"
	@echo "  make switch     # Apply system changes"
	@echo "  make home       # Apply home-manager changes" 
	@echo "  make update-all # Update and rebuild everything"
	@echo "  make clean      # Clean old generations"
