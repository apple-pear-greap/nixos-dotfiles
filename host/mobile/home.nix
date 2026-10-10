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
  my.hm.x11 = {
    enable = true;
    wm = "dwm";
  };
  my.hm.wayland = {
    enable = false;
    wm = "sway";
  };

}
