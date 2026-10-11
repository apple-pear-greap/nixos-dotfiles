{ pkgs, ... }:
{
  home.packages = with pkgs; [
    adwaita-icon-theme
    kdePackages.okular
    pamixer
    pavucontrol
    pulsemixer
    bluetui
    wechat
  ];
}
