{
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
  config = mkIf (cfg.enable && cfg.wm == "sway") {
    home.packages = with pkgs; [
      swayidle
      swaylock
    ];
    xdg.configFile.sway = config.my.xdg.creatSymlink "sway";
  };
}
