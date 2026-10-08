{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.my.x11;
in
{
  config = mkIf (cfg.enable && cfg.wm == "dwm") {
    services.xserver.windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ../../config/dwm;
      };
    };
  };
}
