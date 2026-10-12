{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.my.hm.x11;
  chatgptBlock = pkgs.writeShellApplication {
    name = "sb-chatgpt";
    runtimeInputs = [ pkgs.python3 ];
    text = ''
      exec python3 ${../../../scripts/sb-chatgpt} "$@"
    '';
  };
in
{
  config = mkIf (cfg.enable && cfg.wm == "dwm") {
    home.packages = with pkgs; [
      chatgptBlock
      (pkgs.st.overrideAttrs (oldAttrs: {
        src = ../../../config/st;
        patches = [ ];
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
          imlib2
          zlib
        ];
      }))
      (pkgs.dmenu.overrideAttrs (_: {
        src = ../../../config/dmenu;
        patches = [ ];
      }))
      (pkgs.dwmblocks.overrideAttrs (_: {
        # 这里直接手动提供修补后的 postPatch
        postPatch = ''
          cp ${../../../config/dwmblocks/blocks.def.h} blocks.def.h

          substituteInPlace dwmblocks.c \
            --replace-fail 'void termhandler()' 'void termhandler(int signum)'
        '';
      }))
    ];
  };
}
