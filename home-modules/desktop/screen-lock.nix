{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.hm.wayland.enable {
    home.packages = [ pkgs.swaylock-effects ];
    xdg.configFile.swaylock = config.my.xdg.creatSymlink "swaylock";
  };
}
