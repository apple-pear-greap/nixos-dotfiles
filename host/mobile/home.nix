{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ../../home-modules/core.nix
    ../../home-modules/mpv.nix
    ../../home-modules/x11.nix
    ../../home-modules/wayland.nix
  ];
  home.username = "yuan";
  home.homeDirectory = "/home/yuan";
  home.packages = with pkgs; [
    adwaita-icon-theme
    spotify

    pkg-config
  ];

  my.hm.x11 = {
    enable = true;
    wm = "dwm";
  };
  my.hm.wayland = {
    enable = false;
    wm = "sway";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = {
      name = "JetBrainsMonoNL NFP";
      size = 14;
    };
    settings = {
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.3";
      cursor_trail_start_threshold = 3;

      background_opacity = 0.8;
    };
  };

  home.stateVersion = "26.05";
}
