{
  config,
  lib,
  pkgs-unstable,
  ...
}:
{
  options.my.gaming.performance.enable = lib.mkEnableOption "Extra Proton packages and GameMode";

  config = lib.mkIf config.my.gaming.performance.enable {
    my.gaming.enable = true;
    programs.steam.extraCompatPackages = [
      pkgs-unstable.dwproton-bin
      pkgs-unstable.proton-ge-bin
    ];
    programs.gamemode.enable = true;
  };
}
