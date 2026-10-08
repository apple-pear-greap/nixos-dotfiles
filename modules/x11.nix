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
  imports = [
    ./wm/dwm.nix
  ];
  options.my.x11 = {
    enable = mkEnableOption "X11 environment";
    wm = mkOption {
      type = types.enum [
        "dwm"
        "i3"
      ];
      default = "dwm";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
    };
    services.xserver.displayManager.lightdm.enable = false;
    services.displayManager.ly.enable = true;
  };
}
