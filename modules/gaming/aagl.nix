{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.aagl.nixosModules.default ];

  options.my.gaming.aagl.enable = lib.mkEnableOption "AAGL game launchers and Wine tools";

  config = lib.mkIf config.my.gaming.aagl.enable {
    nix.settings = inputs.aagl.nixConfig;
    programs.anime-game-launcher.enable = true;
    programs.honkers-railway-launcher.enable = true;
    programs.sleepy-launcher.enable = true;

    environment.systemPackages = with pkgs; [
      wineWow64Packages.stable
      winetricks
    ];
  };
}
