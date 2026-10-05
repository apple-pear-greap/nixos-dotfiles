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
  imports = [
    ./suckless.nix
  ];
  options.my.hm.x11 = {
    enable = mkEnableOption "My home manager x11 config";
    wm = mkOption {
      type = types.enum [
        "dwm"
        "i3"
      ];
      default = "dwm";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      feh
      xclip
      xrandr
      xwallpaper
    ];
  };
}
