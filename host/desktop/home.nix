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
  ];
  my.hm.x11.enable = false;
  my.hm.wayland = {
    enable = true;
    wm = "niri";
  };
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
