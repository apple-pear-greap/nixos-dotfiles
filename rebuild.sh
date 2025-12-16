#!/usr/bin/env bash

# Auto-detect hostname and rebuild NixOS configuration
# This script eliminates the need to manually specify the hostname every time

set -e

# Get the current hostname
HOSTNAME=$(hostname)

# Verify the hostname exists in flake.nix configurations
if grep -q "nixosConfigurations.${HOSTNAME}" flake.nix; then
    echo "🔨 Rebuilding for host: $HOSTNAME"
    sudo nixos-rebuild switch --flake ".#${HOSTNAME}"
else
    echo "❌ Error: Hostname '$HOSTNAME' not found in flake.nix nixosConfigurations"
    echo ""
    echo "Available configurations:"
    grep "nixosConfigurations\." flake.nix | grep -o '[a-zA-Z0-9_]*\s*=' | sed 's/\s*=.*//' | sed 's/^/  - /'
    exit 1
fi
