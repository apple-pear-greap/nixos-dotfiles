{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.my.hm.wayland;
in
{
  imports = [
  ];
  config = mkIf (cfg.enable && cfg.wm == "niri") {
    home.packages = with pkgs; [
      alacritty
      xwayland-satellite
    ];

    xdg.configFile.niri = config.my.xdg.creatSymlink "niri";
  };
}
