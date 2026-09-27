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
  ];
  home.username = "yuan";
  home.homeDirectory = "/home/yuan";
  home.packages = with pkgs; [
    jq
    fastfetch
    tree
    swaybg
    foot
    rofi
    adwaita-icon-theme
    wl-clipboard
    cliphist
    btop
    protonplus
    pavucontrol
    lazygit
    pamixer
    gamescope
    bluetui
    spotify
    pkg-config
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.chromium = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.waybar;
  };

  home.stateVersion = "26.05";
}
