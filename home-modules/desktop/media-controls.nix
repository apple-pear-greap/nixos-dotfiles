{ pkgs, ... }:
{
  # MPRIS commands used by the media keys in Niri and other desktop sessions.
  home.packages = [ pkgs.playerctl ];
}
