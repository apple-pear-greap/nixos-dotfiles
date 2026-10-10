{ config, pkgs, ... }:
{
  home.packages = [ pkgs.kitty ];
  xdg.configFile.kitty = config.my.xdg.creatSymlink "kitty";
}
