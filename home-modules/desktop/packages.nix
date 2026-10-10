{ pkgs, ... }:
{
  home.packages = with pkgs; [
    adwaita-icon-theme
    spotify
    kdePackages.okular
    pamixer
    pavucontrol
    pulsemixer
    bluetui
    wechat
  ];
}
