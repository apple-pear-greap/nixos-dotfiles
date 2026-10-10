{ config, lib, ... }:
{
  options.my.gaming.enable = lib.mkEnableOption "Steam gaming support";

  config = lib.mkIf config.my.gaming.enable {
    programs.steam.enable = true;
  };
}
