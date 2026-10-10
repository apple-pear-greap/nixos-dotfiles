{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.my.wayland;
in
{
  config = mkIf (cfg.enable && cfg.wm == "sway") {
    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
    };
  };
}
