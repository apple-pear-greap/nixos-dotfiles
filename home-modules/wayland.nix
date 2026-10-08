{
  inputs,
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
  imports = [
    ./wm/sway.nix
  ];
  options.my.hm.wayland = {
    enable = mkEnableOption "My home manager wayland config";
    wm = mkOption {
      type = types.enum [
        "hyprland"
        "sway"
        "mango"
      ];
      default = "sway";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # wallpapers
      swaybg

      # terminal
      foot
      kitty

      # app launchaer
      rofi

      # clip
      wl-clipboard
      cliphist

      # screen shot
      grim
      slurp
    ];

    programs.waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.system}.waybar;
    };
    xdg.configFile.waybar = config.my.xdg.creatSymlink "waybar";
  };
}
