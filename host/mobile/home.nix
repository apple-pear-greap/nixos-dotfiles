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
  ];
  home.username = "yuan";
  home.homeDirectory = "/home/yuan";
  home.packages = with pkgs; [
    jq
    fastfetch
    tree
    rofi
    adwaita-icon-theme
    btop
    pavucontrol
    lazygit
    pamixer
    gamescope
    bluetui
    spotify

    foot
    swaybg

    pkg-config
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.waybar;
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
