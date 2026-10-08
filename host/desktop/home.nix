{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ../../home-modules/core.nix
    ../../home-modules/x11.nix
    ../../home-modules/wayland.nix
  ];
  home.username = "yuan";
  home.homeDirectory = "/home/yuan";
  home.packages = with pkgs; [
    adwaita-icon-theme
    protonplus
    gamescope
    spotify
    pkg-config
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NNN_FIFO = "/tmp/nnn.fifo";
  };

  programs.chromium = {
    enable = true;
  };

  home.stateVersion = "26.05";
}
