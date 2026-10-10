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
  home.stateVersion = "26.05";
  my.hm.kitty.enable = true;
  my.hm.x11.enable = false;
  my.hm.wayland = {
    enable = true;
    wm = "niri";
  };
  home.packages = with pkgs; [
    protonplus
    gamescope
  ];
  home.sessionVariables = {
    NNN_FIFO = "/tmp/nnn.fifo";
  };

  programs.chromium = {
    enable = true;
  };
}
