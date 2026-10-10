{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    jq
    lazygit
    bat
    ffmpegthumbnailer
    glow
    chafa
    ffmpeg
    sxiv
    brightnessctl
    fastfetch
    pkgs-unstable.fetch
    tree
    btop
  ];
}
