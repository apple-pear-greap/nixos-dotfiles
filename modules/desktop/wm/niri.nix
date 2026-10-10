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
  config = mkIf (cfg.enable && cfg.wm == "niri") {
    programs.niri = {
      enable = true;
    };
  };
}
