# Template for second NixOS machine
# Copy this file and customize for your second machine

{ config, pkgs, inputs, ... }:

{
  imports = [
    # Replace with your second machine's hardware-configuration.nix path
    # ../../hardware-configuration-machine2.nix
    ../../modules/core/boot.nix
    ../../modules/core/localization.nix
    ../../modules/core/fonts.nix
    ../../modules/core/input-method.nix
    ../../modules/core/system.nix
    ../../modules/services/daed.nix
    ../../modules/services/desktop.nix
    ../../modules/services/multimedia.nix
    # Choose appropriate hardware modules for your machine:
    # ../../modules/hardware/intel.nix
    # ../../modules/hardware/amd.nix  (you can create this)
    ../../modules/hardware/power-management.nix
  ];

  networking.hostName = "nixos-machine2";

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "iHD";  # Change to appropriate driver for your GPU
    MOZ_ENABLE_WAYLAND = "1";
  };
}
