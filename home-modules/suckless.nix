{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.my.hm.x11;
in
{
  config = mkIf (cfg.enable && cfg.wm == "dwm") {
    home.packages = with pkgs; [
      (pkgs.st.overrideAttrs (_: {
        src = ../config/st;
        patches = [ ];
      }))
      (pkgs.dmenu.overrideAttrs (_: {
        src = ../config/dmenu;
        patches = [ ];
      }))
      (pkgs.dwmblocks.overrideAttrs (_: {
        conf = ../config/dwmblocks/blocks.def.h;
        patches = [ ];
      }))
    ];
  };
}
