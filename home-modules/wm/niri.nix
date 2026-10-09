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
    inputs.noctalia.homeModules.default
  ];
  config = mkIf (cfg.enable && cfg.wm == "niri") {
    home.packages = with pkgs; [
      alacritty
      xwayland-satellite
    ];
    programs.noctalia = {
      enable = true;

      settings = { # This may also be a string or path to a .toml file.
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          default.path = "~/nixos-config/wallpapers/VodOdetta.jpg";
        };
      };
    };

    xdg.configFile.niri = config.my.xdg.creatSymlink "niri";
  };
}
