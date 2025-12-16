{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../hardware-configuration.nix
    ../../modules/core/boot.nix
    ../../modules/core/localization.nix
    ../../modules/core/fonts.nix
    ../../modules/core/input-method.nix
    ../../modules/core/system.nix
    ../../modules/services/daed.nix
    ../../modules/services/desktop.nix
    ../../modules/services/multimedia.nix
    ../../modules/services/ssh.nix
    ../../modules/hardware/intel.nix
    ../../modules/hardware/power-management.nix
  ];

  networking.hostName = "nixos";

  # User account
  users.users.cerydra = {
    isNormalUser = true;
    description = "Cerydra";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO//GYtVPFgC08ziOwn+8+ZwJqOcIwGkemNZJYFJjZ/a hysilens@csu.edu.cn"
    ];
  };

  # Shell configuration
  programs.zsh.enable = true;

  # Unfree packages
  nixpkgs.config.allowUnfree = true;

  # Environment variables (Wayland/GPU)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "iHD";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
