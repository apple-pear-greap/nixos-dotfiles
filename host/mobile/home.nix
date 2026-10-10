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
    ../../home-modules/kitty.nix
  ];
  my.hm.x11 = {
    enable = true;
    wm = "dwm";
  };
  my.hm.wayland = {
    enable = false;
    wm = "sway";
  };

}
