{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.hm.kitty.enable = lib.mkEnableOption "Kitty with repository configuration";

  config = lib.mkIf config.my.hm.kitty.enable {
    home.packages = [ pkgs.kitty ];
    xdg.configFile.kitty = config.my.xdg.creatSymlink "kitty";
  };
}
