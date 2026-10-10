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
  imports = [
    ./wm/sway.nix
    ./wm/niri.nix
  ];
  options.my.wayland = {
    enable = mkEnableOption "Wayland environment";
    wm = mkOption {
      type = types.enum [
        "sway"
        "hyprland"
        "niri"
      ];
      default = "sway";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.lightdm.enable = false;
    services.displayManager.ly.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };
}
