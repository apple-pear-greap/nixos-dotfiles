{ config, pkgs, ... }:

{
  # Networking
  networking.networkmanager.enable = true;

  # Nix configuration
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
  ];

  # Nix version
  system.stateVersion = "25.11";
}
