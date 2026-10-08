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
        src = ../../config/st;
        patches = [ ];
      }))
      (pkgs.dmenu.overrideAttrs (_: {
        src = ../../config/dmenu;
        patches = [ ];
      }))
      (pkgs.dwmblocks.overrideAttrs (_: {
        # 这里直接手动提供修补后的 postPatch
        postPatch = ''
          cp ${../../config/dwmblocks/blocks.def.h} blocks.def.h

          substituteInPlace dwmblocks.c \
            --replace-fail 'void termhandler()' 'void termhandler(int signum)'
        '';
      }))
    ];
  };
}
